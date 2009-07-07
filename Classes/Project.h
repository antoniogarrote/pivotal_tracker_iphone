//
//  Project.h
//  Pivotal
//
//  Created by Antonio on 08/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//


@interface Project : NSObject {
	int identifier;
	NSString *name;
	int iterationLength;
	int weekStartDay;	
}

@property(nonatomic,readwrite) int identifier;
@property(retain,nonatomic,readwrite) NSString* name;
@property(nonatomic,readwrite) int iterationLength;
@property(nonatomic,readwrite) int weekStartDay;

@end
