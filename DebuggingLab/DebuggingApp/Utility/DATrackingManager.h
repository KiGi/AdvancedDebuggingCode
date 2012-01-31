//
//  DATrackingManager.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/9/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DAVCTracker.h"
#import "DATabTracker.h"

@interface DATrackingManager : NSObject

+ (void) trackTabPressed:(NSInteger)tabNumber;

+ (DAVCTracker *) trackingForVC:(Class)vcClass;

+ (void) saveVCTrackingResults;

@end
