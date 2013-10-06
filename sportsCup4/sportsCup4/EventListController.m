//
//  EventListController.m
//  sportsCup4
//
//  Created by Ben Juhn on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "EventListController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "User.h"
#import "Event.h"
#import "Constants.h"

@interface EventListController()

@end

@implementation EventListController

- (id)init
{
    self = [super init];
    return self;
}

- (NSArray *)getEvents
{
 
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"year\":2013, \"week\":7}"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://busrac.es/sportspot/tweets"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *jsonParsingError = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *games = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    NSLog(@"GAMES: %@",games);
    
    for (NSDictionary *game in games) {
        NSString *dateString = @"";

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents* comp1 = [[NSDateComponents alloc] init];
        [comp1 setDay:5];
        [comp1 setMonth:4];
        [comp1 setYear:2013];
        [comp1 setHour:16];
        NSDate* date1 = [calendar dateFromComponents:comp1];

        Event* event = [[Event alloc]initWithName:dateString date:date1 hour:[NSNumber numberWithInt:9] andOriginalTweet:@""];

        [events addObject:(event)];
    }

    return events;
}


@end
