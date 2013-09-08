#import "KGFlickrItem.h"
#import "NSManagedObject+KGStore.h"
#import "KGStore.h"

@implementation KGFlickrItem

// Custom logic goes here.

+ (KGFlickrItem * ) createFlickrItem
{
    return [self create];
}

+ (void) clearAllItems
{
    NSArray *allItems = [self findAll];
    for ( NSManagedObject * item in allItems )
    {
        [item delete];
    }
    
    [KGStore save];
}

+ (void) saveAllModfiedFlickrItems
{
    NSManagedObjectContext *context = [[KGStore sharedInstance] context];
    NSError *error = nil;
    @try {
        [context save:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"Crash in saving new photos! %@", [exception userInfo]);
    }
    @finally {
    }
    if ( error )
    {
        NSLog(@"Error saving flickr items: %@", error);
    }
}


+ (NSFetchedResultsController *)fetchedResultsControllerForFlckrItems
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"published" ascending:YES]];
    
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:[[KGStore sharedInstance] context] sectionNameKeyPath:nil
                                                   cacheName:@"FlickrRoot"];

    
    return theFetchedResultsController;
}

+ (NSArray *)allFlickrItems;
{
    return [self findAll];
}


@end
