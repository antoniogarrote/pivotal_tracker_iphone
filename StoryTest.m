//
//  StoryTest.m
//  Pivo
//
//  Created by Antonio on 06/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "Story.h"
#import "GTMSenTestCase.h"

@interface StoryTest : SenTestCase {
	
}

-(void)testPointsGetterSetter;

@end


@implementation StoryTest

-(void)testInitWithPoints {
	Story* theStory = [[Story alloc] initWithPoints:5];
	STAssertNotNULL(theStory,@"The initalized object cannot be null");
	STAssertTrue(5==[theStory points],@"The initialized object should have the initialized complexity points");
}

-(void)testPointsGetterSetter {
	Story* theStory = [[Story alloc] init];
	[theStory setPoints:5];
	STAssertTrue(5==[theStory points],@"The story has the points setted");
}

@end
