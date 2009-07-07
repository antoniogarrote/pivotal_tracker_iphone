//
//  PivotalAppDelegate.m
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright Unkasoft 2009. All rights reserved.
//

#import "PivotalAppDelegate.h"

@implementation PivotalAppDelegate

@synthesize window;
@synthesize mainController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
