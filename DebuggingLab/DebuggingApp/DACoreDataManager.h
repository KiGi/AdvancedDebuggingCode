//
//  DACoreDataManager.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/9/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DACoreDataManager : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DACoreDataManager *) sharedInstance;

@end
