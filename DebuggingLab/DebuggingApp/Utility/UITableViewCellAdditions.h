//
//  UITableViewCellAdditions.h
//  PublicEarth
//
//  Created by Kendall Gelner on 9/24/2009.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UITableViewCell (XIBLoadAdditions) 

+ (UITableViewCell *) cellFromXibName:(NSString *) xibName;

@end
