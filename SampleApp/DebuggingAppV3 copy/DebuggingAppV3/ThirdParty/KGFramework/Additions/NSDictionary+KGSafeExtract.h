//
//  NSDictionary+KGSafeExtract.h
//  KGFramework
//
//  Created by Kendall Gelner on 11/01/11.
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


#import <Foundation/Foundation.h>

@interface NSDictionary (KGSafeExtract)

// Always returns a string/nil value, even if the data parsed as a number or NSNull.
- (NSString *)safeStringForKey:(id)key;

// Always returns an NSNumber/nil value, parsing any strings as if they were double values.
- (NSNumber *)safeNumberForKey:(id)key;

// Tries a few different ways to determine if a passed in value is true or false.
// Acceptable values are any variant of:
// Yes/yes/y/True/true/t/1
// No/no/n/False/false/f/0
- (BOOL)safeBoolForKey:(id)key;

@end
