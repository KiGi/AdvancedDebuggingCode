//
//  DAFullScreenImageViewController.m
//  DebuggingApp
//
//  Created by Kendall Helmstetter Gelner on 4/3/11.
//  Copyright 2011 KiGi Software. All rights reserved.
//

#import "DAFullScreenImageViewController.h"

@interface DAFullScreenImageViewController()
- (void) freeOutlets;
@property (nonatomic, retain) NSMutableArray *previousImages;
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation DAFullScreenImageViewController

@synthesize image = image_;
@synthesize imageView = imageView_;
@synthesize previousImages = previousImages_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [previousImages_ release]; previousImages_ = nil;
    self.image = nil;
    [self freeOutlets];
    [super dealloc];
}

- (void) freeOutlets
{
   [imageView_ release]; imageView_ = nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Overrides

- (void) setImage:(UIImage *)image
{
    if ( self.previousImages == nil )
        self.previousImages = [NSMutableArray arrayWithCapacity:2];
    [self.previousImages addObject:image];
    [image_ release];
    image_ =  [image retain];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.imageView.image = self.image;
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
