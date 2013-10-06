//
//  TwitterController.m
//  sportsCup4
//
//  Created by Ben Juhn on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "TwitterController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "User.h"
#import "Event.h"
#import "Constants.h"


@interface TwitterController()
@property (nonatomic) ACAccountStore *accountStore;
@end

@implementation TwitterController

- (id)init
{
    self = [super init];
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)setTwitterUserInfo:(User *)user
{
    //  Step 0: Check that the user has local Twitter accounts
    if ([self userHasAccessToTwitter]) {
        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *twitterAccountType = [self.accountStore
                                             accountTypeWithAccountTypeIdentifier:
                                             ACAccountTypeIdentifierTwitter];
        [self.accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 //  Step 2:  Create a request
                 NSArray *twitterAccounts =
                 [self.accountStore accountsWithAccountType:twitterAccountType];
                 ACAccount *account = [twitterAccounts lastObject];
                 
                 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                               @"/1.1/users/show.json"];
                 NSDictionary *params = @{@"screen_name" : [account username],
                                          @"include_rts" : @"0",
                                          @"trim_user" : @"1",
                                          @"count" : @"1"};
                 SLRequest *request =
                 [SLRequest requestForServiceType:SLServiceTypeTwitter
                                    requestMethod:SLRequestMethodGET
                                              URL:url
                                       parameters:params];
                 
                 //  Attach an account to the request
                 [request setAccount:[twitterAccounts lastObject]];
                 
                 //  Step 3:  Execute the request
                 [request performRequestWithHandler:^(NSData *responseData,
                                                      NSHTTPURLResponse *urlResponse,
                                                      NSError *error) {
                     if (responseData) {
                         if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                             NSError *jsonError;
                             NSDictionary *userinfo =
                             [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingAllowFragments error:&jsonError];

                             [user setTwitterHandle:([account username])];
                             [user setUserName:([userinfo objectForKey: @"name"])];
                             [user setUserAddress:([userinfo objectForKey: @"location"])];
                             [user setImage:([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[userinfo objectForKey: @"profile_image_url"]]]])];
                             [[NSNotificationCenter defaultCenter] postNotificationName:kUserDataRetrieved object:nil];
                         }
                         else {
                             // The server did not respond successfully... were we rate-limited?
                             NSLog(@"The response status code is %d", urlResponse.statusCode);
                         }
                     }
                 }];
             }
         }];
    }
}

- (void)setTwitterEvents:(User *)user
{
    //  Step 0: Check that the user has local Twitter accounts
    if ([self userHasAccessToTwitter]) {
        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *twitterAccountType = [self.accountStore
                                             accountTypeWithAccountTypeIdentifier:
                                             ACAccountTypeIdentifierTwitter];
        [self.accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 //  Step 2:  Create a request
                 NSArray *twitterAccounts =
                 [self.accountStore accountsWithAccountType:twitterAccountType];
                 ACAccount *account = [twitterAccounts lastObject];
                 
                 NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                               @"/1.1/statuses/user_timeline.json"];
                 NSDictionary *params = @{@"screen_name" : [account username],
                                          @"include_rts" : @"0",
                                          @"trim_user" : @"1"};
                 SLRequest *request =
                 [SLRequest requestForServiceType:SLServiceTypeTwitter
                                    requestMethod:SLRequestMethodGET
                                              URL:url
                                       parameters:params];
                 
                 //  Attach an account to the request
                 [request setAccount:[twitterAccounts lastObject]];
                 
                 //  Step 3:  Execute the request
                 [request performRequestWithHandler:^(NSData *responseData,
                                                      NSHTTPURLResponse *urlResponse,
                                                      NSError *error) {
                     if (responseData) {
                         if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                             NSError *jsonError;
                             NSArray *tweets =
                             [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingAllowFragments error:&jsonError];
                             
                             for (NSDictionary *tweet in tweets) {
                                 NSString *tweetText = [tweet objectForKey:(@"text")];
                                 if ([tweetText rangeOfString:@"#sportspot"].location != NSNotFound && [tweetText hasPrefix:@"Showing"]) {
                                     // Create event and attach to user.

                                     NSString *title = [tweetText substringWithRange:NSMakeRange(8, [tweetText length] - 8)];
                                     NSCalendar *calendar = [NSCalendar currentCalendar];
                                     NSDateComponents* comp1 = [[NSDateComponents alloc] init];
                                     [comp1 setDay:5];
                                     [comp1 setMonth:4];
                                     [comp1 setYear:2013];
                                     NSDate* date1 = [calendar dateFromComponents:comp1];
                                     
                                     //choose two random events
                                     Event* event = [[Event alloc]initWithName:title date:date1 hour:[NSNumber numberWithInt:9] andOriginalTweet:tweetText];
                                     
                                     //add the events to the user
                                     [user addEvent:event];
                                     NSLog(@"event: %@", event);
                                 }
                             }
                             
                             NSLog(@"tweets: %@", tweets);
                             
                         }
                         else {
                             // The server did not respond successfully... were we rate-limited?
                             NSLog(@"The response status code is %d", urlResponse.statusCode);
                         }
                     }
                 }];
             }
         }];
    }
}


@end
