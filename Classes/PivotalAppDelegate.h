//
//  PivotalAppDelegate.h
//  Pivotal
//
//  Created by Antonio on 07/02/09.
//  Copyright Unkasoft 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;


@interface PivotalAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainController *mainController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainController *mainController;

@end

