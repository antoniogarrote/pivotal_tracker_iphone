//
//  StoryManagerTest.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "StoryManager.h"
#import "Story.h"

@class Story;
@class StoryManager;

@interface StoryManagerTest : SenTestCase {
	
}
@end

@implementation StoryManagerTest

-(void)testTotalPoints {
	StoryManager *manager = [[StoryManager alloc] init];

	STAssertNotNULL(manager,@"The created object should not be null");
	STAssertTrue(0==[manager totalPoints],@"The initialized manager doesn't have points");
	
	[manager addFinishedStory:[[Story alloc] initWithPoints:10]];
	STAssertTrue(10==[manager totalPoints],@"The initialized manager has the added points");
	
	[manager addPendingStory:[[Story alloc] initWithPoints:5]];
	STAssertTrue(15==[manager totalPoints],@"The initialized manager has the added points");
	
	[manager addWorkingStory:[[Story alloc] initWithPoints:2]];
	STAssertTrue(17==[manager totalPoints],@"The initialized manager has the added points");
	
	[manager addWorkingStory:[[Story alloc] initWithPoints:1]];
	STAssertTrue(18==[manager totalPoints],@"The initialized manager has the added points");
	
	
	NSMutableArray *stories = [manager workingStories];
	STAssertTrue(2==[stories count],@"The stories are correctly inserted");
	
	Story *first = [stories objectAtIndex:0];
	Story *second = [stories objectAtIndex:1];
	
	STAssertTrue(2==[first points],@"The first story has been kept in position");
	STAssertTrue(1==[second points],@"The second story has been kept in position");
	
	STAssertTrue(1==[[manager pendingStories] count],@"The stories are correctly inserted");
	
	STAssertTrue(1==[[manager finishedStories] count],@"The stories are correctly inserted");
}

-(void)testTotalStories {
	StoryManager *manager = [[StoryManager alloc] init];
	[manager addFinishedStory:[[Story alloc] initWithPoints:10]];	
	[manager addWorkingStory:[[Story alloc] initWithPoints:10]];	
	[manager addPendingStory:[[Story alloc] initWithPoints:10]];	
	[manager addWorkingStory:[[Story alloc] initWithPoints:10]];	
	
	STAssertTrue(4==[manager totalStories],@"The number of stories is correctly tracked");
}

-(void)testStoryAt {
	StoryManager *manager = [[StoryManager alloc] init];
	[manager addFinishedStory:[[Story alloc] initWithPoints:10 andState:FINISHED]];	
	[manager addWorkingStory:[[Story alloc] initWithPoints:10 andState:WORKING]];	
	[manager addPendingStory:[[Story alloc] initWithPoints:10 andState:PENDING]];	

	Story* story = [manager storyAtIndex:0];
	STAssertTrue(FINISHED==[story state],@"");
	
	story = [manager storyAtIndex:1];
	STAssertTrue(WORKING==[story state],@"");
	
	
	story = [manager storyAtIndex:2];
	STAssertTrue(PENDING==[story state],@"");
}
@end

