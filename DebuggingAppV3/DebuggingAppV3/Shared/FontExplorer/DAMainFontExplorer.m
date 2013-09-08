//
//  DAMainFontExplorer.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/23/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "DAMainFontExplorer.h"
#import "UITableViewCellAdditions.h"
#import "DAChooseFontTableViewController.h"
#import "DAPossibleFonts.h"

@interface DAMainFontExplorer ()
- (void) freeOutlets;
- (void) addChangeButton;

@property (nonatomic) NSInteger selectedCell;
@property (nonatomic, retain) NSTimer *timer;

@end


@implementation DAMainFontExplorer

@synthesize fontExampleString;
@synthesize chosenFont = chosenFont_;
@synthesize selectedCell = selectedCell_;
@synthesize timer = timer_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Font", @"Font");
        self.tabBarItem.image = [UIImage imageNamed:@"third"];
    }
    return self;
}

- (void)dealloc 
{
    [revButton release]; revButton = nil;
    [timer_ release]; timer_ = nil;
	[chosenFont_ release]; chosenFont_ = nil;
	[fontExampleString release]; fontExampleString = nil;
	[self freeOutlets];
    [super dealloc];
}

- (void) freeOutlets
{
    [revButton release]; revButton = nil;
	[myTable release]; myTable = nil;
	[customTextField release];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self freeOutlets];
}

#pragma mark -
#pragma mark TextField methods

#define KBD_HEIGHT 150

- (IBAction) keyboardWillAppear:(NSNotification *)notification
{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditing)];
	CGRect frame = myTable.frame;
	frame.size.height -= KBD_HEIGHT;
	myTable.frame = frame;
}

- (void) doneEditing
{
	[customTextField resignFirstResponder];
	[self addChangeButton];
}

- (IBAction) keyboardWillDisappear:(NSNotification *)notification
{
	CGRect frame = myTable.frame;
	frame.size.height += KBD_HEIGHT;
	myTable.frame = frame;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self doneEditing];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	// reloads string after new string is set.
	[self performSelector:@selector(reloadExampleString) withObject:nil afterDelay:0.0f];
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	[self performSelector:@selector(reloadExampleString) withObject:nil afterDelay:0.0f];
	return YES;
}

- (void) reloadExampleString
{
	if ( customTextField.text.length == 0 )
	{
		self.fontExampleString = @"Example Text";
	}
	else
	{
		NSString *useString = [customTextField.text retain];
		self.fontExampleString = useString;
		[self.fontExampleString retain];
	}

	[myTable reloadData];
}

#pragma mark -
#pragma mark Helper methods
- (CGFloat)determineLabelHeightForIndexPath:(NSIndexPath *)indexPath
{
	// You have to use some kind of maximum, so we'll use an unlikley max.
	int maxHeight = 99999;
	
	
	CGSize maxSize = CGSizeMake(exampleCell.exampleTextLabel.frame.size.width, maxHeight);
    if ( maxSize.width < 305 || maxSize.width > 320 )
        maxSize.width = 320;
	int row = indexPath.row;
	UIFont *font = [UIFont fontWithName:self.chosenFont size:row];
	// This call is theoretically better, but does not actually work (always returns one row).  
	//CGSize bestSize = [fontExampleString sizeWithFont:font  forWidth:maxSize.width lineBreakMode:UILineBreakModeWordWrap];
	CGSize bestSize = [fontExampleString sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
	
	return bestSize.height;
}

#pragma mark -
#pragma mark Actions

- (void) changeFont
{
	DAChooseFontTableViewController *chooseController = [[[DAChooseFontTableViewController alloc] initWithNibName:@"DAChooseFontTableView" bundle:nil] autorelease];
    chooseController.delegate = self;
	[self.navigationController pushViewController:chooseController animated:YES];
}


- (void) backgroundReverseString:(NSString *)revString
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSInteger len = [revString length];
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:len];
    
    while (len > 0) 
    {
        unichar uch = [revString characterAtIndex:--len]; 
        [reversedString appendString:[NSString stringWithCharacters:&uch length:1]];
    } 
    
    [customTextField performSelectorOnMainThread:@selector(setText:) withObject:reversedString waitUntilDone:YES];
    [myTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    [pool drain];
}

- (IBAction) reversePressed:(id)sender
{
    [self performSelectorInBackground:@selector(backgroundReverseString:) withObject:customTextField.text];
}

- (void)timerCheckpoint:(NSTimer*)theTimer
{
    NSLog(@"Hit timer checkpoint, textfield contents = %@", customTextField.text);
}

#pragma mark -
#pragma mark UIViewController Methods

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void) addChangeButton
{
    NSLog(@"Hit Change Button, %@", self);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change Font" style:UIBarButtonItemStylePlain target:self action:@selector(changeFont)];
}

- (void)viewDidLoad 
{
	if ( self.chosenFont == nil )
		self.chosenFont = [[[DAPossibleFonts sharedInstance] fullFontList] objectAtIndex:0];

	self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(timerCheckpoint:) userInfo:nil repeats:YES];
    [self.timer fire];
//    
//    NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
//    [theRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
	[self addChangeButton];
		
	// initializes example string to default value
	[self reloadExampleString];
	
	// Add back button here for use by subview we push to
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	// Used to determine size of cell elements
	exampleCell = (FontSizeCell *)[[UITableViewCell cellFromXibName:@"FontSizeCell"] retain];

    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated 
{
	self.navigationItem.title = self.chosenFont;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillAppear:) 
												 name:UIKeyboardWillShowNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillDisappear:) 
												 name:UIKeyboardWillHideNotification
											   object:nil];	
	[super viewWillAppear:animated];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Table view methods

#define MAX_FONT_SIZE 100

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX_FONT_SIZE;
}

// Uncomment to control the height of cells in the table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = [self determineLabelHeightForIndexPath:indexPath] + 30;
	height = MAX( 50, height );
	return height;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    FontSizeCell *cell = (FontSizeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (FontSizeCell *)[UITableViewCell cellFromXibName:@"FontSizeCell"];
	}
    
    // Set up the cell...
    
    NSString *fontName = self.chosenFont;
    
	[cell setFontName:fontName size:indexPath.row exampleText:fontExampleString];
	
	if ( indexPath.row == self.selectedCell )
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;

	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
	NSString *rowDescription;
	NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selectedCell inSection:0];
	
	self.selectedCell = indexPath.row;
	
	// Clear old cell
	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:oldIndexPath] withRowAnimation:UITableViewRowAnimationFade];
	
	// Check new cell
	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if ( indexPath.row == 5 )
	{
		NSLog(@"Row description:%@", rowDescription);
	}
	
}



@end





