//
//  Story.h
//  Pivo
//
//  Created by Antonio on 06/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#define FINISHED 0
#define WORKING 1
#define PENDING 2


#define FEATURE 0
#define CHORE 1
#define BUG 2
#define RELEASE 3

@interface Story : NSObject {
	int points;	
	int state;
	int identifier;
	int storyType;
	NSString* url;
	NSString* description;
	NSString* name;
	NSString* requested;
	NSString* ownedBy;
	NSString* createdAt;
	NSString* acceptedAt;
	NSString* labels;
	int delayed;
}

- (id) init;

/**
 * Creates a new Story object initiating it with the 
 * given points
 */
-(id) initWithPoints:(int)initialPoints;

/**
 * Creates a new Story object with the given state
 */
-(id) initWithState:(int)initialState;

/**
 * Creates a new Story object with the given state and points
 */
-(id) initWithPoints:(int)initialPoints andState:(int)initialState;

- (CGFloat) daysPerPoint;

- (BOOL) checkDelayed:(CGFloat) velocity;
- (NSComparisonResult)comparePendingState:(Story*)story;

/**
 * The complexity points assigned to this story
 */
@property(nonatomic,readwrite) int points;

/**
 * The state of the Story: pending, working or finished
 */
@property(nonatomic,readwrite) int state;

@property(nonatomic,readwrite) int identifier;
@property(nonatomic,readwrite) int storyType;
@property(nonatomic,retain,readwrite) NSString* url;
@property(nonatomic,retain,readwrite) NSString* description;
@property(nonatomic,retain,readwrite) NSString* name;
@property(nonatomic,retain,readwrite) NSString* requested;
@property(nonatomic,retain,readwrite) NSString* ownedBy;
@property(nonatomic,retain,readwrite) NSString* createdAt;
@property(nonatomic,retain,readwrite) NSString* acceptedAt;
@property(nonatomic,retain,readwrite) NSString* labels;

@end
