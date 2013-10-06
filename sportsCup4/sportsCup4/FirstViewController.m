//
//  FirstViewController.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "FirstViewController.h"
#import "TwitterController.h"
#import "EventListController.h"
#import "User.h"
#import "Constants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize name;
@synthesize img;
@synthesize twitterHandle;
@synthesize address;


- (void)viewDidLoad
{
//    EventListController *test = [[EventListController alloc] init];
//    NSArray *events = [test getEvents];
//    User *myUser = [User sharedInstance];
//    TwitterController *test = [[TwitterController alloc] init];
//    [test tweet:myUser withArg2:@"test tweet"];
//    NSArray *events = [test tweet user:myUser status:@"test tweet"];
    
//    NSLog(@"testing");
//    SCSimpleSLRequestDemo *test = [[SCSimpleSLRequestDemo alloc] init];
//    [test setTwitterUserInfo];
//    [test fetchTimelineForUser:(@"starbucks")];
//    NSLog(@"testing2");
//    User *myUser = [User sharedInstance];
//    [myUser reloadData];
//    sleep(1);
//    NSLog(@"%@", [myUser userName]);
//    NSLog(@"%@", [myUser userAddress]);
//    NSLog(@"%@", [myUser image]);
//    NSLog(@"%@", [myUser twitterHandle]);

    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refresh)
                                                 name:kUserDataRetrieved
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grid_bright.jpg"]];
    
    

}

-(void) refresh {
    NSLog(@"here");
    User *user = [User sharedInstance];
    self.name.text = user.userName;
    self.twitterHandle.text =[@"@" stringByAppendingString:user.twitterHandle];
    self.address.text = user.userAddress;
    
    if (user.image) {
        [self.img setContentMode:UIViewContentModeScaleAspectFill];
        [self.img setImage:user.image];
    }
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    [self viewDidLoad];
    NSLog(@"here2");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
