//
//  StoryManager.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "StoryManager.h"
#import "Story.h"


@implementation StoryManager

@synthesize finishedStories;
@synthesize workingStories;
@synthesize pendingStories;

-(id)init {
	[super init];
	finishedStories = [[NSMutableArray alloc] init];
	pendingStories = [[NSMutableArray alloc] init];
	workingStories = [[NSMutableArray alloc] init];
	
	velocity = -1;
	return self;
}

-(int)totalPoints {
	int acum = 0;
	for(Story *story in finishedStories) {
		acum = acum + (int) [story points];
	}
	
	for(Story *story in workingStories) {
		acum = acum + (int) [story points];
	}
	
	for(Story *story in pendingStories) {
		acum = acum + (int) [story points];
	}
	
	return acum;
}

-(int)totalStories {
	return [finishedStories count] + [workingStories count] + [pendingStories count];
}

-(void)addStory:(Story*)story ofType:(int)type {
	[story retain];
	
	if(type==FINISHED) {
		[finishedStories addObject:story];
	} else if(type==WORKING) {
		[workingStories addObject:story];		
		[story checkDelayed:[self velocity]];
	} else if(type==PENDING) {
		[pendingStories addObject:story];		
	}
	
	[workingStories sortUsingSelector:@selector(comparePendingState:)];
}

-(void)addPendingStory:(Story*)story {
	[self addStory:story ofType:PENDING];
}

-(void)addFinishedStory:(Story*)story {
	[self addStory:story ofType:FINISHED];	
}

-(void)addWorkingStory:(Story*)story {
	[self addStory:story ofType:WORKING];	
	[story checkDelayed:[self velocity]];	
	[workingStories sortUsingSelector:@selector(comparePendingState:)];	
}	

-(Story*)storyAtIndex:(int)position {
	if(position < [finishedStories count]) {
		return (Story*) [finishedStories objectAtIndex:position];
	} else if( (position - [finishedStories count]) < [workingStories count] ) {
		return (Story*) [workingStories objectAtIndex:(position - [finishedStories count])];
	} else if( (position - [finishedStories count] - [workingStories count]) < [pendingStories count] ){
		return (Story*) [pendingStories objectAtIndex:(position - [finishedStories count] - [workingStories count])];		
	} else {
		return nil;
	}
}

-(void)loadDemoStories {
	[self addFinishedStory:[[Story alloc] initWithPoints:5 andState:FINISHED]];
	[self addFinishedStory:[[Story alloc] initWithPoints:3 andState:FINISHED]];	
	[self addFinishedStory:[[Story alloc] initWithPoints:7 andState:FINISHED]];		
	[self addWorkingStory:[[Story alloc] initWithPoints:2 andState:WORKING]];		
	[self addWorkingStory:[[Story alloc] initWithPoints:4 andState:WORKING]];	
	[self addPendingStory:[[Story alloc] initWithPoints:1 andState:PENDING]];		
	[self addPendingStory:[[Story alloc] initWithPoints:5 andState:PENDING]];		
	[self addPendingStory:[[Story alloc] initWithPoints:6 andState:PENDING]];		
	[self addPendingStory:[[Story alloc] initWithPoints:3 andState:PENDING]];		
}

-(void)loadStories:(NSMutableArray*)someStories {
	int type = FINISHED;
	
	for(Story* aStory in someStories) {
		[aStory retain];
		type = [aStory state];
		if(type==FINISHED) {
			[finishedStories addObject:aStory];
		} else if(type==WORKING) {
			[workingStories addObject:aStory];		
		} else if(type==PENDING) {
			[pendingStories addObject:aStory];		
		}
	}
	
	for(Story *aStory in workingStories) {
		[aStory checkDelayed:[self velocity]];
	}
	[workingStories sortUsingSelector:@selector(comparePendingState:)];
}

-(CGFloat) velocity {
	if(velocity == -1) {
		velocity = 0;
		for(Story *st in finishedStories) {
			velocity =  velocity + [st daysPerPoint];		
		}
		velocity = velocity / [finishedStories count];		
	}
	return velocity;
}

-(void) dealloc {	
	@try{
		for(Story *story in pendingStories) {
			[story release];
		}
		[pendingStories release];
	
		for(Story *story in finishedStories) {
			[story release];
		}
		[finishedStories release];
	
		for(Story *story in workingStories) {
			[story release];
		}
		[workingStories release];
	} @catch (NSException *theError) {
		NSLog(@"EXCEPTION:");
		NSLog([theError description]);
	} @finally {
		[super dealloc];		
	}

	[super dealloc];
}

@end