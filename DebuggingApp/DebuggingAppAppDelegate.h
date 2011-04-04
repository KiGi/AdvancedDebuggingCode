//
//  DebuggingAppAppDelegate.h
//  DebuggingApp
//
//  Created by Kendall Helmstetter Gelner on 4/2/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebuggingAppAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
