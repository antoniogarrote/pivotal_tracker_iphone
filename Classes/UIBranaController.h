//
//  UIBranaController.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DevelopersController;
@class Developer;
@class StoryManager;
@class Story;
@class UIBranaCell;
@class PivotalWebBroker;
@class MainController;

@interface UIBranaController : UIViewController <UITextFieldDelegate> {
	StoryManager *storyManager;
	NSMutableArray *cells;
	PivotalWebBroker *pivotalWeb;	
	MainController *mainController;
	Story *selectedStory;
	CGFloat defaultCellWidth;
	CGFloat defaultCellHeight;	
	DevelopersController *developersController;	
	UIView *intro;
	UIView *introButtons;
	UIView *branaView;
	UITextField *login;
	UITextField *password;
	UIImageView *rosie;
}

-(void)setStoryManager:(StoryManager*)aStoryManager;
-(void)singleTouchInCell:(UIBranaCell*)cell;
-(void)pinchedStoriesFromTopInitial:(CGPoint)ui topFinal:(CGPoint)uf downInitial:(CGPoint)di downFinal:(CGPoint)df;
-(int)countRows:(NSMutableArray*)stories storingThemIn:(NSMutableArray**)collectedCells startingAtY:(CGFloat)startY endingWith:(CGFloat)downY andMode:(int)mode;

@property(retain,nonatomic,readonly) StoryManager *storyManager;
@property(retain,nonatomic,readwrite) IBOutlet MainController *mainController;
@property(nonatomic,retain,readwrite) Story *selectedStory;
@property(readwrite) CGFloat defaultCellWidth;
@property(readwrite) CGFloat defaultCellHeight;
@property (retain,readwrite) IBOutlet UIView *intro;
@property (retain,readwrite) IBOutlet UIView *introButtons;
@property (retain,readwrite) IBOutlet UIView *branaView;
@property (retain,readwrite) IBOutlet UITextField *login;
@property (retain,readwrite) IBOutlet UITextField *password;
@property (retain,readwrite) IBOutlet UIImageView *rosie;

-(void)fillRectWithStories:(NSMutableArray*)stories forHeight:(CGFloat)height andWidth:(CGFloat)width startingAt:(CGFloat)startingHeight;
-(NSMutableArray*)storiesInRegionBetween:(CGPoint)upperPoint and:(CGPoint)lowerPoing;
-(void)setDeveloper:(Developer*)developer showing:(BOOL)mustShow;
-(NSMutableArray*) getCells;
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
-(void)realLoading;

// Actions
-(void) resetBrana;
-(void) flipStoryForCell:(UIBranaCell*)cell;
@end
