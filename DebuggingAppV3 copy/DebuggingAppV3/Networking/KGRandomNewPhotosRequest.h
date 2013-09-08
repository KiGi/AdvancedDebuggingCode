//
//  KGRandomNewPhotosRequest.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGFlickrMasterRequest.h"

@interface KGRandomNewPhotosRequest : KGFlickrMasterRequest

+ (void) performRequestWithSuccessHandler:(void (^)(NSArray *flickrItems))success
                           failureHandler:(void (^)(NSError *error))failure
                           finallyHandler:(void (^)())finally;
@end
