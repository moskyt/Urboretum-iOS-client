//
//  ListViewController.h
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urboretumAppDelegate.h"

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(retain) IBOutlet UITableView* tableView;

- (urboretumAppDelegate *)app;
- (NSDictionary *)towns;
- (NSDictionary *)townMap;
- (NSArray *)depts;

@end
