//
//  DevelopersController.h
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Story.h"
#import "Developer.h"
#import "UIBranaController.h"
//#import "DeveloperView.h"

@class DeveloperView;

@interface DevelopersController : UIViewController {
	NSMutableArray *developers;
	NSMutableArray *stories;
	UIBranaController *branaController;
	UIView *mainView;
	NSMutableArray *devViews;
	Developer *selectedDeveloper;
}

- (id) initWithStories:(NSMutableArray*)someStories view:(UIView*)aView andController:(UIBranaController*)aController;
- (Developer*) developerForId:(NSString*)anIdentifier;

// actions
- (void) clickedOnDeveloper:(Developer*)aDeveloper;
- (void) clearDeveloper:(Developer*)aDeveloper;

@end
