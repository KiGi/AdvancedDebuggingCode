// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DAVCTracker.m instead.

#import "_DAVCTracker.h"

@implementation DAVCTrackerID
@end

@implementation _DAVCTracker

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"VCTracker" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"VCTracker";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"VCTracker" inManagedObjectContext:moc_];
}

- (DAVCTrackerID*)objectID {
	return (DAVCTrackerID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"VCLengthAccessedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"VCLengthAccessed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic VCLengthAccessed;



- (double)VCLengthAccessedValue {
	NSNumber *result = [self VCLengthAccessed];
	return [result doubleValue];
}

- (void)setVCLengthAccessedValue:(double)value_ {
	[self setVCLengthAccessed:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveVCLengthAccessedValue {
	NSNumber *result = [self primitiveVCLengthAccessed];
	return [result doubleValue];
}

- (void)setPrimitiveVCLengthAccessedValue:(double)value_ {
	[self setPrimitiveVCLengthAccessed:[NSNumber numberWithDouble:value_]];
}





@dynamic VCName;






@dynamic trackingID;










@end
