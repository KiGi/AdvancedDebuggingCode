//
//  KGSecondViewController.h
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface KGMapSelectionsVC : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *addNewPointButton;
@property (weak, nonatomic) IBOutlet UIView *chooseNewPointControlContainerView;
@property (weak, nonatomic) IBOutlet UITextView *createNewPointDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *crosshairOverlayView;
@property (weak, nonatomic) IBOutlet UIView *previousPointsContainerView;
- (IBAction)addNewPointPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *useThisPointPressed;
@property (weak, nonatomic) IBOutlet UIButton *cancelPressed;

@end
