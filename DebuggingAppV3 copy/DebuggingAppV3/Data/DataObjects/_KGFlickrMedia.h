// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrMedia.h instead.

#import <CoreData/CoreData.h>


extern const struct KGFlickrMediaAttributes {
	__unsafe_unretained NSString *mediaSize;
	__unsafe_unretained NSString *mediaURL;
} KGFlickrMediaAttributes;

extern const struct KGFlickrMediaRelationships {
	__unsafe_unretained NSString *item;
} KGFlickrMediaRelationships;

extern const struct KGFlickrMediaFetchedProperties {
} KGFlickrMediaFetchedProperties;

@class KGFlickrItem;




@interface KGFlickrMediaID : NSManagedObjectID {}
@end

@interface _KGFlickrMedia : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (KGFlickrMediaID*)objectID;





@property (nonatomic, strong) NSString* mediaSize;



//- (BOOL)validateMediaSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mediaURL;



//- (BOOL)validateMediaURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) KGFlickrItem *item;

//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;





@end

@interface _KGFlickrMedia (CoreDataGeneratedAccessors)

@end

@interface _KGFlickrMedia (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveMediaSize;
- (void)setPrimitiveMediaSize:(NSString*)value;




- (NSString*)primitiveMediaURL;
- (void)setPrimitiveMediaURL:(NSString*)value;





- (KGFlickrItem*)primitiveItem;
- (void)setPrimitiveItem:(KGFlickrItem*)value;


@end
