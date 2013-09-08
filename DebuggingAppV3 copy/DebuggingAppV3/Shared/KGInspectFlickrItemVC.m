//
//  KGInspectFlickrItemVC.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/9/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGInspectFlickrItemVC.h"
#import "UiImageView+AFNetworking.h"

#import "KGFlickrTag.h"
#import "KGFlickrMedia.h"

@interface KGInspectFlickrItemVC ()

@end

@implementation KGInspectFlickrItemVC
@synthesize authorTextField;
@synthesize titleTextField;
@synthesize tagTextField;
@synthesize flickrImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self populateValues];
}

- (void) populateValues
{
    self.authorTextField.text = self.item.authorName;
    self.titleTextField.text = self.item.title;
    NSMutableString *tagString = [NSMutableString string];
    
    for ( KGFlickrTag *tagItem in [self.item.tags allObjects] )
    {
        [tagString appendFormat:@"%@ ", tagItem.tagValue];
    }
    
    self.tagTextField.text = tagString;
    
    KGFlickrMedia *media = [self.item.media anyObject];
    [self.flickrImage setImageWithURL:[NSURL URLWithString:media.mediaURL]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)viewFriendsPhotosPressed:(id)sender
{
    [self.delegate performSelector:@selector(viewPhotosForFlickrID:) withObject:self.item.authorFlickrID];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
