// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGLocationSaveItem.m instead.

#import "_KGLocationSaveItem.h"

const struct KGLocationSaveItemAttributes KGLocationSaveItemAttributes = {
	.lattitude = @"lattitude",
	.locationDescription = @"locationDescription",
	.longitude = @"longitude",
};

const struct KGLocationSaveItemRelationships KGLocationSaveItemRelationships = {
};

const struct KGLocationSaveItemFetchedProperties KGLocationSaveItemFetchedProperties = {
};

@implementation KGLocationSaveItemID
@end

@implementation _KGLocationSaveItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LocationSaveItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LocationSaveItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LocationSaveItem" inManagedObjectContext:moc_];
}

- (KGLocationSaveItemID*)objectID {
	return (KGLocationSaveItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"lattitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lattitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic lattitude;



- (float)lattitudeValue {
	NSNumber *result = [self lattitude];
	return [result floatValue];
}

- (void)setLattitudeValue:(float)value_ {
	[self setLattitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLattitudeValue {
	NSNumber *result = [self primitiveLattitude];
	return [result floatValue];
}

- (void)setPrimitiveLattitudeValue:(float)value_ {
	[self setPrimitiveLattitude:[NSNumber numberWithFloat:value_]];
}





@dynamic locationDescription;






@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}










@end
