//
//  KGMasterRequest.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface KGFlickrMasterRequest : NSObject

// Overrides from AFNetworking, so that we can intercept and handle some error conditions

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        successHandler:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failureHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
        finallyHandler:(void (^)())finally;

+ (void) convertJSONToObjects:(NSDictionary *)flickrMetaDict;
+ (NSDictionary *) tryMassagedData:(NSData *)brokenData;

+ (NSDate *)dateFromServerDate:(NSString *)serverDate;


@end
