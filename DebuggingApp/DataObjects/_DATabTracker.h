// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DATabTracker.h instead.

#import <CoreData/CoreData.h>







@interface DATabTrackerID : NSManagedObjectID {}
@end

@interface _DATabTracker : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DATabTrackerID*)objectID;



@property (nonatomic, retain) NSDate *datePressed;

//- (BOOL)validateDatePressed:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *trackingID;

//- (BOOL)validateTrackingID:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *tabNumber;

@property int tabNumberValue;
- (int)tabNumberValue;
- (void)setTabNumberValue:(int)value_;

//- (BOOL)validateTabNumber:(id*)value_ error:(NSError**)error_;





@end

@interface _DATabTracker (CoreDataGeneratedAccessors)

@end

@interface _DATabTracker (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDatePressed;
- (void)setPrimitiveDatePressed:(NSDate*)value;




- (NSString*)primitiveTrackingID;
- (void)setPrimitiveTrackingID:(NSString*)value;




- (NSNumber*)primitiveTabNumber;
- (void)setPrimitiveTabNumber:(NSNumber*)value;

- (int)primitiveTabNumberValue;
- (void)setPrimitiveTabNumberValue:(int)value_;




@end
