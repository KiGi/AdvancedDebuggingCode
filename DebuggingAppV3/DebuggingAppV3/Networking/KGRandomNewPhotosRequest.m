//
//  KGRandomNewPhotosRequest.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGRandomNewPhotosRequest.h"
#import "KGFlickrItem.h"
#import "KGFlickrMedia.h"
#import "KGFlickrTag.h"
#import "NSDictionary+KGSafeExtract.h"

@implementation KGRandomNewPhotosRequest


+ (void) performRequestWithSuccessHandler:(void (^)(NSArray *flickrItems))success
                           failureHandler:(void (^)(NSError *error))failure
                           finallyHandler:(void (^)())finally
{
    NSString *allPhotosPath = @"/services/feeds/photos_public.gne";
    NSDictionary *jsonFormatParam = @{@"format":@"json",
                                      @"nojsoncallback":@"1"};
    
    [self getPath:allPhotosPath parameters:jsonFormatParam successHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Parse JSON from server
        if ( [responseObject isKindOfClass:[NSData class]] )
        {
            NSData *responseData =responseObject;
            // In real life, AFNetworking would already have decoded the JSON.  Some bug in AFNetwork prevents parsing correctly, so manually parse if needed.
            responseObject = [self tryMassagedData:responseData];
        }
        
        if ( [responseObject isKindOfClass:[NSDictionary class]] )
        {
            NSDictionary *flickrMetaDict = responseObject;
            [self convertJSONToObjects:flickrMetaDict];
            if ( success )
                success( nil );
        }
    } failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ( failure )
        {
            NSData *responseData =[operation responseData];
            // In real life, AFNetworking would already have decoded the JSON.  Some bug in AFNetwork prevents parsing correctly sometimes, so manually parse if needed.
            
            NSDictionary *responseDict = [self tryMassagedData:responseData];
            
            if ( responseDict )
            {
                [self convertJSONToObjects:responseDict];
                if ( success )
                    success( nil );
            }
            else
            {
                failure(error);
            }
        }
    }
   finallyHandler:finally
     ];
}

@end
