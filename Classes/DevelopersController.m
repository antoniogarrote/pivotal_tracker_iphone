//
//  DevelopersController.m
//  Pivotal
//
//  Created by Antonio on 16/04/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "DevelopersController.h"
#import "DeveloperView.h"


@implementation DevelopersController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (id) initWithStories:(NSMutableArray*)someStories view:(UIView*)aView andController:(UIBranaController*)aController {
	if (self = [super init]) {
		stories = someStories;
		mainView = aView;
		branaController = aController;
		developers = [[NSMutableArray alloc] init];
		devViews = [[NSMutableArray alloc] init];
		selectedDeveloper = nil;
		
		for (Story* story in stories) {
			Developer* dev = [self developerForId:[story ownedBy]]; 
			if(dev == nil) {
				dev = [[Developer alloc] initWithIdentifier:[story ownedBy]];
				[developers addObject:dev];
			}			
			[dev addStory:story];			
		}
		
		CGRect mainRect = [[mainView superview] frame];
		CGFloat topX = mainRect.size.width - 20;
		CGFloat topY = 25;
		CGFloat downY = mainRect.size.height + mainRect.origin.y;		
		CGFloat totalHeight = downY - topY;
		
		for(Developer *dev in developers) {
			CGRect triang;
			triang.origin.x = topX;
			
			CGFloat percent = [dev completedPercentage];
			triang.origin.y = topY + (totalHeight * percent /100);
			triang.size.width = 20;
			triang.size.height = 20;
			
			DeveloperView *view = [[DeveloperView alloc] initWithFrame:triang
															 developer:dev 
														 andController:self];
			[[mainView superview] addSubview:view];
		}

	}
	return self;	
}

- (Developer*) developerForId:(NSString*)anIdentifier {
	for(Developer* dev in developers) {
		if([[dev identifier] isEqualToString:anIdentifier]) {
			return dev;
		}
	}
	return nil;
}

// actions
- (void) clickedOnDeveloper:(Developer*)aDeveloper {
	NSLog(@"selected developer");	
	if(selectedDeveloper != nil) {
		[branaController setDeveloper:selectedDeveloper showing:NO];
	}
	[branaController setDeveloper:aDeveloper showing:YES];
	selectedDeveloper = aDeveloper;
}

- (void) clearDeveloper:(Developer*)aDeveloper {
	NSLog(@"clearing developer");
	[branaController setDeveloper:aDeveloper showing:NO];
	if(selectedDeveloper == aDeveloper) {
		selectedDeveloper = nil;
	}
}

- (void)dealloc {
	for(Developer *dev in developers) {
		[dev release];
	}
	[developers release];
	
	for(DeveloperView *devView in devViews) {
		[devView release];
	}
	[devViews release];
    [super dealloc];
}


@end

