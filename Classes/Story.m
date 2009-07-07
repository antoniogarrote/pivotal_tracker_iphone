//
//  Story.m
//  Pivo
//
//  Created by Antonio on 06/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "Story.h"


@implementation Story

@synthesize points;
@synthesize state;
@synthesize identifier;
@synthesize storyType;
@synthesize url;
@synthesize description;
@synthesize name;
@synthesize requested;
@synthesize ownedBy;
@synthesize createdAt;
@synthesize acceptedAt;
@synthesize labels;

- (id) init {
	if(self = [super init]) {
		delayed = -1;
	}
	return self;
}

-(id) initWithPoints:(int)initialPoints {
	self = [super init];
	points = initialPoints;
	state = PENDING;
	delayed = -1;
	return self;
}

-(id) initWithPoints:(int)initialPoints andState:(int)initialState {
	self = [super init];
	points = initialPoints;
	state = initialState;	
	delayed = -1;
	return self;
}

-(id) initWithState:(int)initialState {
	self = [super init];
	points = 0;
	state = initialState;	
	delayed = -1;
	return self;
}

- (BOOL) checkDelayed:(CGFloat) velocity {
	if(delayed == -1) {
		CGFloat averageVelocity = velocity * points;
		if(averageVelocity == 0) {
			return 0;
		}
		NSTimeInterval ti = [[NSDate dateWithNaturalLanguageString:createdAt]  timeIntervalSinceNow];
		NSTimeInterval usedVelocity = (ti / (60 * 60 *24));
		if(usedVelocity < 0) {
			usedVelocity = 0 - usedVelocity;
		}
	
		if(usedVelocity > averageVelocity) {
			delayed = 1;
		} else {
			delayed = 0;
		}
	}
	
	if(delayed == 0) {
		return NO;
	} else {
		return YES;
	}
}

- (CGFloat) daysPerPoint {
	if(state == FINISHED) {
		NSDate *createdDate = [NSDate dateWithNaturalLanguageString:createdAt];
		NSDate *acceptedDate = [NSDate dateWithNaturalLanguageString:acceptedAt];
		
		NSInteger days = ([acceptedDate timeIntervalSinceDate:createdDate] / (60 * 60 * 24));
		if(days < 0) {
			return  0 - days;
		} else {
			return days;
		}
	} else {
		return 0;
	}
}

- (NSComparisonResult)comparePendingState:(Story*)story {
	if([story checkDelayed:0.0]) {
		if([self checkDelayed:0.0]) {
			return [[NSDate dateWithNaturalLanguageString:createdAt]  compare:[NSDate dateWithNaturalLanguageString:[story createdAt]]];
		} else {
			return 1;
		}
	} else {
		if([self checkDelayed:0.0]) {
			return -1;			
		} else {
			return [[NSDate dateWithNaturalLanguageString:createdAt]  compare:[NSDate dateWithNaturalLanguageString:[story createdAt]]];
		}		
	}
}
@end
