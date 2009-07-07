//
//  DeveloperView.m
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "DeveloperView.h"


@implementation DeveloperView


- (id)initWithFrame:(CGRect)frame  developer:(Developer*)aDeveloper andController:(DevelopersController*)controller {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		developer = aDeveloper;
		developerController = controller;
		[developerController retain];
		[developer retain];
		CGRect txtRect;
		
		UIFont* font = [UIFont systemFontOfSize:12];
		
		
		txtRect.size.height = 20;
		txtRect.size.width = 150;
		txtRect.origin.y = 0;
		txtRect.origin.x = -155;
		
		CGRect contRect;
		contRect.size.height = 24;
		contRect.size.width = 154;
		contRect.origin.y = -2;
		contRect.origin.x = -157;
		
		container = [[UIView alloc] initWithFrame:contRect];
		[container setBackgroundColor:[UIColor whiteColor]];
		
		txtView = [[UILabel alloc] initWithFrame:txtRect];
		[txtView setFont:font];
		[txtView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.7]];
		[txtView setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
		[txtView setTextAlignment:UITextAlignmentCenter];
		CGFloat completed_d = [developer completedPercentage];
		int completed_i = completed_d * 100;
		NSString *completed = [NSString stringWithFormat:@"%@ (%d%%)",[developer identifier],completed_i];
		[txtView setText:completed];
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGContextSetRGBFillColor(c, 
							 0,
							 0,
							 1,1);
	 
	
	CGContextBeginPath(c);  
	CGContextMoveToPoint(c, 3, 0);  
	CGContextAddLineToPoint(c, 3, rect.size.height);  
	CGContextAddLineToPoint(c, rect.size.width, (rect.size.height/2));  
	CGContextAddLineToPoint(c, 3, 0);  		
	/* Done */  
	CGContextClosePath(c);
	CGContextFillPath(c); 		
	

	
	CGContextSetRGBStrokeColor(c,
							   1,
							   1,
							   1,1);
	CGContextBeginPath(c);  
	CGContextMoveToPoint(c, 3, 0);  
	CGContextAddLineToPoint(c, 3, rect.size.height);  
	CGContextAddLineToPoint(c, rect.size.width, (rect.size.height/2));  
	CGContextAddLineToPoint(c, 3, 0);  		
	/* Done */  
	CGContextClosePath(c);
	CGContextSetLineWidth(c, 2);
	CGContextStrokePath(c);	
}

// Actions
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began Brana");	
	NSSet *allTouches = [event allTouches];
	if([allTouches count] == 1) { // if > 1 handled by the UIBrana View
		UITouch* touch = [touches anyObject];
		if([touch tapCount] == 1) {
			NSLog(@"SINGLE");		
			[developerController clickedOnDeveloper:developer];
			[self addSubview:container];
			[self addSubview:txtView];
		}	
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended");	
	[txtView removeFromSuperview];
	[container removeFromSuperview];
	[developerController clearDeveloper:developer];
}
//

- (void)dealloc {
	[developerController release];
	[developer release];
    [super dealloc];
}


@end