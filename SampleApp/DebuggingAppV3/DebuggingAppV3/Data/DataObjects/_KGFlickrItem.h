// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrItem.h instead.

#import <CoreData/CoreData.h>


extern const struct KGFlickrItemAttributes {
	__unsafe_unretained NSString *authorFlickrID;
	__unsafe_unretained NSString *authorName;
	__unsafe_unretained NSString *dateTaken;
	__unsafe_unretained NSString *flickrDescription;
	__unsafe_unretained NSString *link;
	__unsafe_unretained NSString *published;
	__unsafe_unretained NSString *title;
} KGFlickrItemAttributes;

extern const struct KGFlickrItemRelationships {
	__unsafe_unretained NSString *media;
	__unsafe_unretained NSString *tags;
} KGFlickrItemRelationships;

extern const struct KGFlickrItemFetchedProperties {
} KGFlickrItemFetchedProperties;

@class KGFlickrMedia;
@class KGFlickrTag;









@interface KGFlickrItemID : NSManagedObjectID {}
@end

@interface _KGFlickrItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (KGFlickrItemID*)objectID;





@property (nonatomic, strong) NSString* authorFlickrID;



//- (BOOL)validateAuthorFlickrID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* authorName;



//- (BOOL)validateAuthorName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateTaken;



//- (BOOL)validateDateTaken:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* flickrDescription;



//- (BOOL)validateFlickrDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* link;



//- (BOOL)validateLink:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* published;



//- (BOOL)validatePublished:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *media;

- (NSMutableSet*)mediaSet;




@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;





@end

@interface _KGFlickrItem (CoreDataGeneratedAccessors)

- (void)addMedia:(NSSet*)value_;
- (void)removeMedia:(NSSet*)value_;
- (void)addMediaObject:(KGFlickrMedia*)value_;
- (void)removeMediaObject:(KGFlickrMedia*)value_;

- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(KGFlickrTag*)value_;
- (void)removeTagsObject:(KGFlickrTag*)value_;

@end

@interface _KGFlickrItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAuthorFlickrID;
- (void)setPrimitiveAuthorFlickrID:(NSString*)value;




- (NSString*)primitiveAuthorName;
- (void)setPrimitiveAuthorName:(NSString*)value;




- (NSDate*)primitiveDateTaken;
- (void)setPrimitiveDateTaken:(NSDate*)value;




- (NSString*)primitiveFlickrDescription;
- (void)setPrimitiveFlickrDescription:(NSString*)value;




- (NSString*)primitiveLink;
- (void)setPrimitiveLink:(NSString*)value;




- (NSDate*)primitivePublished;
- (void)setPrimitivePublished:(NSDate*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveMedia;
- (void)setPrimitiveMedia:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;


@end
