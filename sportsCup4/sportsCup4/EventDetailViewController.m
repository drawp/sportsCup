//
//  EventDetailViewController.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

@synthesize event;
@synthesize name;
@synthesize date;
@synthesize hour;
@synthesize origTweet;
@synthesize RSVPs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.name.text = self.event.name;
    //self.date.text = self.event.date;
    //self.hour.text = self.event.hour;
    self.origTweet.text = self.event.originalTweet;
    self.RSVPs.text = [self.event.RSVPs stringValue];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grid_light_grey.jpg"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event picker data source methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [event.userList count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString* userForRow = [event.userList objectAtIndex:row];
    return userForRow;//Or, your suitable title; like Choice-a, etc.
}


#pragma mark - event picker delegate methods
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"the selected user is %@", [event.userList objectAtIndex:row]);
    
}


@end
