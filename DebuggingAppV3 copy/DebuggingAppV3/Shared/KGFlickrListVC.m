//
//  KGFirstViewController.m
//  DebuggingAppV2
//
//  Created by Kendall Helmstetter Gelner on 9/7/12.
//  Copyright (c) 2012 KiGi Software, LLC. All rights reserved.
//

#import "KGFlickrListVC.h"

#import <CoreData/CoreData.h>
#import "KGFlickrItem.h"
#import "KGFlickrMedia.h"
#import "KGRandomNewPhotosRequest.h"
#import "KGFriendNewPhotosRequest.h"
#import "KGFlickrItemCell.h"
#import "UIImageView+AFNetworking.h"
#import "KGInspectFlickrItemVC.h"

@interface KGFlickrListVC ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UINib *cellLoader;
@property (nonatomic, strong) NSArray *flickrItems;

@end

@implementation KGFlickrListVC
@synthesize activityIndicator;
@synthesize flickUserIDTextField;
@synthesize myTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Flickr", @"Flickr");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void) populateTable
{
    NSError *error = nil;
    //[self.fetchedResultsController performFetch:&error];
    self.flickrItems = [KGFlickrItem allFlickrItems];
    [self.myTable reloadData];
    if ( error )
    {
        NSLog(@"Error in fetching new results: %@", error);
    }
}

- (void) loadData
{
    self.activityIndicator.hidden = NO;

    
    [KGRandomNewPhotosRequest performRequestWithSuccessHandler:^(NSArray *flickrItems) {
        // New flickr items should be auto-loaded by fetched results controller.
        [self populateTable];
    } failureHandler:^(NSError *error) {
        // Issue alert
    } finallyHandler:^{
        // Dismiss busy indicator, if any.
        self.activityIndicator.hidden = YES;
    }];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.fetchedResultsController = [KGFlickrItem fetchedResultsControllerForFlckrItems];
//    self.fetchedResultsController.delegate = self;
    
    self.cellLoader = [UINib nibWithNibName:@"KGFlickrItemCell" bundle:nil];

    // show any loaded data
    //[self populateTable];
    
    // Load new data from the network
    [self loadData];
    
    // For later debugging
    // expression --unwind-on-error=0
}

// ViewDidUnload gone by Apple edict

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
#pragma mark -
#pragma mark Text Field

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [KGFlickrItemCell heightForCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
//    if ( [_fetchedResultsController sections] )
//        return 1;
//    else
//        return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
//    id  sectionInfo =[_fetchedResultsController sections];
//    
//    if ( [sectionInfo count ] == 0 )
//    {
//        return 0;
//    }
//    else
//    {
//        id sectionReal = [sectionInfo objectAtIndex:section];
//        return [sectionReal numberOfObjects];
//    }
    
    return self.flickrItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FlickrItemCell";
    
    KGFlickrItemCell *cell =
    (KGFlickrItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil )
    {
        cell = [[self.cellLoader instantiateWithOwner:self options:nil] lastObject];
    }
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(KGFlickrItemCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        KGFlickrItem *item = [self.flickrItems objectAtIndex:indexPath.row];
        //[self.fetchedResultsController objectAtIndexPath:indexPath];
        //    cell.textLabel.text = info.name;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
        //                                 info.city, info.state];
        
        cell.titleLabel.text = item.title;
        cell.usernameLabel.text = item.authorName;
        cell.imageThumb.image = nil;
        KGFlickrMedia *media = [item.media anyObject];
        [cell.imageThumb setImageWithURL:[NSURL URLWithString:media.mediaURL]];
    }
    @catch (NSException *exception) {
        // In this case, clear out cell
    
        cell.titleLabel.text = @"";
        cell.usernameLabel.text = @"";
        cell.imageThumb.image = nil;
    }
    @finally {
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KGFlickrItem *item = [self.flickrItems objectAtIndex:indexPath.row];
    //KGFlickrItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];

    KGInspectFlickrItemVC *inspectVC = [[KGInspectFlickrItemVC alloc] initWithNibName:@"KGInspectFlickrItemVC" bundle:nil];
    inspectVC.item = item;
    inspectVC.delegate = self;
    [self.navigationController pushViewController:inspectVC animated:YES];
}



#pragma mark -
#pragma mark Fetched Results Controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.myTable beginUpdates];
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.myTable;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            if (indexPath) {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(KGFlickrItemCell *)[self.myTable cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.myTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.myTable endUpdates];
}



#pragma mark -
#pragma mark Actions

- (void) viewPhotosForFlickrID:(NSString *)flickrID
{
    if (flickrID.length == 0 )
    {
        // Just go back to random.
        [self loadData];
        return;
    }
    
    self.flickUserIDTextField.text = flickrID;
    
    [KGFlickrItem clearAllItems];
    [self populateTable];
    self.activityIndicator.hidden = NO;
    [KGFriendNewPhotosRequest performRequestForFriendFlickrID:flickrID successHandler:^(NSArray *flickrItems) {
        // New flickr items should be auto-loaded by fetched results controller.
        [self populateTable];
    } failureHandler:^(NSError *error) {
        // Issue alert
    } finallyHandler:^{
        // Dismiss busy indicator, if any.
        self.activityIndicator.hidden = YES;
    }];
}

- (IBAction)showFriendImagesPressed:(id)sender
{
    [self.flickUserIDTextField resignFirstResponder];
    [self viewPhotosForFlickrID:self.flickUserIDTextField.text];
}

- (IBAction)findFlickrUserIDPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.flickr.com/services/api/explore/flickr.people.findByUsername"]];
}
- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}
@end
