//
//  Town.h
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Town : NSObject;

@property(retain) NSString* name;
@property(retain) NSString* href;
@property(retain) NSString* department;
@property Float64 latitude;
@property Float64 longitude;

- (id)initWithDictionary: (NSDictionary*)dict;
- (NSString*)title;

@end
