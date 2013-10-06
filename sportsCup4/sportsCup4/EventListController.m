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

- (NSMutableArray *)getEvents
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"year\":2013, \"week\":5}"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://busrac.es/sportspot/tweets/nfl"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *jsonParsingError = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *games = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    for (NSDictionary *game in games) {

        NSDictionary *gameInfo = [game objectForKey:(@"game_info")];
        NSString *name = [NSString stringWithFormat:@"%@ vs %@", [gameInfo objectForKey:(@"home_team")], [gameInfo objectForKey:(@"away_team")]];

        BOOL cont = NO;
        for (Event *eTmp in events) {
            if ([[eTmp name] isEqualToString:name]) {
                cont = YES;
            }
        }
        if(cont == YES) {
            continue;
        }
        
        NSString *hashTag = [gameInfo objectForKey:(@"hashtag")];

        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'+00:00'"];
        
        NSDate *date = [df dateFromString: [gameInfo objectForKey:(@"scheduled")]];
        Event* event = [[Event alloc]initWithName:name date:date hour:[NSNumber numberWithInt:9] originalTweet:@"" andHashTag:hashTag];
        
        [events addObject:(event)];
    }

    NSLog(@" these are the events: %@", events);
    return events;
}

- (NSMutableArray *)getAllEvents
{
        NSLog(@"begin");
    NSString *post = [NSString stringWithFormat:@"{\"year\":2013, \"week\":5}"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://busrac.es/sportspot/tweets/nfl"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *jsonParsingError = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"test1");
    NSMutableArray *games = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    NSLog(@"test2");
    return games;
}

@end
