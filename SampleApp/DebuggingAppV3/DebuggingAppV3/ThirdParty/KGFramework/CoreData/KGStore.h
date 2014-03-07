//
//  EMStore.h
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


#import <Foundation/Foundation.h>
#import "NSManagedObject+KGStore.h"

@interface KGStore : NSObject

@property (atomic) BOOL canceled;

+ (KGStore *)sharedInstance;

// Stores the database into the given path with the optional database name (appdata.sqlite is used otherwise).
- (void)setupCoreDataStackWithStorePathURL:(NSURL *)storeURL;
- (void)setupCoreDataStackWithStorePathURL:(NSURL *)storeURL dbName:(NSString *)dbName;

- (void)tearDownCoreDataStack;

// Returns the context valid for the current thread.
- (NSManagedObjectContext *)context;

// Generic save operation that protects against fault
- (BOOL)save;
+ (void)save;

@end
