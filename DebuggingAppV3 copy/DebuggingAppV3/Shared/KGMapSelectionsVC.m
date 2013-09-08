//
//  KGSecondViewController.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGMapSelectionsVC.h"

@interface KGMapSelectionsVC ()

@end

@implementation KGMapSelectionsVC
@synthesize useThisPointPressed;
@synthesize cancelPressed;
@synthesize mapView;
@synthesize addNewPointButton;
@synthesize chooseNewPointControlContainerView;
@synthesize createNewPointDescriptionTextView;
@synthesize crosshairOverlayView;
@synthesize previousPointsContainerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Map", @"Map");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
                        

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setAddNewPointButton:nil];
    [self setChooseNewPointControlContainerView:nil];
    [self setCrosshairOverlayView:nil];
    [self setPreviousPointsContainerView:nil];
    [self setUseThisPointPressed:nil];
    [self setCancelPressed:nil];
    [self setCreateNewPointDescriptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)addNewPointPressed:(id)sender {
}
@end
