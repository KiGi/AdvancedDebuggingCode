#import "_KGFlickrItem.h"

@interface KGFlickrItem : _KGFlickrItem {}
// Custom logic goes here.

+ (KGFlickrItem * ) createFlickrItem;

+ (void) clearAllItems;

+ (void) saveAllModfiedFlickrItems;

// Fetched results controller that always looks at flickr items
+ (NSFetchedResultsController *)fetchedResultsControllerForFlckrItems;

+ (NSArray *)allFlickrItems;


@end
