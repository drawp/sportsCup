//
//  User.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize eventArray;
@synthesize userName;
@synthesize twitterHandle;
@synthesize  userAddress;

-(id) initWithName:(NSString*)name twitterHandle:(NSString*)handle andAddress:(NSString*)address{
    if (self = [super init]) {
        self.eventArray = nil;
        self.userName = name;
        self.twitterHandle=handle;
        self.userAddress = address;
    }
    
    return self;
}

@end
