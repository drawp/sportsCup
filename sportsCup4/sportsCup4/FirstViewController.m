//
//  FirstViewController.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "FirstViewController.h"
#import "SCSimpleSLRequestDemo.h"
#import "User.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize name;
@synthesize img;
@synthesize twitterHandle;
@synthesize address;


- (void)viewDidLoad
{

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
    
    self.name.text = [User sharedInstance].userName;
    self.twitterHandle.text =[User sharedInstance].userAddress;
    self.twitterHandle.text =[User sharedInstance].twitterHandle;
    
    if ([User sharedInstance].image) {
        self.img = [[UIImageView alloc] initWithImage:[User sharedInstance].image];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
