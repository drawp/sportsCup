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

static User* _user = nil;

+(User*) sharedInstance {
	@synchronized([User class])
	{
		if (!_user)
			_user= [[self alloc] init];
		return _user;
	}
	return nil;
}

+(id) alloc {
    @synchronized ([User class])
    {
        NSAssert(_user == nil,
				 @"Attempted to allocate a second instance of the user singleton");
		_user = [super alloc];
		return _user;
    }
    return nil;
}

-(id) init {
    if(self = [super init])
    {
        self.eventArray = nil;
    }
    return self;
}


-(void) setName:(NSString*)name twitterHandle:(NSString*)handle andAddress:(NSString*)address{

    self.userName = name;
    self.twitterHandle=handle;
    self.userAddress = address;
}

@end
