//
//  MapViewController.h
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "urboretumAppDelegate.h"

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    IBOutlet MKMapView* mapView;
}

- (NSDictionary *)towns;
- (NSDictionary *)townMap;
- (NSArray *)depts;

@end
