//
//  User.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "User.h"
#import "Event.h"
#import "TwitterController.h"

@implementation User

@synthesize eventArray;
@synthesize userName;
@synthesize twitterHandle;
@synthesize  userAddress;
@synthesize image;

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


-(void) setName:(NSString*)name twitterHandle:(NSString*)handle address:(NSString*)address andImage:(UIImage *)img{

    self.userName = name;
    self.twitterHandle=handle;
    self.userAddress = address;
    self.image = img;
}

-(void)addEvent:(Event *)event {
    [self.eventArray addObject:event];
}


-(void) reloadData {
    // THE FOLLOWING SETUP CALLS ARE DUMMIES THAT MUST BE REPLACED
    
    //setup the user - REPLACE
//    [self setName:@"Black magic" twitterHandle:@"@BlackMagic" address:@"1400 Lombard" andImage:[[UIImage alloc]init]];
    
    TwitterController *twitterController = [[TwitterController alloc] init];
    [twitterController setTwitterUserInfo:(self)];
    NSLog(@"%@", self);
    
    //choose a random date for all events - CREATE DATE INFO
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* comp1 = [[NSDateComponents alloc] init];
    [comp1 setDay:5];
    [comp1 setMonth:4];
    [comp1 setYear:2013];
    NSDate* date1 = [calendar dateFromComponents:comp1];
    
    //choose two random events
    Event* event1 = [Event initWithName:@"event1" date:date1 hour:[NSNumber numberWithInt:9] andOriginalTweet:@"come join us!"];
    
    Event* event2 = [Event initWithName:@"event2" date:date1 hour:[NSNumber numberWithInt:9] andOriginalTweet:@"come join us also!"];

    //add the events to the user
    [self addEvent:event1];
    [self addEvent:event2];
    
}

@end
