//
//  UIBranaCell.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "UIBranaCell.h"
#import "Story.h"
#import "UIBranaController.h"

void CGContextAddRoundedRect (CGContextRef c, CGRect rect, int corner_radius) {  
     int x_left = rect.origin.x;  
     int x_left_center = rect.origin.x + corner_radius;  
     int x_right_center = rect.origin.x + rect.size.width - corner_radius;  
     int x_right = rect.origin.x + rect.size.width;  
     int y_top = rect.origin.y;  
     int y_top_center = rect.origin.y + corner_radius;  
     int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;  
     int y_bottom = rect.origin.y + rect.size.height;  
       
     /* Begin! */  
     CGContextBeginPath(c);  
     CGContextMoveToPoint(c, x_left, y_top_center);  
       
     /* First corner */  
     CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);  
     CGContextAddLineToPoint(c, x_right_center, y_top);  
       
     /* Second corner */  
     CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);  
     CGContextAddLineToPoint(c, x_right, y_bottom_center);  
       
     /* Third corner */  
     CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);  
     CGContextAddLineToPoint(c, x_left_center, y_bottom);  
       
     /* Fourth corner */  
     CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);  
     CGContextAddLineToPoint(c, x_left, y_top_center);  
       
     /* Done */  
     CGContextClosePath(c);  
       
}  

@implementation UIBranaCell

@synthesize story;
@synthesize position;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		selected = NO;
		showUser = NO;
		orginalFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame story:(Story*)aStory andPosition:(int)thePosition {
	if (self = [super initWithFrame:frame]) {
		selected = NO;
		showUser = NO;
        [aStory retain];
		story = aStory;
		position = thePosition;
		orginalFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    }
    return self;
}

-(void)setPosition:(int)positionName {
	position = positionName;
}

- (void) reset {
	[self setFrame:orginalFrame];
}

-(void)update:(Story*)aStory andPosition:(int)thePosition {
	[story release];
	[aStory retain];
	story = aStory;
	position = thePosition;
}

- (void)drawRect:(CGRect)rect {
	int state = [story state];
	UIColor *color = nil;
	
	switch (state) {
		case FINISHED:
			color = [UIColor greenColor];			
			break;
	    case WORKING:
			color = [UIColor yellowColor];
			if([story checkDelayed:0.0]) {
				color = [UIColor redColor];
			}
			break;
		default:
			color = [UIColor grayColor];
			break;
	}
	
	if(selected == YES) {
		color = [UIColor whiteColor];
	}
	if(showUser == YES) {
		color = [UIColor blueColor];
	}
	[self drawCell:rect withColor:color];
}

- (void) setColor:(UIColor*)aColor {
	[self drawCell:[self frame] withColor:aColor];
}

- (BOOL) selected {
	return selected;
}

- (void) setSelected:(BOOL)isSelected {
	selected = isSelected;
}

- (BOOL) showUser {
	return showUser;
}

- (void) setShowUser:(BOOL)mustShow {
	showUser = mustShow;
}

- (void) drawCell:(CGRect)rect withColor:(UIColor*)aColor {
	// Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetLineWidth(context, 10);	
	
	[aColor set];
	
	CGRect colorArea = [self bounds];
	CGRect rightColorArea = [self bounds];
	
	colorArea.origin.y = (colorArea.size.height * 0.1);
	colorArea.size.height = colorArea.size.height - (colorArea.size.height * 0.2);
	
	rightColorArea.origin.y = (rightColorArea.size.height * 0.1);
	rightColorArea.size.height = rightColorArea.size.height - (rightColorArea.size.height * 0.2);
	
	if(position == LEFT_EDGE) {
		colorArea.origin.x = (colorArea.size.width * 0.2);		
		UIRectFill(colorArea);
		
		CGRect miniRect = [self bounds];
		miniRect.origin.x = miniRect.size.width * 0.1;
		miniRect.origin.y = (miniRect.size.height * 0.1);
		miniRect.size.width = miniRect.size.width * 0.5;
		miniRect.size.height = miniRect.size.height * 0.8; //- (miniRect.size.height * 0.5);		
		CGContextAddRoundedRect(context, miniRect, 10);  
		CGContextFillPath(context); 
		
	} else if(position == RIGHT_EDGE) {
		colorArea.size.width = colorArea.size.width - (colorArea.size.width * 0.2);		
		CGContextAddRoundedRect(context, colorArea, 10);  
		CGContextFillPath(context); 
		
		colorArea.size.width = colorArea.size.width*0.3;
		UIRectFill(colorArea);		
	} else if (position == UNICELL) {
		CGRect miniRect = [self bounds];
		miniRect.origin.x = miniRect.size.width * 0.1;
		miniRect.origin.y = (miniRect.size.height * 0.1);
		miniRect.size.width = miniRect.size.width - (3 * (miniRect.size.width * 0.01));
		miniRect.size.height = miniRect.size.height - (2 * (miniRect.size.height * 0.1));	
		CGContextAddRoundedRect(context, miniRect, 10);  
		CGContextFillPath(context); 
		UIRectFill(miniRect);
	} else {
		UIRectFill(colorArea);
	}
	
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 0.0, 0.0, 0.06,  // Start color
	0.0, 0.0, 0.0, 0.35 }; // End color
	
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
	
    CGRect currentFrame = colorArea;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentFrame), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentFrame), (currentFrame.origin.y + currentFrame.size.height));
    CGContextDrawLinearGradient(context, glossGradient, topCenter, midCenter, 0);
	
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);

	/*
	[[UIColor blackColor] set];
	CGRect blackTop = [self bounds];
	blackTop.size.height = blackTop.size.height * 0.1;
	UIRectFill(blackTop);
	
	blackTop.origin.y = [self bounds].size.height * 0.9;
	UIRectFill(blackTop);	
	
	if(position == LEFT_EDGE) {
		blackTop.origin.y = 0;
		blackTop.size.height= [self bounds].size.height;
		blackTop.size.width = [self bounds].size.width * 0.1;
		UIRectFill(blackTop);	
	} if(position == RIGHT_EDGE) {
		blackTop = [self bounds];
		blackTop.origin.y = 0;
		blackTop.origin.x = blackTop.size.width - (blackTop.size.width * 0.2);	
		blackTop.size.height= [self bounds].size.height;
		blackTop.size.width = [self bounds].size.width * 0.3;
		UIRectFill(blackTop);	
	}
	*/
}

- (void)dealloc {
	if(story) {
		[story dealloc];
	}
    [super dealloc];
}

// event handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began");	
	NSSet *allTouches = [event allTouches];
	if([allTouches count] == 1) { // if > 1 handled by the UIBrana View
		UITouch* touch = [touches anyObject];
		if([touch tapCount] == 2) {
			[NSObject cancelPreviousPerformRequestsWithTarget:self];
		}	
	} else {
		[[self superview] touchesBegan:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches moved");
	[[self superview] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended");	
	NSSet *allTouches = [event allTouches];
	if([allTouches count] == 1) { // if > 1 handled by the UIBrana View
		UITouch* touch = [touches anyObject];
		if([touch tapCount] == 1) {
			NSLog(@"SINGLE");		
			[self performSelector:@selector(singleTouchCallback:) withObject:event afterDelay: 0.5];
		} else {
			// multitouch -> flip and info
			NSLog(@"DOUBLE");		
			[branaController flipStoryForCell:self];	
		}	
	} else {
		// in touches moved
		[[self superview] touchesEnded:touches withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches cancelled");	
}

-(void)singleTouchCallback:(id)event {
	[branaController singleTouchInCell:self];	
}
// end of event handling

- (NSComparisonResult)compareYFrame:(UIBranaCell*)cell {
	return [[NSNumber numberWithInt:[self frame].origin.y] compare:[NSNumber numberWithInt:[cell frame].origin.y]];
}


@synthesize branaController;

@end
