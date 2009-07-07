//
//  MainController.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright 2009 Unkasoft. All rights reserved.
//

#import "MainController.h"


@implementation MainController

@synthesize theBranaController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

// Story events
-(void)changeSelectedStory:(Story*)story {
	[currentStoryLabel setText:[story name]];
}

-(void)flipView:(Story*)story {	
	NSLog(@"Main controller flip view");
	[flippedView setStory:story];
	[container scheduleFlipBack];
	[container setNeedsDisplay];
	[flippedView setNeedsDisplay];
	[container flippingViews];
}

-(void)backToTopTouched:(id)button {
	NSLog(@"BACK TO TOP");
	[container scheduleFlipFront];
	[container setNeedsDisplay];
	[container flippingViews];
}

- (void)dealloc {
	[theBranaController dealloc];
    [super dealloc];
}

@dynamic currentStoryLabel;
@dynamic toolbar;
@synthesize flippedView;
@synthesize container;
@dynamic intro;

@end
