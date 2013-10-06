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

@interface AddEventViewController ()

@end

@implementation AddEventViewController

@synthesize datePicker;
@synthesize gamePicker;
@synthesize eventList;
@synthesize selectedEvent;
@synthesize selectedDate;

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
    
    self.eventList = [User sharedInstance].eventArray;
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
    
    //generate a string for the date of the event
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm a";
    NSString *dateString = [dateFormatter stringFromDate: self.selectedDate];
    NSLog(@"the selected time is %@",dateString);
    

    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Tweet to create event"
                                                      message:@"This is your first UIAlertview message."
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
        NSLog(@"OK was selected.");
    }
}


@end
