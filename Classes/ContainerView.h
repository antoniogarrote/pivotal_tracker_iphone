//
//  ContainerView.h
//  Pivotal
//
//  Created by Antonio on 17/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlippedView.h"

@interface ContainerView : UIView {
	UIView *branaContainerView;
	FlippedView *flippedView;
	BOOL shouldFlipFront;
	BOOL shouldFlipBack;
}

- (void) scheduleFlipFront;
- (void) scheduleFlipBack;
- (void) flippingViews; 

@property(nonatomic,retain,readwrite) IBOutlet FlippedView *flippedView;
@property(nonatomic,retain,readwrite) IBOutlet UIView *branaContainerView;

@end
