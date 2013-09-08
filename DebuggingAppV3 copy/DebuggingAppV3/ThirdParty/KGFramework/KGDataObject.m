//
//  KGDataObject.m
//  KGFrameworkDemo
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


#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import <CoreData/CoreData.h>

#import "KGDataObject.h"
#import "KGCoreDataObject.h"

//#import "KGCoreDataObject.h"


@implementation KGDataObject

#pragma mark -
#pragma mark Filwe stuff

#pragma mark -
#pragma mark Type 

Class parseTypeFromProperty( objc_property_t property );

static const char* getPropertyType(objc_property_t property) {
	
	
	
    const char *propAttrs = property_getAttributes(property);	
    char buffer[strlen(propAttrs) + 1];
	char *bufPtr = (char *)buffer;
    strcpy(buffer, propAttrs);
    char *attribute;
    while ((attribute = strsep(&bufPtr, ",")) != NULL) {
        if (attribute[0] == 'T') {
            // This returns an autoreleased block of data, omitting leading T
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute)] bytes];
        }
    }
	// This is the type for "id"
    return "@";
}

Class parseTypeFromProperty( objc_property_t property )
{
	Class retClass = [NSNull class];  // default is do not map type
	const char *typeName = getPropertyType(property);
	int propLen = strlen(typeName);
	if ( propLen > 0 )
	{
		if ( typeName[0] == '@' )
		{
			// Class type, figure out which class
			if ( propLen == 1 )
			{
				// Could be anything, so we'll just use this as a base.
				retClass = [NSObject class];				
			}
			else if ( propLen > 3 )
			{
				// Parse out class name
				char buffer[propLen+1];
				strcpy(buffer, typeName);
				char *classString = buffer+2;
				buffer[propLen-1] = '\0';
				retClass = NSClassFromString([NSString stringWithCString:classString encoding:NSASCIIStringEncoding]);
			}
		}
		else if (typeName[0] == '*')
		{
		    // Pointer, we are basically screwed - don't map type
		}
		else
		{
			// ALl other types we are going to treat as NSNumber
			retClass = [NSNumber class];
		}
	}
	return retClass;
}


+ (NSDictionary *) mapPropertyNamesToDataTransferNameForClass:(Class)dataClass
{
	NSUInteger count;
	objc_property_t *propList = class_copyPropertyList(dataClass, &count);
	NSMutableDictionary *propsConverted = [NSMutableDictionary dictionaryWithCapacity:count];
	
	for ( int i = 0; i < count; i++ )
	{
		objc_property_t property = propList[i];
        
		const char *propName = property_getName(property);
		
		NSString *finalString = nil;
		NSString *originalString = nil;
		
        if(propName) 
		{
			NSMutableString *workingString = [NSMutableString stringWithCString:propName encoding:NSASCIIStringEncoding];
			originalString = [workingString copy];
			NSCharacterSet *upperSet = [NSCharacterSet uppercaseLetterCharacterSet];
			
			NSRange searchRange = {0, workingString.length};
			NSRange replaceRange;
			
			NSInteger lastPosition = -1;
			
			// Find all uppercase segments, adding "_" before all of them
			do 
			{
				replaceRange = [workingString rangeOfCharacterFromSet:upperSet options:NSLiteralSearch range:searchRange];
				if ( replaceRange.location != NSNotFound && replaceRange.location != 0 )
				{
					if ( replaceRange.location - 1 != lastPosition )
						[workingString insertString:@"_" atIndex:replaceRange.location];
					replaceRange.location += 1;
					lastPosition = replaceRange.location;
				}
				searchRange.location = replaceRange.location + replaceRange.length;
				searchRange.length = workingString.length - searchRange.location;
			} while ( replaceRange.location != NSNotFound );
				
			finalString = [workingString lowercaseString];
		}
		
		if ( finalString != nil )
		{
			Class classType = parseTypeFromProperty(property);
			[KGDataObject addPropertyMapping:originalString dataTransferName:finalString classType:classType toDictionary:propsConverted];
		}
        originalString = nil;
    }
    free(propList);
	
	// Now see if we need to map any superclasses as well.
	Class superClass = class_getSuperclass( dataClass );
	if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
	{
		NSDictionary *superMap = [KGDataObject mapPropertyNamesToDataTransferNameForClass:superClass];
		[propsConverted addEntriesFromDictionary:superMap];
	}
	
	return propsConverted;
}

+ (void) addPropertyMapping:(NSString *)propName dataTransferName:(NSString *)dataTransferName classType:(Class)dataType toDictionary:(NSMutableDictionary *)propMap
{
	[propMap setObject:propName forKey:dataTransferName];
	[propMap setObject:dataType forKey:[dataTransferName stringByAppendingString:@"_classType"]];
}



// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString *) autoDescribe:(id)instance classType:(Class)classType
{
	NSUInteger count;
	objc_property_t *propList = class_copyPropertyList(classType, &count);
	NSMutableString *propPrint = [NSMutableString string];
	
	for ( int i = 0; i < count; i++ )
	{
		objc_property_t property = propList[i];
        
		const char *propName = property_getName(property);
		NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
		
        if(propName) 
		{
			id value = [instance valueForKey:propNameString];
			[propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, value]];
		}
	}
    free(propList);
		
	
	// Now see if we need to map any superclasses as well.
	Class superClass = class_getSuperclass( classType );
	if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
	{
		NSString *superString = [KGDataObject autoDescribe:instance classType:superClass];
		[propPrint appendString:superString];
	}
	
	return propPrint;
}
	
+ (NSString *) autoDescribe:(id)instance
{
	NSString *headerString = [NSString stringWithFormat:@"%@:%p:: ",[instance class], instance];
	return [headerString stringByAppendingString:[KGDataObject autoDescribe:instance classType:[instance class]]];
}

+ (NSDictionary *) dictionaryForInstanceProperties:(id)instance class:(Class)classType stopClasses:(NSSet *)stopClasses
{
	NSUInteger count;
	objc_property_t *propList = class_copyPropertyList(classType, &count);
	NSMutableDictionary *objectValues = [NSMutableDictionary dictionaryWithCapacity:count];
	
	for ( int i = 0; i < count; i++ )
	{
		objc_property_t property = propList[i];
        
		const char *propName = property_getName(property);
		NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
		
		if(propName) 
		{
			id value = [instance valueForKey:propNameString];
			if ( value != nil )
				[objectValues setObject:value forKey:propNameString];
		}
	}
	
	// Now see if we need to map any superclasses as well.
	Class superClass = class_getSuperclass( classType );
	if ( superClass != nil && 
		! [superClass isEqual:[NSObject class]] &&
		! [stopClasses containsObject:superClass] )
	{
		NSDictionary *superMap = [KGDataObject dictionaryForInstanceProperties:instance class:superClass stopClasses:stopClasses];
		[objectValues addEntriesFromDictionary:superMap];
	}
	
	
	return objectValues;
}

+ (NSDictionary *) dictionaryForInstanceProperties:(id)instance 
{
	NSSet *stopClasses = [NSSet setWithObjects:[NSObject class], [NSManagedObject class], nil];
	return [KGDataObject dictionaryForInstanceProperties:instance class:[instance class] stopClasses:stopClasses];
}

+ (NSDictionary *) dictionaryForInstanceProperties:(id)instance stopClass:(Class) class
{
	return [KGDataObject dictionaryForInstanceProperties:instance class:[instance class] stopClasses:[NSSet setWithObject:class]];
}


+ (id) initCoreDataObjectWithClass:(Class)class NSManagedObjectContext:managedObjectContext
{
	return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(class) inManagedObjectContext:managedObjectContext];
}

+ (NSSet *) cachedPropertyNameSetForClass:(Class)class stopClasses:(NSSet *)classes
{
	NSSet *destPropSet = nil;
	
	NSMutableDictionary *threadDict = [[NSThread currentThread] threadDictionary];
	
	NSString *className = NSStringFromClass(class);
	
	destPropSet = [threadDict objectForKey:className];
	
	if ( destPropSet == nil )
	{
		NSUInteger count;
		objc_property_t *propList = class_copyPropertyList(class, &count);
		NSMutableSet *buildSet = [NSMutableSet setWithCapacity:count];
		do 
		{
			for ( int i = 0; i < count; i++ )
			{
				objc_property_t property = propList[i];
				const char *propName = property_getName(property);
				NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
				[buildSet addObject:propNameString];
			} 
			class = class_getSuperclass( class );
			propList = class_copyPropertyList(class, &count);
		} while ( class != nil && 
				 ![classes containsObject:class] );
		
		destPropSet = buildSet;
		[threadDict setObject:destPropSet forKey:className];
		free(propList);
	}
	
	return destPropSet;
}

+ (void) copyByPropertyFromObject:(id)source toObject:(id)destination
{
	NSSet *stopClasses = [NSSet setWithObjects:[NSObject class], [NSManagedObject class], nil];

	NSSet *sourceSet;
	if ( [source isKindOfClass:[NSManagedObject class]] )
		sourceSet = [KGCoreDataObject propertiesForEntity:source];
	else
		sourceSet = [self cachedPropertyNameSetForClass:[source class] stopClasses:stopClasses];
	
			
	NSSet *destSet;
	
	if ( [destination isKindOfClass:[NSManagedObject class]] )
		destSet = [KGCoreDataObject propertiesForEntity:destination];
	else
		destSet = [self cachedPropertyNameSetForClass:[destination class] stopClasses:stopClasses];

	
	for ( NSString *propName in sourceSet )
	{
        if(propName && [destSet containsObject:propName]) 
		{
			id value = [source valueForKey:propName];
			
			if ( [value isKindOfClass:[NSNull class]] )
				value = nil;
			
			id currentValue = [destination valueForKey:propName];
			
			if ( [value conformsToProtocol:NSProtocolFromString(@"KGDataObject")] ||
				[currentValue conformsToProtocol:NSProtocolFromString(@"KGDataObject")])
			{
				[self copyByPropertyFromObject:value toObject:currentValue];
			}
			else
			{
				[destination setValue:value forKey:propName];
			}
		}
	}
}

+ (void) populatePropertiesForObject:(id)destination fromDictionary:(NSDictionary *)propertyValues stopClass:(Class)rootClass
{
	NSSet *destSet = [self cachedPropertyNameSetForClass:[destination class] stopClasses:[NSSet setWithObject:rootClass]];
	
	for ( NSString *propName in destSet )
	{
		id value = [propertyValues objectForKey:propName];
		
		if ( value != nil )
		{
			[destination setValue:value forKey:propName];
		}
	}
}



@end
