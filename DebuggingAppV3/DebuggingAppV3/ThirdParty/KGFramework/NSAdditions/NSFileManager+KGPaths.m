//
//  NSFileManager+KGPaths.m
//  CiaoMuseMentor
//
//  Created by Kendall Helmstetter Gelner on 3/8/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import "NSFileManager+KGPaths.h"

static NSString *kgStoredLibraryPath = nil;
static NSString *kgStoredBundlePath = nil;
static NSString *kgStoredDocumentsPath = nil;
static NSString *kgStoredCachesPath = nil;
static NSString *kgStoredApplicationSupportPath = nil;

@implementation NSFileManager (KGPaths)

#pragma mark -
#pragma mark Helper

+ (BOOL) checkAndCreateDirectory:(NSString *)path
{
    BOOL success = YES;
    if ( ! [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if ( error )
        {
            NSLog(@"Warning, could not create directory %@: error %@", path, error);
            success = NO;
        }
    }
    return success;
}

#pragma mark -
#pragma mark Public methods

// The base library path, where various things are stored
+ (NSString *) libraryPath
{
    if ( kgStoredLibraryPath == nil )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        if ( paths.count > 0 )
            kgStoredLibraryPath = [paths objectAtIndex:0];
    }
    return kgStoredLibraryPath;
}

// The application support path, where you are supposed to put things like databases or thumbnails.
+ (NSString *) applicationSupportPath
{
    if ( kgStoredApplicationSupportPath == nil )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        if ( paths.count > 0 )
            kgStoredApplicationSupportPath = [paths objectAtIndex:0];
        
        if ( ! [self checkAndCreateDirectory:kgStoredApplicationSupportPath] )
                kgStoredApplicationSupportPath = nil;
    }
    return kgStoredApplicationSupportPath;
}

// The documents path, which the user can see in iTunes if you configure you application in the info.plist to allow file transer.
+ (NSString *) documentsPath
{
    if ( kgStoredDocumentsPath == nil )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if ( paths.count > 0 )
            kgStoredDocumentsPath = [paths objectAtIndex:0];
    }
    return kgStoredDocumentsPath;
}

// The caches path, where you can place temporary files that you do not mind the system purging from time to time.
+ (NSString *) cachesPath
{
    if ( kgStoredCachesPath == nil )
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        if ( paths.count > 0 )
            kgStoredCachesPath = [paths objectAtIndex:0];
        
        if ( ! [self checkAndCreateDirectory:kgStoredCachesPath] )
            kgStoredCachesPath = nil;
    }
    return kgStoredCachesPath;
}


// The path of the main bundle, where you can find things included in your project (but cannot write to).
+ (NSString *) mainBundleReadonlyPath
{
    if ( kgStoredBundlePath == nil )
        kgStoredBundlePath = [[NSBundle mainBundle] bundlePath];
    
    return kgStoredBundlePath;
}


@end
