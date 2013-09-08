//
//  NSNull+ActAsNil.m
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


#import "NSNull+ActAsNil.h"


@implementation NSNull(ActAsNil)


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
	if ( [self respondsToSelector:[anInvocation selector]] )
	{
		[anInvocation invokeWithTarget:self];
	}
	
	// If we didn't understand the message, we just give up.
}

// You are still required to implement this class to ignore messages.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
	NSMethodSignature *sig;
	sig=[[NSNull class] instanceMethodSignatureForSelector:aSelector];
	if(sig==nil)
	{
		sig=[NSMethodSignature signatureWithObjCTypes:"@^v^c"];		
	}
	return sig;
}

// Loads explcitly and lets you know it's in place.
- (void) loadHook
{
  NSLog(@"NSNull protection loaded");
}

@end
