//
//  DAMainImageExplorer.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DAMainImageExplorer : UIViewController 
{
	IBOutlet UIImageView *displayImage_;
}

- (IBAction) brownPress:(id) sender;
- (IBAction) greenPress:(id) sender;
- (IBAction) greyPress:(id) sender;
- (IBAction) redPress:(id) sender;
- (IBAction) fullScreenImage:(id) sender;

@end
