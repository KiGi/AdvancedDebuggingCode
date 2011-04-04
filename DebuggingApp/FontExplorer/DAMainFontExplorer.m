//
//  DAMainFontExplorer.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/23/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "DAMainFontExplorer.h"

#import "DAChooseFontTableViewController.h"
#import "UITableViewCellAdditions.h"
#import "DAPossibleFonts.h"

@interface DAMainFontExplorer ()
- (void) freeOutlets;
- (void) addChangeButton;
@end


@implementation DAMainFontExplorer

@synthesize fontExampleString;
@synthesize chosenFont;


- (void)dealloc 
{
	[chosenFont release]; chosenFont = nil;
	[fontExampleString release]; fontExampleString = nil;
	[self freeOutlets];
    [super dealloc];
}

- (void) freeOutlets
{
	[myTable release]; myTable = nil;
	[customTextField release]; customTextField = nil;
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
	int row = indexPath.row;
	UIFont *font = [UIFont fontWithName:chosenFont size:row];
	// This call is theoretically better, but does not actually work (always returns one row).  
	//CGSize bestSize = [fontExampleString sizeWithFont:font  forWidth:exampleCell.exampleTextLabel.frame.size.width lineBreakMode:UILineBreakModeWordWrap];
	CGSize bestSize = [fontExampleString sizeWithFont:font constrainedToSize:maxSize];
	
	return bestSize.height;
}

#pragma mark -
#pragma mark Actions

- (void) changeFont
{
	DAChooseFontTableViewController *chooseController = [[DAChooseFontTableViewController alloc] initWithNibName:@"DAChooseFontTableView" bundle:nil];
	[self.navigationController pushViewController:chooseController animated:YES];
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
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change Font" style:UIBarButtonItemStylePlain target:self action:@selector(changeFont)];
}

- (void)viewDidLoad 
{
	if ( chosenFont == nil )
		chosenFont = [[[DAPossibleFonts sharedInstance] fullFontList] objectAtIndex:0];
	

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
	self.navigationItem.title = chosenFont;
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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self freeOutlets];
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
	[cell setFontName:chosenFont size:indexPath.row exampleText:fontExampleString];
	
	if ( indexPath.row == selectedCell )
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;

	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
	NSString *rowDescription;
	NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:selectedCell inSection:0];
	
	selectedCell = indexPath.row;
	
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end





