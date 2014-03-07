//
//  NSDictionary+KGGroupFlagDict.h
//  KGFrameworkDemo-iPad
//
//  Created by Kendall Gelner on 11/30/11.
//  Copyright (c) 2011 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (KGGroupFlagDict)

// Creates a dictionary where the passed in array are used as keys, and point to NSNumber boolean values 
// that equal your desired initial value.
+ (NSMutableDictionary *)groupFlagDictionaryFromKeys:(NSArray *)keys withInitialValue:(BOOL)initialValue;
  
// Sets an NSNumber boolean YES for the given key in the dictionary
- (void) markFlagCompleteForKey:(NSString *)key;

// Sets an NSNumber boolean NO for the given key in the dictionary
- (void) markFlagIncompleteForKey:(NSString *)key;

// Returns TRUE if all values in the dictionary are NSNumber YES values
- (BOOL) allFlagsComplete;

@end
