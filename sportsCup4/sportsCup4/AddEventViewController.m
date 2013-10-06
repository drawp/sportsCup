//
//  AddEventViewController.m
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import "AddEventViewController.h"
#import "User.h"
#import "Event.h"
#import "TwitterController.h"
#import "EventListController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

@synthesize datePicker;
@synthesize gamePicker;
@synthesize eventList;
@synthesize selectedEvent;
@synthesize selectedDate;
@synthesize tweetString;

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
    
    self.eventList = [[[EventListController alloc] init] getEvents];
    self.title = @"Add Event";
    
    [self.datePicker addTarget:self
                          action:@selector(selectDate)
                forControlEvents:UIControlEventValueChanged];
    
	// Do any additional setup after loading the view.
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
    return [eventList count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Event* eventForRow = [eventList objectAtIndex:row];
    return eventForRow.name;//Or, your suitable title; like Choice-a, etc.
}


#pragma mark - event picker delegate methods
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedEvent = [eventList objectAtIndex:row];
    
    if (self.selectedEvent.date) {
        datePicker.date = self.selectedEvent.date;
    }
    
}


#pragma mark - date picker delegate methods
-(void)selectDate {
    
    self.selectedDate = datePicker.date;
}


#pragma mark - alert view methods to add an event

- (IBAction)tweet:(id)sender {
    
    self.tweetString = [self buildTweet];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Tweet to create event"
                                                      message:self.tweetString
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"OK",nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Cancel"])
    {
        //replace with code to tweet the message
        NSLog(@"Cancel was selected.");
    }
    else if([title isEqualToString:@"OK"])
    {
        [[[TwitterController alloc] init] tweet:[User sharedInstance] withArg2:self.tweetString];
        NSLog(@"OK was selected.");
    }
}

-(NSString*)buildTweet{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.self.selectedDate];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSLog(@"day=%i, month=%i, year=%i",day,month, year);
    
    //generate a day string
    NSString* dayStr = [NSString stringWithFormat:@"%i",day];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:day];
    NSString* dayString = [dayStr stringByAppendingString:suffix];
    NSLog(@"the day is %@",dayString);
    
    //generate a month string
    NSArray* months = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    NSString* monthString = [months objectAtIndex:(month-1)];
    NSLog(@"the month string is =%@", monthString);
    
    //generate a time string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"HH:mm a";
    NSString *timeString = [dateFormatter stringFromDate: self.selectedDate];
    NSLog(@"the time string is %@", timeString);
    
    //get the week day
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    NSString* weekDay = [weekday stringFromDate:self.selectedDate];
    NSLog(@"The day of the week is: %@", weekDay);

    //put everythign together
    NSString* tweet = [NSString stringWithFormat:@"Showing %@ %@, %@, %@ %@ #sportspot %@", self.selectedEvent.name, timeString, weekDay, monthString, dayString, self.selectedEvent.hashtag];
    NSLog(@"%@",tweet);
    
    return tweet;
}

@end
