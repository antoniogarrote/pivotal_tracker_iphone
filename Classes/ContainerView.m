//
//  ContainerView.m
//  Pivotal
//
//  Created by Antonio on 17/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "ContainerView.h"


@implementation ContainerView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		shouldFlipBack = NO;
		shouldFlipFront = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"DRAWING CONTAINER");
}

- (void) flippingViews {
	if(shouldFlipBack == YES) {
		NSLog(@"FLIPPING BACK");
		// setup the animation group
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.75];
		[UIView setAnimationDelegate:self];
		
		
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:NO];
     	[branaContainerView removeFromSuperview];
		[self addSubview:flippedView];
		
		[UIView commitAnimations];
		shouldFlipBack = NO;
	} else 	if(shouldFlipFront == YES) {
		NSLog(@"FLIPPING FRONT");
		// setup the animation group
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.75];
		[UIView setAnimationDelegate:self];
		
		
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:NO];
		[flippedView removeFromSuperview];
		CGRect test = [branaContainerView frame];
		[self addSubview:branaContainerView];
		
		[UIView commitAnimations];
		shouldFlipFront = YES;
	}
	
}

- (void)dealloc {
    [super dealloc];
}

- (void) scheduleFlipFront {
	shouldFlipFront = YES;
}
- (void) scheduleFlipBack {
	shouldFlipBack = YES;
}

@synthesize flippedView;
@synthesize branaContainerView;

@end
