// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrTag.m instead.

#import "_KGFlickrTag.h"

const struct KGFlickrTagAttributes KGFlickrTagAttributes = {
	.complexTag = @"complexTag",
	.tagValue = @"tagValue",
};

const struct KGFlickrTagRelationships KGFlickrTagRelationships = {
	.item = @"item",
};

const struct KGFlickrTagFetchedProperties KGFlickrTagFetchedProperties = {
};

@implementation KGFlickrTagID
@end

@implementation _KGFlickrTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FlickrTag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FlickrTag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FlickrTag" inManagedObjectContext:moc_];
}

- (KGFlickrTagID*)objectID {
	return (KGFlickrTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"complexTagValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"complexTag"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic complexTag;



- (BOOL)complexTagValue {
	NSNumber *result = [self complexTag];
	return [result boolValue];
}

- (void)setComplexTagValue:(BOOL)value_ {
	[self setComplexTag:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveComplexTagValue {
	NSNumber *result = [self primitiveComplexTag];
	return [result boolValue];
}

- (void)setPrimitiveComplexTagValue:(BOOL)value_ {
	[self setPrimitiveComplexTag:[NSNumber numberWithBool:value_]];
}





@dynamic tagValue;






@dynamic item;

	






@end
