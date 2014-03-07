//
//  KGInspectFlickrItemVC.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/9/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KGFlickrItem.h"

@interface KGInspectFlickrItemVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *flickrImage;
- (IBAction)viewFriendsPhotosPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *authorTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *tagTextField;

@property (nonatomic, strong) KGFlickrItem *item;
@property (nonatomic, weak) id delegate;

@end
