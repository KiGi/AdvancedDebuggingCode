//
//  DATrackingManager.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/9/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import "DATrackingManager.h"

#import "DACoreDataManager.h"

@implementation DATrackingManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (DATabTracker *) loadExistingOrNewInstanceOfTabTracker
{
    DATabTracker *tabTrackerObject = nil;
    
    NSManagedObjectContext *moc = [[DACoreDataManager sharedInstance] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"TabTracker" inManagedObjectContext:moc];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count == 0)
    {
        tabTrackerObject = [DATabTracker insertInManagedObjectContext:moc];
    }
    else
    {
        tabTrackerObject = [array objectAtIndex:0];
    }
    return tabTrackerObject;
}

+ (void) trackTabPressed:(NSInteger)tabNumber
{
    NSManagedObjectContext *moc = [[DACoreDataManager sharedInstance] managedObjectContext];
    DATabTracker *tracker = [DATabTracker insertInManagedObjectContext:moc];
    tracker.tabNumberValue = tabNumber;
    tracker.datePressed = [NSDate date];
    NSLog(@"Tracked Tab: %d", tabNumber);
}


+ (DAVCTracker *) loadExistingOrNewInstanceOfVCTrackerforName:(NSString *)vcName
{
    DAVCTracker *vcTracker = nil;
    
    NSManagedObjectContext *moc = [[DACoreDataManager sharedInstance] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"VCTracker" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"VCName = %@", vcName];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array.count == 0)
    {
        vcTracker = [DAVCTracker insertInManagedObjectContext:moc];
        vcTracker.VCName = vcName;
    }
    else
    {
        vcTracker = [array objectAtIndex:0];
    }
    return vcTracker;
}

+ (DAVCTracker *) trackingForVC:(Class)vcClass
{
    return [self loadExistingOrNewInstanceOfVCTrackerforName:NSStringFromClass(vcClass)];
}

+ (void) saveVCTrackingResults
{
    NSError *error = nil;
    NSManagedObjectContext *moc = [[DACoreDataManager sharedInstance] managedObjectContext];
    [moc save:&error];
    if ( error )
    {
        NSLog(@"Data Error is %@", error);
    }
}

@end
