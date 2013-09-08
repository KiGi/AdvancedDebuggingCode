//
//  KGFlickrItemCell.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/8/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGFlickrItemCell.h"

@implementation KGFlickrItemCell
@synthesize titleLabel;
@synthesize imageThumb;
@synthesize usernameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) heightForCell
{
    return 100;
}

@end
