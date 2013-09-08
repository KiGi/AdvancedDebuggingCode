//
//  KGAppDelegate.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGAppDelegate.h"

#import "KGFlickrListVC.h"

#import "KGMapSelectionsVC.h"
#import "DAMainFontExplorer.h"
#import "KGStore.h"
#import "NSFileManager+KGPaths.h"


@implementation KGAppDelegate

- (void) setupDatabase
{
    NSString *documentsPath = [NSFileManager documentsPath];
    [[KGStore sharedInstance] setupCoreDataStackWithStorePathURL:[NSURL fileURLWithPath:documentsPath]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2, *viewController3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[KGFlickrListVC alloc] initWithNibName:@"KGFlickrListVC_iPhone" bundle:nil];
        viewController2 = [[KGMapSelectionsVC alloc] initWithNibName:@"KGMapSelectionsVC_iPhone" bundle:nil];
        viewController3 = [[DAMainFontExplorer alloc] initWithNibName:@"DAMainFontExplorer" bundle:nil];
    } else {
        viewController1 = [[KGFlickrListVC alloc] initWithNibName:@"KGFlickrListVC_iPad" bundle:nil];
        viewController2 = [[KGMapSelectionsVC alloc] initWithNibName:@"KGMapSelectionsVC_iPad" bundle:nil];
        viewController3 = [[DAMainFontExplorer alloc] initWithNibName:@"DAMainFontExplorer" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:viewController1], viewController2, [[UINavigationController alloc] initWithRootViewController:viewController3]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    NSLog(@"Notification logged is %@",notif);
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
