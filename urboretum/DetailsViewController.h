//
//  DetailsViewController.h
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Town.h"
#import "urboretumAppDelegate.h"

@interface DetailsViewController : UIViewController;

@property(retain) IBOutlet UITableView* tableView;
@property(retain) IBOutlet UINavigationBar* navBar;
@property(retain) IBOutlet UINavigationItem* navTitle;
@property(retain) Town* town;

- (urboretumAppDelegate *)app;

@end
