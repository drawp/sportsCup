//
//  FirstViewController.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "FirstViewController.h"
#import "SCSimpleSLRequestDemo.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    NSLog(@"testing");
    SCSimpleSLRequestDemo *test = [[SCSimpleSLRequestDemo alloc] init];
    [test fetchTimelineForUser:(@"ID_AA_Carmack")];
    NSLog(@"testing2");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
