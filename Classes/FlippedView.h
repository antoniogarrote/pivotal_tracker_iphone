//
//  FlippedView.h
//  Pivotal
//
//  Created by Antonio on 17/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Story.h"

@class MainController;

@interface FlippedView : UIView {
	UIFont *font;
	UIFont *boldFont;
	UILabel *title;
	UILabel *points;
	UILabel *stateLabel;
	UILabel *descriptionLabel;
	UILabel *requestedLabel;
	UILabel *ownedLabel;
	UILabel *createdLabel;
	UILabel *acceptedLabel;
	
	UIButton *state;
	UITextView *description;
	UILabel *requested;
	UILabel *owned;
	UILabel *created;
	UILabel *accepted;
	
	UIButton *back;
	
	MainController *mainController;
	Story *story;
}

@property (retain,readwrite) IBOutlet UILabel *title;
@property (retain,readwrite) IBOutlet UILabel *points;
@property (retain,readwrite) IBOutlet UILabel *stateLabel;
@property (retain,readwrite) IBOutlet UILabel *descriptionLabel;
@property (retain,readwrite) IBOutlet UILabel *requestedLabel;
@property (retain,readwrite) IBOutlet UILabel *ownedLabel;
@property (retain,readwrite) IBOutlet UILabel *createdLabel;
@property (retain,readwrite) IBOutlet UILabel *acceptedLabel;

@property (retain,readwrite) IBOutlet UIButton *state;
@property (retain,readwrite) IBOutlet UITextView *description;
@property (retain,readwrite) IBOutlet UILabel *requested;
@property (retain,readwrite) IBOutlet UILabel *owned;
@property (retain,readwrite) IBOutlet UILabel *created;
@property (retain,readwrite) IBOutlet UILabel *accepted;

@property (retain,readwrite) IBOutlet UIButton *back;


@property (retain,readwrite) Story *story;

@end
