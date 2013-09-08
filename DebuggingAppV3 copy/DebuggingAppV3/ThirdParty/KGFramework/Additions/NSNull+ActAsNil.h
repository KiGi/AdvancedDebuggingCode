//
//  NSNull+ActAsNil.h
//  KGFramework
//
//  Created by Kendall Gelner on 3/10/10.
//  Copyright 2010 KiGi Software. All rights reserved.
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


// If you import this class into your project .pch file (or add the linker flag -ObjC),
// anytime a message is sent to NSNull it will be ignored, just as if the value were nil.
// This will prevent crashes from occuring, mostly around getting
// values out of JSON where NSNull objects can be returned in place of 
// expected types like NSString or NSNumber.

#import <Foundation/Foundation.h>


@interface NSNull(ActAsNil) 

// Something that ignores messages we do not respond to, just as nil would.
- (void)forwardInvocation:(NSInvocation *)anInvocation;

// Non-understood methods just have a blank signature.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;

// If you don't want to use -Objc -all_load flags, call this from anywhere once
// to ensure category is loaded.
- (void) loadHook;

@end
