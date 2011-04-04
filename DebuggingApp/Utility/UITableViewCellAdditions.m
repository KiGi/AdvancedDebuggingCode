//
//  UITableViewCellAdditions.h
//  PublicEarth
//
//  Created by Kendall Gelner on 9/24/2009.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "UITableViewCellAdditions.h"


@implementation UITableViewCell (XIBLoadAdditions)

+ (UITableViewCell *) cellFromXibName:(NSString *) xibName
{
	NSArray *xibTopLevels = [[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil];
	id firstTopLevelObject = [xibTopLevels objectAtIndex:0];
	if ( [ firstTopLevelObject isKindOfClass:[UITableViewCell class]] )
		return firstTopLevelObject;	
	return [xibTopLevels objectAtIndex:1];
}

@end
