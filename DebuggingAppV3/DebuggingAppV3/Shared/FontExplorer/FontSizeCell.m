//
//  FontSizeCell.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "FontSizeCell.h"


@implementation FontSizeCell

@synthesize exampleTextLabel;


- (void) dealloc
{
	[sizeLabel release]; sizeLabel = nil;
	[exampleTextLabel release]; exampleTextLabel = nil;
	[sizeFormatString release]; sizeFormatString = nil;
	[super dealloc];
}

- (void) awakeFromNib
{
	// Put cell initialization code here
	sizeFormatString = [sizeLabel.text retain];
}

- (void) prepareForReuse
{
	// Do any cell resetting here
}

- (CGFloat)determineLabelHeightForFont:(UIFont *)font text:(NSString*)text
{
	// You have to use some kind of maximum, so we'll use an unlikley max.
	int maxHeight = 99999;
	
	
	CGSize maxSize = CGSizeMake(exampleTextLabel.frame.size.width, maxHeight);
	// This call is theoretically better, but does not actually work (always returns one row).  
	//CGSize bestSize = [text sizeWithFont:font  forWidth:exampleTextLabel.frame.size.width lineBreakMode:UILineBreakModeWordWrap];
	CGSize bestSize = [text sizeWithFont:font constrainedToSize:maxSize];
	
	return bestSize.height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFontName:(NSString *)fontName size:(CGFloat)size exampleText:(NSString *)exampleText
{
	exampleTextLabel.font = [UIFont fontWithName:fontName size:size];
	CGRect frame = exampleTextLabel.frame;
	frame.size.height = [self determineLabelHeightForFont:exampleTextLabel.font text:exampleText];
	exampleTextLabel.frame = frame;
	
	exampleTextLabel.text = exampleText;
    
    savedSize = [NSString stringWithFormat:@"%0.2f", size];
	
	if ( [fontName isEqualToString:@"DBLCDTempBlack"] )
		exampleTextLabel.text = [NSString stringWithFormat:@"%@:%@",exampleText,size];
	
	sizeLabel.text = [NSString stringWithFormat:sizeFormatString,(int)size];
	NSLog(@"Size is %d", size);
}



@end

