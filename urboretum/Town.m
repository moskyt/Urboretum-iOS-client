//
//  Town.m
//  urboretum
//
//  Created by František Havlůj on 30.10.//11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Town.h"

@implementation Town

@synthesize name;
@synthesize department;
@synthesize latitude;
@synthesize longitude;
@synthesize href;

- (NSString*) title
{
    NSRange textRange;
    textRange =[self.name rangeOfString:@"("];
    
    if(textRange.location != NSNotFound)
    {
        return [self.name substringWithRange:NSMakeRange(0, textRange.location)];
    } else {
        return self.name;        
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithDictionary: (NSDictionary*)dict
{
    self = [self init];
    if (self) {
        self.name = [dict valueForKey:@"Name"];
        self.href = [dict valueForKey:@"Wikiref"];
        self.department = [dict valueForKey:@"Department"];
        self.latitude = [[dict valueForKey:@"Latitude"] floatValue];
        self.longitude = [[dict valueForKey:@"Longitude"] floatValue];
    }
    
    return self;
}

@end
