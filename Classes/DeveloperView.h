//
//  DeveloperView.h
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Developer.h"
#import "DevelopersController.h"

@interface DeveloperView : UIView {
	Developer *developer;
	DevelopersController *developerController;
	UILabel *txtView;
	UIView *container;
}

- (id) initWithFrame:(CGRect)frame developer:(Developer*)aDeveloper andController:(DevelopersController*)controller;

@end
