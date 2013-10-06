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

        NSDictionary *gameInfo = [game objectForKey:(@"game_info")];
        NSString *name = [NSString stringWithFormat:@"%@ vs %@", [gameInfo objectForKey:(@"home_team")], [gameInfo objectForKey:(@"away_team")]];

        NSString *hashTag = [gameInfo objectForKey:(@"hashtag")];

        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate *date = [df dateFromString: [gameInfo objectForKey:(@"scheduled")]];
        
        Event* event = [[Event alloc]initWithName:name date:date hour:[NSNumber numberWithInt:9] originalTweet:@"" andHashTag:hashTag];
        
        [events addObject:(event)];
    }

    NSLog(@"%@", events);
    return events;
}


@end
