//
//  NSManagedObject+EMStore.h
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

#import <CoreData/CoreData.h>

@interface NSManagedObject (KGStore)

// creates an object in the current thread context.
+ (id)create;

// Deletes this object instance from the database
- (void)delete;

// Returns a version of this object instance valid in the current thread.
- (id)objectInCurrentThreadContext;

// Returns an array of all object instances (any of which may hold faults), if you want a specific batch size
// use findAllWithRequest.
+ (NSArray *)findAll;
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+ (NSArray *)findAllWithSortDescriptors:(NSArray *)sortDescriptors;
+ (NSArray *)findAllWithRequest:(NSFetchRequest *)request;

// Returns the first item of any request only.  Batch size of one automatically applied for performance.
+ (id)findFirst;
+ (id)findFirstWithPredicate:(NSPredicate *)predicate;
+ (id)findFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+ (id)findFirstWithSortDescriptors:(NSArray *)sortDescriptors;

@end
