//
//  EMStore.m
//
//  Created by Bruce Geerdes on 2/13/13.
//  Copyright 2013 KiGi Software. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "KGStore.h"

static KGStore *_sharedInstance;
static NSString *const kDBName = @"appdata.sqlite";

@implementation KGStore
{
	NSManagedObjectModel *_model;
	NSPersistentStoreCoordinator *_coordinator;
	
	NSManagedObjectContext *mainContext;
}

#pragma mark -

+ (void)initialize
{
	if (_sharedInstance == nil) {
		_sharedInstance = [KGStore new];
	}
}

+ (KGStore *)sharedInstance
{
	return _sharedInstance;
}

+ (void)save
{
	[[self sharedInstance] save];
}

#pragma mark -

- (NSManagedObjectModel *)model
{
	if (_model == nil) {
        //		NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        //		_model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
	}
	
	return _model;
}

- (NSPersistentStoreCoordinator *)coordinator
{
	if (_coordinator == nil) {
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
	}
	
	return _coordinator;
}

- (void)setupCoreDataStackWithStorePathURL:(NSURL *)storeURL
{
    [self setupCoreDataStackWithStorePathURL:storeURL dbName:kDBName];
}


- (void)setupCoreDataStackWithStorePathURL:(NSURL *)storeURL dbName:(NSString *)dbName
{
	storeURL = [storeURL URLByAppendingPathComponent:dbName]; // append db name
	    
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, 
							 nil];
    NSError *error = nil;
    if (![[self coordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
													URL:storeURL options:options error:&error])
	{
		NSLog(@"error opening persistant store, removing");
		
		error = nil;
		if (![[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error]) {
			NSLog(@"error removing persistant store %@, giving up", storeURL);
		} else if (![[self coordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL
														   options:options error:&error])
		{
			NSLog(@"error opening persistant store, giving up");
		}
	}
	
	if (error) {
		mainContext = nil;
	} else {
		mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[mainContext setPersistentStoreCoordinator:[self coordinator]];
		[mainContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
	}
}

- (void)tearDownCoreDataStack
{
	[mainContext reset];
    mainContext = nil;
	
    _model = nil;
    _coordinator = nil;
}

#pragma mark -

- (NSManagedObjectContext *)newContext
{
	NSManagedObjectContext *newContext = [[NSManagedObjectContext alloc] init];	
	[newContext setPersistentStoreCoordinator:[self coordinator]];
	[newContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
	
	// notification to merge background context changes into main context
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSave:)
												 name:NSManagedObjectContextDidSaveNotification object:newContext];
	
	return newContext;
}

- (NSManagedObjectContext *)context
{
	NSManagedObjectContext *context = nil;
	
	if ([NSThread isMainThread]) {
		context = mainContext;
	} else {
		static NSString *VCIStoreContext;
		if (!VCIStoreContext) VCIStoreContext = @"VCIStoreContext";
		
		// get/create context for background thread
		NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
		context = [threadDictionary objectForKey:VCIStoreContext];
		if (context == nil) {
			context = [self newContext];
			[threadDictionary setObject:context forKey:VCIStoreContext];
		}
	}
	
	return context;
}

- (void)contextDidSave:(NSNotification *)notification
{
	[mainContext performBlock:^{
		[mainContext mergeChangesFromContextDidSaveNotification:notification];
	}];
}

- (BOOL)save
{
	BOOL success;
	
    NSError *error = nil;
    @try {
        success = [[self context] save:&error];
    }
    @catch (NSException *exception) {
        // This handles the case of exception causing events like validation failures that would otherwise
        // crasp the app.
        NSLog(@"Exception in CoreData save:\n%@\nUserInfo:\n%@", exception, exception.userInfo);
    }
	
    if (!success) {
        NSLog(@"%@", error.localizedDescription);
    }

	return success;
}

@end
