//
//  ListViewController.m
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"
#import "ListViewController.h"
#import "Town.h"

@implementation ListViewController

@synthesize tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
//    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (urboretumAppDelegate*)app {
    return (urboretumAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (NSDictionary *)towns {
    return [self.app towns];
}

- (NSDictionary *)townMap {
    return [self.app townMap];
}

- (NSArray *)depts {
    return [self.app depts];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.depts count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* town_list = [self.townMap objectForKey:[self.depts objectAtIndex:section]];
    return [town_list count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.depts objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        
    NSString* dept_name = [self.depts objectAtIndex:indexPath.section];
    NSArray* town_list = [self.townMap objectForKey:dept_name];
    NSString* town = [town_list objectAtIndex:indexPath.row];
    
    cell.textLabel.text = ((Town*)[self.towns objectForKey:town]).title;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;


    return cell;
}


- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    NSString* dept_name = [self.depts objectAtIndex:indexPath.section];
    NSArray* town_list = [self.townMap objectForKey:dept_name];
    Town* town = [self.towns objectForKey:[town_list objectAtIndex:indexPath.row]];

    UITabBarController *tab = [(urboretumAppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController];
    
    DetailsViewController *d = [[DetailsViewController alloc] 
                                        initWithNibName:@"DetailsView" 
                                        bundle:[NSBundle mainBundle]];
    [tab setSelectedViewController:d];
    [d release];
    
    DetailsViewController* view = (DetailsViewController*)tab.selectedViewController;
    
    view.navBar.topItem.title = town.title;
    view.town = town;
    
    UIBarButtonItem *_backButton = [[UIBarButtonItem alloc] initWithTitle:@"Zpět na seznam" style:UIBarButtonItemStyleDone target:nil action:nil];
    view.navTitle.backBarButtonItem = _backButton;
    [_backButton release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
