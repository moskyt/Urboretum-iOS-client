//
//  urboretumAppDelegate.m
//  urboretum
//
//  Created by František Havlůj on 29.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "urboretumAppDelegate.h"
#import "Town.h"

@implementation urboretumAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize towns;
@synthesize townMap;
@synthesize depts;

-(User*) currentUser
{
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // load the town data
    NSBundle* bundle = [NSBundle mainBundle];
	NSString* plistPath = [bundle pathForResource:@"towns" ofType:@"plist"];
    
    // list of all towns as the individual records
	NSArray* townList = [[NSArray alloc] initWithContentsOfFile:plistPath];    
    // all towns as name->record dictionary
    NSMutableDictionary* townDict = [[NSMutableDictionary alloc] init];
    // town mapping as department->[towns]
    NSMutableDictionary* townMapp = [[NSMutableDictionary alloc] init];
    // list of departments
    NSMutableArray* deptList = [[NSMutableArray alloc] init];
    
    for (id object in townList) {
        // get next town
        Town* town = [[Town alloc] initWithDictionary:(NSDictionary*) object];
        [town retain];
        // look if the department is already on the list
        if (!([deptList containsObject:town.department])) {
            // otherwise, add it to the list
            [deptList addObject:town.department]; 
            // and stack up a new array into the map
            NSMutableArray* new_list = [[NSMutableArray alloc] init];
            [townMapp setObject:new_list forKey:town.department];
        }
        [[townMapp objectForKey:town.department] addObject:town.name];
        [townDict setObject:town forKey:town.name];
    }
    
    self.depts = [[NSArray alloc] initWithArray:[deptList sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    self.towns = [[NSDictionary alloc] initWithDictionary:townDict copyItems:NO];
    self.townMap = [[NSDictionary alloc] initWithDictionary:townMapp copyItems:YES];
    
    [deptList release];
    [townList release];
    [townMap release];
    [townDict release];

    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

@end
