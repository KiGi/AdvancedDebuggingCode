// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DATabTracker.m instead.

#import "_DATabTracker.h"

@implementation DATabTrackerID
@end

@implementation _DATabTracker

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TabTracker" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TabTracker";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TabTracker" inManagedObjectContext:moc_];
}

- (DATabTrackerID*)objectID {
	return (DATabTrackerID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"tabNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tabNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic datePressed;






@dynamic trackingID;






@dynamic tabNumber;



- (int)tabNumberValue {
	NSNumber *result = [self tabNumber];
	return [result intValue];
}

- (void)setTabNumberValue:(int)value_ {
	[self setTabNumber:[NSNumber numberWithInt:value_]];
}

- (int)primitiveTabNumberValue {
	NSNumber *result = [self primitiveTabNumber];
	return [result intValue];
}

- (void)setPrimitiveTabNumberValue:(int)value_ {
	[self setPrimitiveTabNumber:[NSNumber numberWithInt:value_]];
}









@end
