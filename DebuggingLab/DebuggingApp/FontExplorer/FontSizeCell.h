//
//  FontSizeCell.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontSizeCell : UITableViewCell 
{
	IBOutlet UILabel *sizeLabel;
	IBOutlet UILabel *exampleTextLabel;
	
	NSString *sizeFormatString;
}

@property (nonatomic, retain) IBOutlet UILabel *exampleTextLabel;

- (void) setFontName:(NSString *)fontName size:(CGFloat)size exampleText:(NSString *)exampleText;


@end

