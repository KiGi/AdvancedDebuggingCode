//
//  NSManagedObject+EMStore.m
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

#import "NSManagedObject+KGStore.h"
#import "KGStore.h"

@implementation NSManagedObject (KGStore)

#pragma mark -

+ (NSString *)mogenEntityName
{
	NSString *entityName = nil;
	
	if ([self respondsToSelector:@selector(entityName)]) {
		entityName = [self performSelector:@selector(entityName)];
	} else {
		NSLog(@"error getting entity name, managed object %@ not generated by mogen?", [self class]);
	}
	
	return entityName;
}

+ (id)create
{
	return [NSEntityDescription insertNewObjectForEntityForName:[self mogenEntityName]
										 inManagedObjectContext:[[KGStore sharedInstance] context]];
}


- (void)delete
{
	[[[KGStore sharedInstance] context] deleteObject:self];
}

#pragma mark -

- (id)objectInCurrentThreadContext
{
	NSError *error = nil;
	id object = [[[KGStore sharedInstance] context] existingObjectWithID:[self objectID] error:&error];
	
	if (!object) {
		NSLog(@"expected to find object: %@", error);
	}
	
	return object;
}


#pragma mark -

+ (NSArray *)findAllWithRequest:(NSFetchRequest *)request
{
	NSArray *results = nil;
	
	NSError *error = nil;
	results = [[[KGStore sharedInstance] context] executeFetchRequest:request error:&error];
	if (error) {
		NSLog(@"error executing request: %@", error);
	}
	
	return results;
}

+ (NSArray *)findAll
{
	return [self findAllWithPredicate:nil sortDescriptors:nil];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate
{
	return [self findAllWithPredicate:predicate sortDescriptors:nil];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self mogenEntityName]];
	request.predicate = predicate;
	request.sortDescriptors = sortDescriptors;
	
	return [self findAllWithRequest:request];
}

+ (NSArray *)findAllWithSortDescriptors:(NSArray *)sortDescriptors
{
	return [self findAllWithPredicate:nil sortDescriptors:sortDescriptors];
}

#pragma mark -

+ (id)findFirst
{
	return [self findFirstWithPredicate:nil sortDescriptors:nil];
}

+ (id)findFirstWithPredicate:(NSPredicate *)predicate
{
	return [self findFirstWithPredicate:predicate sortDescriptors:nil];
}

+ (id)findFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self mogenEntityName]];
	request.predicate = predicate;
	request.sortDescriptors = sortDescriptors;
	request.fetchLimit = 1;
	
	return [[self findAllWithRequest:request] lastObject];
}

+ (id)findFirstWithSortDescriptors:(NSArray *)sortDescriptors
{
	return [self findFirstWithPredicate:nil sortDescriptors:sortDescriptors];
}

@end
