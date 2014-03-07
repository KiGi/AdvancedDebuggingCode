//
//  KGFlickrItemCell.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/8/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGFlickrItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

+ (CGFloat) heightForCell;

@end
