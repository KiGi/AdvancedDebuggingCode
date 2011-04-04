//
//  DAMainImageExplorer.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DAMainImageExplorer.h"

#import "DAFullScreenImageViewController.h"

// Private interface to declare internal only properties and methods
@interface DAMainImageExplorer()
- (void) releaseOutlets;
@property (nonatomic, retain) IBOutlet UIImageView *displayImage;
@end

@implementation DAMainImageExplorer

@synthesize displayImage = displayImage_;

- (void)dealloc {
    [self releaseOutlets];
    [super dealloc];
}

- (void) releaseOutlets
{
    [displayImage_ release]; displayImage_ = nil;
}

#pragma mark -
#pragma mark Setter Overrides
- (void) setDisplayImage:(UIImageView *)displayImage
{
    CALayer *newLayer = [CALayer layer];
    newLayer.shadowOffset = CGSizeMake(2, 2);
    newLayer.shadowColor = [UIColor blackColor].CGColor;
    CGRect imageFrame = displayImage.frame;
    newLayer.frame = imageFrame;
    [displayImage.layer addSublayer:newLayer];

    [displayImage_ release];
    displayImage_ = [displayImage retain];
}

#pragma mark -
#pragma mark Actions

- (IBAction) fullScreenImage:(id) sender
{
    if ( self.displayImage.image == nil )
        return;
    
    DAFullScreenImageViewController *controller = [[DAFullScreenImageViewController alloc] initWithNibName:@"DAFullScreenImageView" bundle:nil];
    controller.image = self.displayImage.image;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void) backgroundBrownLoad
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[pool drain];
	UIImage *theImage = [UIImage imageNamed:@"Brown.jpg"];
	self.displayImage.image = theImage;
	[pool release];
}

- (IBAction) brownPress:(id) sender
{
	[self performSelectorInBackground:@selector(backgroundBrownLoad) withObject:nil];
}

- (IBAction) greenPress:(id) sender
{
	NSString *bundlePath =  [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [bundlePath stringByAppendingPathComponent:@"Green.jpg"];
	UIImage *theImage = [UIImage imageWithContentsOfFile:filePath];	
	self.displayImage.image = theImage;
	[theImage release];
}

- (IBAction) greyPress:(id) sender
{
	UIImage *theImage = [UIImage imageNamed:@"Grey.jpg"];
	self.displayImage.image = theImage;
	[theImage release];
}

- (IBAction) redPress:(id) sender
{
	UIImage *lastImage = self.displayImage.image;
	
	NSString *bundlePath =  [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [bundlePath stringByAppendingPathComponent:@"Red.jpg"];
	UIImage *theImage = [UIImage imageWithContentsOfFile:filePath];	
	self.displayImage.image = [theImage retain];
	
	CGSize theSize = lastImage.size;
	NSLog(@"Last image size was %dx%2", theSize.width, theSize.height);
}


#pragma mark -
#pragma mark UIViewController methods


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [self releaseOutlets];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
