//
//  DAPossibleFonts.m
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/23/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import "DAPossibleFonts.h"


static DAPossibleFonts *sharedInstance;

@implementation DAPossibleFonts

#pragma mark -
#pragma mark class instance methods

- (NSArray *)fullFontList
{
	allFonts = [[NSMutableArray alloc] init];
	
	NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
	NSArray *fontNames;
	NSInteger indFamily, indFont;
	for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
	{
		NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
		fontNames = [[NSArray alloc] initWithArray:
					 [UIFont fontNamesForFamilyName:
					  [familyNames objectAtIndex:indFamily]]];
		for (indFont=0; indFont<[fontNames count]; ++indFont)
		{
			NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont], indFamily);
			[allFonts addObject:[fontNames objectAtIndex:indFont]];
		}
	}
	
	return allFonts;
}

#pragma mark -
#pragma mark Singleton methods

+ (DAPossibleFonts*)sharedInstance
{
	@synchronized(self)
	{
		if (sharedInstance == nil)
			sharedInstance = [[DAPossibleFonts alloc] init];
	}
	return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (id)autorelease {
    return self;
}

@end
