//
//  DAFullScreenImageViewController.h
//  DebuggingApp
//
//  Created by Kendall Helmstetter Gelner on 4/3/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DAFullScreenImageViewController : UIViewController 
{
    IBOutlet UIImageView *imageView;
    UIImage *image_;
}

@property (nonatomic, retain) UIImage *image;
//@property (nonatomic, assign) IBOutlet UIImageView *imageView;

@end
