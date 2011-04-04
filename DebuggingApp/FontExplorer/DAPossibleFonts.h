//
//  DAPossibleFonts.h
//  DebuggingApp
//
//  Created by Kendall Gelner on 9/23/09.
//  Copyright 2009 KiGi Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DAPossibleFonts : NSObject 
{
	NSMutableArray *allFonts;
}

- (NSArray *) fullFontList;

// Singleton accessor
+ (DAPossibleFonts*)sharedInstance;


@end
