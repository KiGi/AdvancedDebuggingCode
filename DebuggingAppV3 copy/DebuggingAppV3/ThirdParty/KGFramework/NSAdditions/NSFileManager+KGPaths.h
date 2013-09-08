//
//  NSFileManager+KGPaths.h
//  CiaoMuseMentor
//
//  Created by Kendall Helmstetter Gelner on 3/8/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSFileManager (KGPaths)

// Use this to create a directroy if it does not already exist.  Returns NO if directory could not be created.
+ (BOOL) checkAndCreateDirectory:(NSString *)path;

// The base library path, where various things are stored
+ (NSString *) libraryPath;

// The application support path, where you are supposed to put things like databases or thumbnails.
+ (NSString *) applicationSupportPath;

// The documents path, which the user can see in iTunes if you configure you application in the info.plist to allow file transer.
+ (NSString *) documentsPath;

// The caches path, where you can place temporary files that you do not mind the system purging from time to time.
+ (NSString *) cachesPath;

// The path of the main bundle, where you can find things included in your project (but cannot write to).
+ (NSString *) mainBundleReadonlyPath;

@end
