// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrItem.m instead.

#import "_KGFlickrItem.h"

const struct KGFlickrItemAttributes KGFlickrItemAttributes = {
	.authorFlickrID = @"authorFlickrID",
	.authorName = @"authorName",
	.dateTaken = @"dateTaken",
	.flickrDescription = @"flickrDescription",
	.link = @"link",
	.published = @"published",
	.title = @"title",
};

const struct KGFlickrItemRelationships KGFlickrItemRelationships = {
	.media = @"media",
	.tags = @"tags",
};

const struct KGFlickrItemFetchedProperties KGFlickrItemFetchedProperties = {
};

@implementation KGFlickrItemID
@end

@implementation _KGFlickrItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FlickrItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FlickrItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FlickrItem" inManagedObjectContext:moc_];
}

- (KGFlickrItemID*)objectID {
	return (KGFlickrItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic authorFlickrID;






@dynamic authorName;






@dynamic dateTaken;






@dynamic flickrDescription;






@dynamic link;






@dynamic published;






@dynamic title;






@dynamic media;

	
- (NSMutableSet*)mediaSet {
	[self willAccessValueForKey:@"media"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"media"];
  
	[self didAccessValueForKey:@"media"];
	return result;
}
	

@dynamic tags;

	
- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];
  
	[self didAccessValueForKey:@"tags"];
	return result;
}
	






@end
