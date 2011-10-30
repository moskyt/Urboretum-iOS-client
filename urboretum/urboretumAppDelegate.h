//
//  urboretumAppDelegate.h
//  urboretum
//
//  Created by František Havlůj on 29.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface urboretumAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (retain) NSDictionary* towns;
@property (retain) NSDictionary* townMap;
@property (retain) NSArray* depts;

-(User*) currentUser;

@end
