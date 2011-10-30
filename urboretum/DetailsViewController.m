//
//  DetailsViewController.m
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"

@implementation DetailsViewController

@synthesize navBar;
@synthesize navTitle;
@synthesize town;
@synthesize tableView;

const int 
    tbl_sec_basic = 0,
    tbl_sec_visits = 1,

    tbl_row_title = 0,
    tbl_row_dept = 1,
    tbl_row_coords = 2,
    tbl_row_wiki = 3;

- (urboretumAppDelegate*)app {
    return (urboretumAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == tbl_sec_basic) {
        return 4;
    } else if (section == tbl_sec_visits) {
        if ([self.app currentUser])
            return 2;
        else
            return 0;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == tbl_sec_basic) {
        return @"Základní údaje";
    } else if (section == tbl_sec_visits) {
        if ([self.app currentUser])
            return @"Návštěvy";
        else
            return @"Pro záznam a zobrazení přehledu návštěv je potřeba se přihlásit.";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == tbl_sec_basic) {
        if (indexPath.row == tbl_row_title) {
            cell.textLabel.text = [@"Jméno: " stringByAppendingString:town.title];
        } else if (indexPath.row == tbl_row_dept) {
            cell.textLabel.text = [@"Okres: " stringByAppendingString:town.department];
        } else if (indexPath.row == tbl_row_coords) {
            cell.textLabel.text = [NSString stringWithFormat:@"Poloha: %.3f s.š., %.3f v.d.",town.longitude, town.latitude];
        } else if (indexPath.row == tbl_row_wiki) {
            cell.textLabel.text = @"Wikipedie";
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    } else if (indexPath.section == tbl_sec_visits) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"..zatím";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"nevím...";
        } 
    }
    
        
    return cell;
}

- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == tbl_sec_basic) && (indexPath.row == tbl_row_wiki)) {
        NSURL *url = [NSURL URLWithString:town.href];        
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSString* msg = [@"Nepodařilo se otevřít stránku " stringByAppendingString:town.href];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Link" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show], [alert release];
        }
    }
}

@end
