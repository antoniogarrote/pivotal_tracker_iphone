//
//  Developer.h
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"


@interface Developer : NSObject {
	NSMutableArray *stories;
	NSString *identifier;
}

- (id) initWithIdentifier:(NSString*)anIdentifier;
- (void) addStory:(Story*)aStory;
- (NSMutableArray*) stories;

- (CGFloat) completedPercentage;

- (NSString*) identifier;
@end
