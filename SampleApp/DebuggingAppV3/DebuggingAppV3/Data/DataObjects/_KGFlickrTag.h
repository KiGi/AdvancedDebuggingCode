// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGFlickrTag.h instead.

#import <CoreData/CoreData.h>


extern const struct KGFlickrTagAttributes {
	__unsafe_unretained NSString *complexTag;
	__unsafe_unretained NSString *tagValue;
} KGFlickrTagAttributes;

extern const struct KGFlickrTagRelationships {
	__unsafe_unretained NSString *item;
} KGFlickrTagRelationships;

extern const struct KGFlickrTagFetchedProperties {
} KGFlickrTagFetchedProperties;

@class KGFlickrItem;




@interface KGFlickrTagID : NSManagedObjectID {}
@end

@interface _KGFlickrTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (KGFlickrTagID*)objectID;





@property (nonatomic, strong) NSNumber* complexTag;



@property BOOL complexTagValue;
- (BOOL)complexTagValue;
- (void)setComplexTagValue:(BOOL)value_;

//- (BOOL)validateComplexTag:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* tagValue;



//- (BOOL)validateTagValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) KGFlickrItem *item;

//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;





@end

@interface _KGFlickrTag (CoreDataGeneratedAccessors)

@end

@interface _KGFlickrTag (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveComplexTag;
- (void)setPrimitiveComplexTag:(NSNumber*)value;

- (BOOL)primitiveComplexTagValue;
- (void)setPrimitiveComplexTagValue:(BOOL)value_;




- (NSString*)primitiveTagValue;
- (void)setPrimitiveTagValue:(NSString*)value;





- (KGFlickrItem*)primitiveItem;
- (void)setPrimitiveItem:(KGFlickrItem*)value;


@end
