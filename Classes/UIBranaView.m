//
//  UIBranaView.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "UIBranaView.h"
#import "UIBranaController.h"
#import "UIBranaCell.h"


@implementation UIBranaView

@synthesize branaController;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		shouldReset = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"EN DRAW RECT");
	if(shouldReset == YES) {
		NSLog(@"A ANIMAR");
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		for(UIBranaCell *c in [branaController getCells]) {
			[c reset];	
		}
		
		[UIView commitAnimations];
		shouldReset = NO;		
	}		
	
}


// event handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began Brana");	
	NSSet *allTouches = [event allTouches];
	
	if([allTouches count] == 2) { 
		NSLog(@"2 fingers");

		pointOne = [[[allTouches allObjects] objectAtIndex:0] locationInView:self];
		pointTwo = [[[allTouches allObjects] objectAtIndex:1] locationInView:self];
	}		
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began Brana");	
	NSSet *allTouches = [event allTouches];
		
	if([allTouches count] == 2) { 
		NSLog(@"2 fingers");
		
		BOOL tooCloseMulti = NO;
		NSLog(@"TOUCHES:\n\n");
		for (UITouch* tmpTouch in [allTouches allObjects]) {
			CGFloat x = [tmpTouch locationInView:self].x;
			CGFloat y = [tmpTouch locationInView:self].y;
			NSLog(@"touch %f,%f",x,y);
			if(x==0 && y ==0) {
				tooCloseMulti = YES;
			}
		}
		NSLog(@"TOUCHES:\n\n");
		
		if(tooCloseMulti) {
			touchCounter = 1;
			upperTouch = [touches anyObject];
			[upperTouch retain];
		}
		
		
		switch (touchCounter) {
			case 0:
				touchCounter++;
				//[upperTouch release];
				//[lowerTouch release];
				upperTouch = [touches anyObject];
				[upperTouch retain];
				break;
				
			case 1:
				touchCounter = 0;
				UITouch *nextTouch = [touches anyObject];
				CGPoint nextPoint = [nextTouch locationInView:self];
				CGPoint oldPoint = [upperTouch locationInView:self];
				
				if(nextPoint.y > oldPoint.y) {
					lowerTouch = nextTouch;
				} else {
					UITouch *tmp = upperTouch;
					upperTouch = nextTouch;
					[upperTouch retain];
					lowerTouch = tmp;
				}
				
				upperPoint = [upperTouch locationInView:self];
				lowerPoint = [lowerTouch locationInView:self];
				
				break;
		}
	}
}
*/

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches moved");	
	NSSet *allTouches = [event allTouches];	
	if([allTouches count] == 2) {		
		CGPoint tmpPointOne = [[[allTouches allObjects] objectAtIndex:0] locationInView:self];
		CGPoint tmpPointTwo = [[[allTouches allObjects] objectAtIndex:1] locationInView:self];
		
		BOOL foundPointOne = NO;
		BOOL foundPointTwo = NO;
		
		if(tmpPointOne.x == pointOne.x && tmpPointOne.y == pointOne.y) {
			foundPointOne = YES;
		}
		if(tmpPointOne.x == pointTwo.x && tmpPointOne.y == pointTwo.y) {
			foundPointTwo = YES;
		}
		if(tmpPointTwo.x == pointOne.x && tmpPointTwo.y == pointOne.y) {
			foundPointOne = YES;
		}
		if(tmpPointTwo.x == pointTwo.x && tmpPointTwo.y == pointTwo.y) {
			foundPointTwo = YES;
		}
		
		if(foundPointOne == NO || foundPointTwo == NO) {
			if(pointOne.y > pointTwo.y) {
				upperPoint = pointTwo;
				lowerPoint = pointOne;
			} else {
				upperPoint = pointOne;
				lowerPoint = pointTwo;
			}
			
			if(tmpPointOne.y > tmpPointTwo.y) {
				finalUpperPoint = tmpPointTwo;
				finalLowerPoint = tmpPointOne;
			} else {
				finalUpperPoint = tmpPointOne;
				finalLowerPoint = tmpPointTwo;
			}
			
			
			if ((lowerPoint.y == 0 && lowerPoint.x == 0) ||
				(upperPoint.y == 0 && upperPoint.x == 0)) {
				CGPoint tmpUpper = upperPoint;
				CGPoint tmpFinalUpper = finalUpperPoint;
				upperPoint = lowerPoint;
				finalUpperPoint = finalLowerPoint;
				lowerPoint = tmpUpper;
				finalLowerPoint = tmpFinalUpper;
			}
			
			if((upperPoint.y > finalUpperPoint.y && lowerPoint.y < finalLowerPoint.y) ||
			   (upperPoint.y == 0 && upperPoint.x == 0 && lowerPoint.y < finalLowerPoint.y) ||
			   (upperPoint.y > finalUpperPoint.y && lowerPoint.y == 0 && lowerPoint.x == 0))
			{
				pointOne = tmpPointOne;
				pointTwo = tmpPointTwo;
				
				if (lowerPoint.y == 0 && lowerPoint.x == 0) {
					lowerPoint.y = upperPoint.y;
					lowerPoint.x = upperPoint.x;
					finalLowerPoint.y = upperPoint.y + (upperPoint.y - finalUpperPoint.y);
					finalLowerPoint.x = finalUpperPoint.x;										
				} else if (upperPoint.y == 0 && upperPoint.x == 0) {
					upperPoint.y = lowerPoint.y;
					upperPoint.x = lowerPoint.x;
					finalUpperPoint.y = lowerPoint.y - (finalLowerPoint.y - lowerPoint.y);
					finalUpperPoint.x = finalLowerPoint.x;
				}
				[branaController pinchedStoriesFromTopInitial:upperPoint topFinal:finalUpperPoint downInitial:lowerPoint downFinal:finalLowerPoint];
			} else {
				[branaController pinchedStoriesFromTopInitial:upperPoint topFinal:finalUpperPoint downInitial:lowerPoint downFinal:finalLowerPoint];				
			}
		}
	}
	}

/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {	
	NSLog(@"touches moved");	
	NSSet *allTouches = [event allTouches];	
	UITouch* nextTouch = [touches anyObject];
	
	if([allTouches count] == 2) { 
		NSLog(@"2 fingers touchesmoved");
		
		BOOL tooCloseMulti = NO;
		NSLog(@"TOUCHES MOVED:\n\n");
		for (UITouch* tmpTouch in [allTouches allObjects]) {
			CGFloat x = [tmpTouch locationInView:self].x;
			CGFloat y = [tmpTouch locationInView:self].y;
			NSLog(@"touch %f,%f",x,y);
			if(x==0 && y ==0) {
				tooCloseMulti = YES;
			}
		}
		NSLog(@"TOUCHES MOVED:\n\n");
		
		if(tooCloseMulti) {
			endTouchCunter = 1;
			upperTouch = [touches anyObject];
			[upperTouch retain];
		}
		
		
		switch (endTouchCunter) {
			case 0:
				endTouchCunter++;
				if(upperTouch == nextTouch) {
				  	finalUpperPoint = [upperTouch locationInView:self];
				} else {
					finalLowerPoint = [lowerTouch locationInView:self];
				}
				
				break;
				
			case 1:
				endTouchCunter = 0;
				if(upperTouch == nextTouch) {
				  	finalUpperPoint = [upperTouch locationInView:self];
				} else {
					finalLowerPoint = [lowerTouch locationInView:self];
				}
				//[upperTouch release];
				//[lowerTouch release];
				
				if(upperPoint.y > finalUpperPoint.y && lowerPoint.y < finalLowerPoint.y) {
					movingUpperPoint.x = upperPoint.x;
					movingUpperPoint.y = upperPoint.y;
					movingLowerPoint.x = lowerPoint.x;
					movingLowerPoint.y = lowerPoint.y;
					upperPoint.x = finalUpperPoint.x;
					upperPoint.y = finalUpperPoint.y;
					lowerPoint.x = finalLowerPoint.x;
					lowerPoint.y = finalLowerPoint.y;
					
					[branaController pinchedStoriesFromTopInitial:movingUpperPoint topFinal:finalUpperPoint downInitial:movingLowerPoint downFinal:finalLowerPoint];
				}
				break;
		}
		
	}
}
*/

- (void) scheduleReset {
	NSLog(@"SCHEDULING RESET");
	shouldReset = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended in UIBranaView");	
	[branaController resetBrana];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches cancelled");	
}
// end of event handling


- (void)dealloc {
    [super dealloc];
}

@end
