//
//  DAChooseFontTableViewController.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DAMainFontExplorer;

@interface DAChooseFontTableViewController : UITableViewController 
{
	NSArray *fontList;
	DAMainFontExplorer *delegate;
    IBOutlet UITableView *myTable;
}

@property (nonatomic, assign) DAMainFontExplorer *delegate;

@end

