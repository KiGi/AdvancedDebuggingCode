// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KGLocationSaveItem.h instead.

#import <CoreData/CoreData.h>


extern const struct KGLocationSaveItemAttributes {
	__unsafe_unretained NSString *lattitude;
	__unsafe_unretained NSString *locationDescription;
	__unsafe_unretained NSString *longitude;
} KGLocationSaveItemAttributes;

extern const struct KGLocationSaveItemRelationships {
} KGLocationSaveItemRelationships;

extern const struct KGLocationSaveItemFetchedProperties {
} KGLocationSaveItemFetchedProperties;






@interface KGLocationSaveItemID : NSManagedObjectID {}
@end

@interface _KGLocationSaveItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (KGLocationSaveItemID*)objectID;





@property (nonatomic, strong) NSNumber* lattitude;



@property float lattitudeValue;
- (float)lattitudeValue;
- (void)setLattitudeValue:(float)value_;

//- (BOOL)validateLattitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* locationDescription;



//- (BOOL)validateLocationDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* longitude;



@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;






@end

@interface _KGLocationSaveItem (CoreDataGeneratedAccessors)

@end

@interface _KGLocationSaveItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveLattitude;
- (void)setPrimitiveLattitude:(NSNumber*)value;

- (float)primitiveLattitudeValue;
- (void)setPrimitiveLattitudeValue:(float)value_;




- (NSString*)primitiveLocationDescription;
- (void)setPrimitiveLocationDescription:(NSString*)value;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




@end
