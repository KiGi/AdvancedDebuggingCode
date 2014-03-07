//
//  DAChooseFontTableViewController.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/24/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "DAChooseFontTableViewController.h"

#import "DAMainFontExplorer.h"
#import "DAPossibleFonts.h"

@interface DAChooseFontTableViewController()
@property (nonatomic, assign) void (^refetcher)(void);
@end

@implementation DAChooseFontTableViewController

@synthesize delegate = delegate_;
@synthesize refetcher = refetcher_;


- (void)dealloc 
{
	[fontList release];
    [super dealloc];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void) refreshFontList
{
    [fontList release];
    fontList = [[[DAPossibleFonts sharedInstance] fullFontList] retain];
    [myTable reloadData];
}

- (void)viewDidLoad 
{	
	self.title = @"Choose Font";
    
    fontList = [[[DAPossibleFonts sharedInstance] fullFontList] retain];

    //[self refreshFontList];
        
    __block __typeof__(self) _self = self;
    self.refetcher = ^{
        [_self refreshFontList];
    };
	
    // Uncomment for crash!
	[self performSelector:@selector(hurryUp) withObject:nil afterDelay:7.0f];
	[self release];
	[self release];
	
	[super viewDidLoad];
}


- (void) hurryUp
{
	NSLog(@"Hurry!");
}


- (void)viewWillAppear:(BOOL)animated {
//    DAVCTracker *useTracker = [DATrackingManager trackingForVC:[self class]];
//    useTracker.VCLengthAccessed = 0;
//    self.tracker = useTracker;
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    //self.tracker.VCLengthAccessed = 30.0;
    //[DATrackingManager saveVCTrackingResults];
	[super viewWillDisappear:animated];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return fontList.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	BOOL createdCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		createdCell = YES;
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    NSInteger fontIndex = 0;
	NSString *fontName = [fontList objectAtIndex:fontIndex];
	cell.textLabel.font = [UIFont fontWithName:fontName size:17.0f];
	cell.textLabel.text = fontName;
	
	if ( [delegate.chosenFont isEqualToString:fontName] )
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
	
	if ( indexPath.row == 20 )
		NSLog(@"Created Cell %d", createdCell);
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	delegate.chosenFont = [fontList objectAtIndex:indexPath.row];	
	[self.navigationController popViewControllerAnimated:YES];
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


