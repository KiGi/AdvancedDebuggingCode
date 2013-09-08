//
//  KGCoreDataObject.h
//  KGFrameworkDemo
//
//  Created by Kendall Gelner on 2/13/10.
//  Copyright 2010 KiGi Software. All rights reserved.
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


// Base object for core data destined objects, that has two interesting properties:

// 1) calls to init will create the proper CoreData managed object
// 2) convienience methods to fill array properties with Core Data links to entities with indexes,
//    or to save arrays to a matching core data entity with an index.
// 

// Note that you must call the + useManageContext: call before using any of these features, within
// the thread that will make use of the object.   To keep things simple, keep all object operations
// On the main thread.

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

extern NSString * const kKGCoreDataManagedObjectContext;

@interface KGCoreDataObject : NSManagedObject 

// Gets out matching items for the property from a saved reference link
// named "<property name>Array".  The array will be ordered to match the "index"
// property of that entity where the holding ref is our object.
- (NSArray *) arrayItemsForProperty:(NSString *)propertyName;

// Stores away an array of objects by building an entity (if needed) and setting 
// the "index" property of the storing entity to the index of the item in the array.
- (void) storeArray:(NSArray *)objects forProperty:(NSString *)propertyName;

// Convienience - tells the context to save values.
- (void) saveContext;

+ (id) newCoreDataObject;

+ (NSSet *) propertiesForEntity:(NSManagedObject *)entity;

+ (void) useManagedContext:(NSManagedObjectContext*)context;

@end
