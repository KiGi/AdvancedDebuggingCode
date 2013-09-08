//
//  UIViewController+UIViewController_KGUniversalVC.h
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


#import <UIKit/UIKit.h>

@interface UIViewController (KGUniversalVC)

// Returns a view controller with the associated nib - the base name is converted into an existing nib name via the 
// following rules:
// 1) First look for platform specific variants
// <nibBaseName>ViewiPhone
// <nibBaseName>ViewiPad
// 2) Then look for variations on the name
// <nibBaseName>View

+ (id) newUniversalViewControllerWithNibBaseName:(NSString *)nibBaseName;
+ (id) newUniversalViewControllerWithNibBaseName:(NSString *)nibBaseName bundle:(id)bundle;

@end
