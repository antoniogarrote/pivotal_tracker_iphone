//
//  UIBranaCell.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class UIBranaController;
@class Story;

#define LEFT_EDGE 0
#define INNER 1
#define RIGHT_EDGE 2
#define UNICELL 3

@interface UIBranaCell : UIView {
	Story* story;
	int position;
	UIBranaController* branaController;
	BOOL selected;
	BOOL showUser;
	CGRect orginalFrame;
}

@property(retain,readwrite) Story* story;
@property(readwrite) int position;
@property(readwrite,retain) UIBranaController* branaController;

-(id)initWithFrame:(CGRect)frame story:(Story*)aStory andPosition:(int)thePosition;
- (NSComparisonResult)compareYFrame:(UIBranaCell*)cell;
-(void)setPosition:(int)positionName;
-(void)update:(Story*)aStory andPosition:(int)thePosition;
-(void)singleTouchCallback:(id)event;
- (BOOL) selected;
- (void) setSelected:(BOOL)isSelected;
- (void) setColor:(UIColor*)aColor;
- (void) drawCell:(CGRect)rect withColor:(UIColor*)aColor;
- (BOOL) showUser;
- (void) setShowUser:(BOOL)mustShow;

- (void) reset;

@end
