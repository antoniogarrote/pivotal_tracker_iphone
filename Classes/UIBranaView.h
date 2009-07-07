//
//  UIBranaView.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BRANA_WIDTH_RATIO  3
#define BRANA_HEIGHT_RATIO  4

@class UIBranaController;

@interface UIBranaView : UIView {
	int touchCounter;
	int endTouchCunter;
	
	UITouch *upperTouch;
	UITouch *lowerTouch;
	
	CGPoint upperPoint;
	CGPoint lowerPoint;
	
	CGPoint movingUpperPoint;
	CGPoint movingLowerPoint;	
	CGPoint finalUpperPoint;
	CGPoint finalLowerPoint;
	
	//another perspective
	CGPoint pointOne;
	CGPoint pointTwo;
	
	UIBranaController *branaController;
	
	BOOL shouldReset;	
}

- (void) scheduleReset;

@property(nonatomic,retain,readwrite) IBOutlet UIBranaController *branaController;

@end
