//
//  NSDictionary+KGGroupFlagDict.m
//  KGFrameworkDemo-iPad
//
//  Created by Kendall Gelner on 11/30/11.
//  Copyright (c) 2011 KiGi Software. All rights reserved.
//

#import "NSMutableDictionary+KGGroupFlagDict.h"

@implementation NSMutableDictionary (KGGroupFlagDict)


+ (NSMutableDictionary *)groupFlagDictionaryFromKeys:(NSArray *)keys withInitialValue:(BOOL)initialValue
{
    NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithCapacity:keys.count];
    NSNumber *initialValueNumber = initialValue ? (NSNumber *)kCFBooleanTrue : (NSNumber *)kCFBooleanFalse;
    for ( id key in keys )
    {
        [retDict setObject:initialValueNumber forKey:key];
    }
    return retDict;
}

- (void) markFlagCompleteForKey:(NSString *)key
{
    [self setObject:(NSNumber *)kCFBooleanTrue forKey:key];
}

- (void) markFlagIncompleteForKey:(NSString *)key
{
    [self setObject:(NSNumber *)kCFBooleanFalse forKey:key];
}

- (BOOL) allFlagsComplete
{
    BOOL allComplete = YES;
    for ( NSNumber *boolVal in [self allValues] )
    {
        if ( boolVal == (NSNumber *)kCFBooleanFalse )
        {
            allComplete = NO;
            break;
        }
    }
    return allComplete;
}

@end
