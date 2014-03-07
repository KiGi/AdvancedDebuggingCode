//
//  NSDictionary+KGSafeExtract.m
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


#import "NSDictionary+KGSafeExtract.h"

@implementation NSDictionary (KGSafeExtract)

- (NSString *)safeStringForKey:(NSString *)key
{
    id candidateValue = [self objectForKey:key];
    if ( [candidateValue isKindOfClass:[NSString class]] )
    {
        return candidateValue;
    }
    else if ( [candidateValue isKindOfClass:[NSNumber class]] )
    {
        NSNumber *value = candidateValue;
        NSString *returnValue = [value stringValue];
        return returnValue;
    }
    else if ( [candidateValue isKindOfClass:[NSNull class]] )
    {
        return @"";
    }
    else
    {
        // Last dicth effort, get something out...
        NSString *returnValue = [candidateValue description];
        return returnValue;
    }
}

- (NSNumber *)safeNumberForKey:(NSString *)key
{
    id candidateValue = [self objectForKey:key];
    if ( [candidateValue isKindOfClass:[NSNumber class]] )
    {
        return candidateValue;
    }
    else if ( [candidateValue isKindOfClass:[NSString class]] )
    {
        double value = [candidateValue doubleValue];
        NSNumber *returnValue = [NSNumber numberWithDouble:value];
        return returnValue;
    }
    else 
    {
        return nil;
    }
}

- (BOOL)safeBoolForKey:(id)key
{
    id candidateValue = [self objectForKey:key];
    
    // First see if this fundamentally is numeric or not
    
    if ( [candidateValue isKindOfClass:[NSNumber class]] )
    {
        NSNumber *value = candidateValue;
        return [value boolValue];
    }
    else
    {
        // This protects against NSNull values.
        NSString *stringValue = [self safeStringForKey:key];

        // flatten case
        NSString *flatValue = [stringValue lowercaseString];
        
        BOOL finalValue = 
        [flatValue hasPrefix:@"t"] || [flatValue hasPrefix:@"f"] || [flatValue hasPrefix:@"1"];
        return finalValue;
    }
}


@end
