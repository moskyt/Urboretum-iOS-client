//
//  TownAnnotation.h
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Town;

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TownAnnotation : NSObject <MKAnnotation>

@property(retain) Town* town;

- (id) initWithTown: (Town*)town;

@end
