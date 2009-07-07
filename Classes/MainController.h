//
//  MainController.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlippedView.h"
#import "ContainerView.h"

@class UIBranaController;
@class Story;

@interface MainController : UIViewController {
	UIBranaController* theBranaController;
	UIToolbar *toolbar;
	UILabel *currentStoryLabel;
	FlippedView *flippedView;
	UIView *intro;
	ContainerView *container;
}

@property(retain,nonatomic) IBOutlet UIBranaController *theBranaController;
@property(retain,nonatomic) IBOutlet UIToolbar *toolbar;
@property(retain,nonatomic) IBOutlet UILabel *currentStoryLabel;
@property (retain,readwrite) IBOutlet FlippedView *flippedView;
@property (retain,readwrite) IBOutlet ContainerView *container;
@property (retain,readwrite) IBOutlet UIView *intro;

// Actions
-(void)changeSelectedStory:(Story*)story;
-(void)flipView:(Story*)story;
-(void)backToTopTouched:(id)button;

@end
