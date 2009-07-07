//
//  FlippedView.m
//  Pivotal
//
//  Created by Antonio on 17/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "FlippedView.h"


@implementation FlippedView


- (id)initWithFrame:(CGRect)frame andController:(MainController*)aController {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		mainController = aController;
		
		font = [UIFont fontWithName:@"Georgia" size:30];
		boldFont = [UIFont fontWithName:@"Georgia-Bold" size:28];

		CGRect labelPos = CGRectMake(5, 10, frame.size.width / 2, 40);
		title = [[UILabel alloc] initWithFrame:labelPos];
		[title setTextColor:[UIColor whiteColor]];				
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	if(story != nil) {		
		[title setText:[story name]];
		[points setText:[NSString stringWithFormat:@"%d points",[story points]]];
		[description setText:[story description]];
		NSArray *requestedtParts = [[story acceptedAt] componentsSeparatedByString:@" "];
		if([requestedtParts count] > 1) {
			[accepted setText:[requestedtParts objectAtIndex:0]];			
		} else {
			[accepted setText:[story acceptedAt]];			
		}
		[owned setText:[story ownedBy]];
		NSArray *createdAtParts = [[story createdAt] componentsSeparatedByString:@" "];
		if([createdAtParts count] > 1) {
			[created setText:[createdAtParts objectAtIndex:0]];			
		} else {
			[created setText:[story createdAt]];
		}
		[requested setText:[story requested]];
		
		if([story state] == FINISHED) {
			[state setTitle:@"Finished" forState:UIControlStateNormal];
			[state setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[state setTitleShadowColor:[UIColor greenColor] forState:UIControlStateNormal];
		} else if([story state] == PENDING || [story state] == WORKING) {
			if([story state] == PENDING) {
				[state setTitle:@"Pending" forState:UIControlStateNormal];
			} else {
				[state setTitle:@"Working" forState:UIControlStateNormal];				
			}
			[state setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[state setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];			
		}
	}
}


- (void)dealloc {
    [super dealloc];
}

@synthesize story;
@synthesize points;
@synthesize stateLabel;
@synthesize descriptionLabel;
@synthesize requestedLabel;
@synthesize ownedLabel;
@synthesize createdLabel;
@synthesize acceptedLabel;

@synthesize state;
@synthesize description;
@synthesize requested;
@synthesize owned;
@synthesize created;
@synthesize accepted;
@synthesize  title;
@synthesize back;


@end
