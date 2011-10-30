//
//  TownAnnotation.m
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TownAnnotation.h"
#import "Town.h"

@implementation TownAnnotation

@synthesize town;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWithTown: (Town*)town_ {
    self.town = town_;
    return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = town.latitude;
	theCoordinate.longitude = town.longitude;
	return theCoordinate; 
}

- (NSString *)title {
    return town.title;
}

- (NSString *)subtitle {
    return [@"okres: " stringByAppendingString:town.department];
}


@end
