//
//  KGCoreDataObject.m
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


#import "KGCoreDataObject.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface KGCoreDataObject ()

+ (NSManagedObjectContext *) getInternalContext;
+ (Class) getPropertyType:(NSString *)propertyName;

@end


@implementation KGCoreDataObject

NSString * const kKGCoreDataManagedObjectContext = @"KGCoreDataManagedObjectContext";

- (id) init
{
	self = [[self class] newCoreDataObject];
	return self;
}

+ (id) newCoreDataObject
{	
	id retObj = nil;
	NSString *className = NSStringFromClass(self);

	NSManagedObjectContext *context = [[self class] getInternalContext];
	if ( context != nil )
		retObj = [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
	
	return retObj;
}


+ (NSSet *) propertiesForEntity:(NSManagedObject *)entity
{
	NSEntityDescription *entityDesc = [entity entity];
	return [NSSet setWithArray:[[entityDesc propertiesByName] allKeys]];
}

- (NSArray *) arrayItemsForProperty:(NSString *)propertyName
{
	NSString *entityArrayName = [propertyName stringByAppendingString:@"Array"];
	Class arrayType = [[self class] getPropertyType:propertyName];
	
	NSDictionary *managedProperties = [[self entity] relationshipsByName];
	NSRelationshipDescription *arrayRelation = [managedProperties objectForKey:entityArrayName];
	
	NSEntityDescription *destinationType = [arrayRelation destinationEntity];
	
	Class destinationClass = NSClassFromString([destinationType managedObjectClassName]);
	
	NSSet *valuesHeld = [self valueForKey:entityArrayName];
	
	NSArray *sortedValues = [[valuesHeld allObjects] sortedArrayUsingDescriptors:
							 [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES]]];
	
	NSArray *retArray = nil;
	if ( [arrayType isEqual:destinationClass] )
	{
		// then we can just get out the objects as-is, being on the lookout for that superclass!
		// Note that we sort by the index key, which must exist.
		retArray = sortedValues;
	}
	else
	{
		// We have to extract the value into our own object type, by copying out properties
		NSMutableArray *convertArray = [NSMutableArray arrayWithCapacity:valuesHeld.count];
		
		//TODO: Copy object properties from one place to another
		// For now:  special case NSString...
		if ( [arrayType isKindOfClass:[NSString class]] )
		{
			for ( id object in sortedValues )
			{
				NSString *newString = [object valueForKey:@"string"];
				[convertArray addObject:newString];
			}
		}
		retArray = convertArray;
	}
	return retArray;
}

- (void) storeArray:(NSArray *)objects forProperty:(NSString *)propertyName 
{
	// We are going to replace any existing objects, with a new set of objects for this property.
	NSString *entityArrayName = [propertyName stringByAppendingString:@"Array"];

	// Early bail for a special case of clearing an array.
	if ( objects.count == 0 )
	{
		[self setValue:nil forKey:entityArrayName];
		return;
	}
	
	Class arrayType = [[self class] getPropertyType:propertyName];
	
	NSDictionary *managedProperties = [[self entity] relationshipsByName];
	NSRelationshipDescription *arrayRelation = [managedProperties objectForKey:entityArrayName];
	
	NSEntityDescription *destinationType = [arrayRelation destinationEntity];
	
	NSDictionary *destProperties = [destinationType relationshipsByName];
	NSString *foundKey = nil;
	NSEntityDescription *selfEntityDesc = [self entity];
	for ( NSString *key in [destProperties allKeys] )
	{
		NSRelationshipDescription *relation = [destProperties objectForKey:key];
		if ( [[relation destinationEntity] isEqual:selfEntityDesc] )
		{
			foundKey = key;
			break;
		}
	}
	
	Class destinationClass = NSClassFromString([destinationType managedObjectClassName]);
	
	// Can't use capitalize as it destroys camel-case.
	NSString *capitalStringName = [foundKey stringByReplacingCharactersInRange:NSMakeRange(0,1)  
																	withString:[[foundKey substringToIndex:1] uppercaseString]];
	NSString *addRefKey = [NSString stringWithFormat:@"add%@Object:",capitalStringName];
	
	NSSet *saveSet;
	
	if ( [arrayType isEqual:destinationClass] )
	{
		// we can just make a set of objects with what we have, 
		// being careful to set index values and back references...
		saveSet = [NSSet setWithArray:objects];
		NSUInteger count = 0;
		for ( id object in saveSet )
		{
			[object setValue:[NSNumber numberWithInt:count] forKey:@"index"];
			if ( foundKey )
			{
				// Clear out all prior entries (probably none)
				[object setValue:nil forKey:foundKey];
				// Now set our one reference
				[object performSelector:NSSelectorFromString(addRefKey) withObject:self];
			}
			count++;
		}
		
	}
	else
	{
		// For now, just handle NSString case
		NSMutableSet *saveChangeSet = [NSMutableSet setWithCapacity:objects.count];
		NSUInteger count = 0;
		NSManagedObjectContext *context = [[self class] getInternalContext];
		NSString *destinationClassName = [destinationType managedObjectClassName];
		for ( id object in objects )
		{
			NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:destinationClassName inManagedObjectContext:context];
			// set our string to save...
			[object setValue:object forKey:@"string"];
			
			[object setValue:[NSNumber numberWithInt:count] forKey:@"index"];
			if ( foundKey )
			{
				// Clear out all prior entries (probably none)
				[object setValue:nil forKey:foundKey];
				// Now set our one reference
				[object performSelector:NSSelectorFromString(addRefKey) withObject:self];
			}
		
			count++;
			[saveChangeSet addObject:object];
		}
		saveSet = saveChangeSet;
	}

	// Finally, actually push the whole set out to the property
	[self setValue:saveSet forKey:entityArrayName];
}

- (void) saveContext
{
	NSManagedObjectContext *context = [[self class] getInternalContext];
	NSError *error;
	[context save:&error];
	if ( error )
		NSLog(@"Error in object %@ save: %@", self, error );
}

+ (void) useManagedContext:(NSManagedObjectContext*)context
{
	NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
	[threadDictionary setObject:context forKey:kKGCoreDataManagedObjectContext];
}

#pragma mark -
#pragma mark Helper methods

+ (Class) getPropertyType:(NSString *)propertyName
{
	Class type = nil;
	NSString * propertyTypeSelName = [propertyName stringByAppendingString:@"Type"];
	SEL useSelector = NSSelectorFromString(propertyTypeSelName);
	if ( [self respondsToSelector:useSelector] )
	{
		type = [self performSelector:useSelector];
	}
	return type;
}

+ (NSManagedObjectContext *) getInternalContext
{
	NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
	NSManagedObjectContext *context = [threadDictionary objectForKey:kKGCoreDataManagedObjectContext];
	
	if ( context == nil )
	{
		// Since most projects are set up the same way from templates, just see if the app delegate has
		// our context (99% of the time it will)
		id <UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
		if ( [appDelegate respondsToSelector:@selector(managedObjectContext)] )
		{
			id context = [appDelegate performSelector:@selector(managedObjectContext)];
			if ( context != nil )
			{
				[self useManagedContext:context];
				return context;
			}
		}
	}
	
	return context;
}

@end
