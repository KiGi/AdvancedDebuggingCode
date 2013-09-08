//
//  DAMainFontExplorer.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/23/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FontSizeCell.h"

@interface DAMainFontExplorer : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
	IBOutlet UITableView *myTable;
	IBOutlet UITextField *customTextField;
    IBOutlet UIButton *revButton;
	NSString *chosenFont_;
	NSString *fontExampleString;
	
	FontSizeCell *exampleCell;
	
	NSInteger selectedCell_;
}

@property (nonatomic, copy) NSString *fontExampleString;
@property (nonatomic, copy) NSString *chosenFont;

- (IBAction) reversePressed:(id)sender;

@end




