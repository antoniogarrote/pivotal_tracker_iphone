//
//  Developer.m
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "Developer.h"


@implementation Developer

- (id) initWithIdentifier:(NSString*)anIdentifier {
	if(self = [super init]) {
		identifier = anIdentifier;
		stories = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) addStory:(Story*)aStory {
	[stories addObject:aStory];
}

- (NSMutableArray*) stories {
	return stories;
}

- (CGFloat) completedPercentage {
	CGFloat total = 0.0;
	CGFloat completed = 0.0;
	for(Story* story in stories) {
		if([story state] == FINISHED) {
			completed += [story points];
		}
		total += [story points];
	}
	return completed / total;
}

- (NSString*) identifier {
	return identifier;
}

- (void) dealloc {
	[identifier release];
	[stories release];
	[super dealloc];
}

@end
