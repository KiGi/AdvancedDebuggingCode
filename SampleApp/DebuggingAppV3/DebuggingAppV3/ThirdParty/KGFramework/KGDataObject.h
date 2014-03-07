//
//  KGDataObject.h
//  KGFramework
//
//  Created by Kendall Gelner on 1/24/10.
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



// Methods to help work with pure data objects (classes meant to hold data with no other properties).  You can also have
// data objects inherit from this class to gain some useful abilities like auto-printing properties in the description.

#import <Foundation/Foundation.h>

// This is a marker interface, to indicate this object is something that can and should be mapped
// when walking object trees.  If you have only top level objects you do not need to use this, but if 
// you have an object used as a sub-object of a class you intend to map you should indicate it supports
// this protocol to have mapping work correctly.
@protocol KGDataObject
@end


@interface KGDataObject : NSObject <KGDataObject>

// Typical propert names look like "myValue", but often in data transfer or databases the convention is "my_property".  
// This converts all class property names into the equivilient data transfer names, and returns a map where the keys are the
// data transfer names (so that you can easily map incoming data streams to objects).  If you are going to use this often the
// results should be cached.
// The code here will also map superclass properties, except for NSObject.
// Example name mappings are:
// myProperty -> my_property
// userID -> user_id
+ (NSDictionary *) mapPropertyNamesToDataTransferNameForClass:(Class)dataClass;

// This adds a specific mapping of a property to a data transfer name with the specified type. 
// Use this to set a different mapping, or to force use of a special type.
+ (void) addPropertyMapping:(NSString *)propName dataTransferName:(NSString *)dataTransferName classType:(Class)dataType toDictionary:(NSMutableDictionary *)propMap;

// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString *) autoDescribe:(id)instance;

+ (NSDictionary *) dictionaryForInstanceProperties:(id)instance;
// Lets you specify a superclass where you stop copying properties from.
+ (NSDictionary *) dictionaryForInstanceProperties:(id)instance stopClass:(Class) class;

// A helper method to let you construct a Core Data object by class rather than a name
+ (id) initCoreDataObjectWithClass:(Class)class NSManagedObjectContext:managedObjectContext;

// Copies any properties from one place to another.  If you want it to copy properties of any sub objects, 
// the object must already exist in the destination AND either the source or destination sub-object must
// claim it implements the KGDataObject marker protocol.
+ (void) copyByPropertyFromObject:(id)source toObject:(id)destination;

// This looks for any properties in the destination instance that have correspondingly named 
// values in the dictionary, then sets the properties to those values.
+ (void) populatePropertiesForObject:(id)destination fromDictionary:(NSDictionary *)propertyValues stopClass:(Class)rootClass;

@end
