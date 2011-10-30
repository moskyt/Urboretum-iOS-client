//
//  MapViewController.m
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Town.h"
#import "TownAnnotation.h"

@implementation MapViewController

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

- (NSDictionary *)towns {
    return [(urboretumAppDelegate *)[[UIApplication sharedApplication] delegate] towns];
}

- (NSDictionary *)townMap {
    return [(urboretumAppDelegate *)[[UIApplication sharedApplication] delegate] townMap];
}

- (NSArray *)depts {
    return [(urboretumAppDelegate *)[[UIApplication sharedApplication] delegate] depts];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    float minlat=99, maxlat=-99, minlon=99, maxlon=-99;
    
    // put the the on the the
    for( NSString *town_name in self.towns )
    {
        Town* town = [self.towns objectForKey:town_name];
        TownAnnotation *townAnnotation = [[[TownAnnotation alloc] initWithTown:town] autorelease];
		[mapView addAnnotation:townAnnotation ];
        if (town.longitude < minlon) minlon = town.longitude;
        if (town.longitude > maxlon) maxlon = town.longitude;
        if (town.latitude < minlat) minlat = town.latitude;
        if (town.latitude > maxlat) maxlat = town.latitude;
    }
    
	mapView.mapType = MKMapTypeStandard;
	mapView.zoomEnabled = YES;
	mapView.scrollEnabled = YES;
    
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	CLLocationCoordinate2D location;
	
    location.latitude = (maxlat+minlat)/2;
	location.longitude = (maxlon+minlon)/2;
	span.latitudeDelta = (maxlat-minlat)/2;
	span.longitudeDelta = (maxlon-minlon)/2;
	region.span = span;
	region.center = location;

	[mapView setRegion:region animated:FALSE];

    mapView.delegate = self;

    [super viewDidLoad];    
}


- (MKAnnotationView *) mapView: (MKMapView *) theMapView viewForAnnotation: (id<MKAnnotation>) annotation {
    // reuse a view, if one exists
    MKAnnotationView *aView = [theMapView dequeueReusableAnnotationViewWithIdentifier:@"TownAnnotationIdentifier"];
    
    // create a new view else
    if (!aView) {
        aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"TownAnnotationIdentifier"];
    }
    
    // now configure the view
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [(UIButton*)aView.rightCalloutAccessoryView addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    aView.canShowCallout = YES;
    aView.enabled = YES;
    aView.image = [UIImage imageNamed:@"pin.png"];
    aView.centerOffset = CGPointMake(6, 0);
    
    return aView;
}


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

@end
