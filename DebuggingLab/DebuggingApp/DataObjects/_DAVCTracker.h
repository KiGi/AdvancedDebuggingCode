// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DAVCTracker.h instead.

#import <CoreData/CoreData.h>







@interface DAVCTrackerID : NSManagedObjectID {}
@end

@interface _DAVCTracker : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DAVCTrackerID*)objectID;



@property (nonatomic, retain) NSNumber *VCLengthAccessed;

@property double VCLengthAccessedValue;
- (double)VCLengthAccessedValue;
- (void)setVCLengthAccessedValue:(double)value_;

//- (BOOL)validateVCLengthAccessed:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *VCName;

//- (BOOL)validateVCName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *trackingID;

//- (BOOL)validateTrackingID:(id*)value_ error:(NSError**)error_;





@end

@interface _DAVCTracker (CoreDataGeneratedAccessors)

@end

@interface _DAVCTracker (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveVCLengthAccessed;
- (void)setPrimitiveVCLengthAccessed:(NSNumber*)value;

- (double)primitiveVCLengthAccessedValue;
- (void)setPrimitiveVCLengthAccessedValue:(double)value_;




- (NSString*)primitiveVCName;
- (void)setPrimitiveVCName:(NSString*)value;




- (NSString*)primitiveTrackingID;
- (void)setPrimitiveTrackingID:(NSString*)value;




@end
