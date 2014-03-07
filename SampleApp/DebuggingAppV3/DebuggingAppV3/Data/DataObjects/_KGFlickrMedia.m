// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrMedia.m instead.

#import "_KGFlickrMedia.h"

const struct KGFlickrMediaAttributes KGFlickrMediaAttributes = {
	.mediaSize = @"mediaSize",
	.mediaURL = @"mediaURL",
};

const struct KGFlickrMediaRelationships KGFlickrMediaRelationships = {
	.item = @"item",
};

const struct KGFlickrMediaFetchedProperties KGFlickrMediaFetchedProperties = {
};

@implementation KGFlickrMediaID
@end

@implementation _KGFlickrMedia

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FlickrMedia" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FlickrMedia";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FlickrMedia" inManagedObjectContext:moc_];
}

- (KGFlickrMediaID*)objectID {
	return (KGFlickrMediaID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic mediaSize;






@dynamic mediaURL;






@dynamic item;

	






@end
