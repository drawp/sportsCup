//
//  Event.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize name;
@synthesize date;
@synthesize hour;
@synthesize originalTweet;
@synthesize RSVPs;

-(Event*) initWithName:(NSString*)eName date:(NSDate*)eDate hour:(NSNumber*)eHour andOriginalTweet:(NSString*)eTweet {
    
    if ( self = [super init] ) {
        self.name = eName;
        self.date = eDate;
        self.hour = eHour;
        self.originalTweet = eTweet;
        self.RSVPs = nil;
    }
    return self;
}



@end
