//
//  KGRandomNewPhotosRequest.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGFlickrMasterRequest.h"

@interface KGFriendNewPhotosRequest : KGFlickrMasterRequest

+ (void) performRequestForFriendFlickrID:(NSString *)flickrID
                          successHandler:(void (^)(NSArray *flickrItems))success
                           failureHandler:(void (^)(NSError *error))failure
                           finallyHandler:(void (^)())finally;
@end
