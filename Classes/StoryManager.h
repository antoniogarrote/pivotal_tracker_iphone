//
//  StoryManager.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"

@interface StoryManager : NSObject {
	NSMutableArray *finishedStories;
	NSMutableArray *workingStories;
	NSMutableArray *pendingStories;
	CGFloat velocity;
}

@property(readonly,nonatomic) NSMutableArray *finishedStories;
@property(readonly,nonatomic) NSMutableArray *workingStories;
@property(readonly,nonatomic) NSMutableArray *pendingStories;

-(id)init;

/**
 * Returns the total amount of complexity points for the stories managed.
 */
-(int)totalPoints;

/**
 * Returns the total number of stories
 */
-(int)totalStories;

/**
 * Inserts a story into the manager
 */
-(void)addStory:(Story*)story ofType:(int)type;
-(void)addPendingStory:(Story*)story;
-(void)addFinishedStory:(Story*)story;
-(void)addWorkingStory:(Story*)story;

/**
 * Returns the story at a certain position.
 * Treats the three stories arrays as a single array
 * with sequence: FINISHED - WORKING - PENDING.
 */
-(Story*)storyAtIndex:(int)position; 

-(void)loadStories:(NSMutableArray*)someStories;

-(void)loadDemoStories;

-(CGFloat) velocity;

@end
