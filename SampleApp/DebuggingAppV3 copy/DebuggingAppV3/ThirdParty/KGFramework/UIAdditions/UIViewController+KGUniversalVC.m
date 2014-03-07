//
//  UIViewController+UIViewController_KGUniversalVC.m
//  KGFrameworkDemo-iPad
//
//  Created by Kendall Gelner on 12/9/11.
//  Copyright (c) 2011 KiGi Software. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//


#import "UIViewController+KGUniversalVC.h"

@implementation UIViewController (KGUniversalVC)

+ (id) newUniversalViewControllerWithNibBaseName:(NSString *)nibBaseName
{
    return [self newUniversalViewControllerWithNibBaseName:nibBaseName bundle:nil];
}

+ (id) newUniversalViewControllerWithNibBaseName:(NSString *)nibBaseName bundle:(id)bundle
{
    BOOL isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    NSString *platformString = isPad ? @"iPad" : @"iPhone";
    NSString *viewAdjustedBaseName = [nibBaseName stringByAppendingString:@"View"];
    NSString *platformSpecificName = [NSString stringWithFormat:@"%@-%@", viewAdjustedBaseName, platformString];
    NSString *path = [[NSBundle mainBundle] pathForResource:platformSpecificName ofType:@"nib"];
    
    NSString *useNibName = nil;
    if ( path.length == 0 )
    {
        path = [[NSBundle mainBundle] pathForResource:viewAdjustedBaseName ofType:@"nib"];
        if ( path.length > 0 )
            useNibName = viewAdjustedBaseName;
    }
    else
    {
        useNibName = platformSpecificName;
    }
    
    id retVC = nil;
    
    if ( useNibName.length > 0 )
    {
        retVC = [[self alloc] initWithNibName:useNibName bundle:bundle];
    }
    
    return retVC;
}

@end
