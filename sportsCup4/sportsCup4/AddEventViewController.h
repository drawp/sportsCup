//
//  AddEventViewController.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface AddEventViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
}

@property (nonatomic, retain) NSMutableArray* eventList;
@property (nonatomic, retain) Event* selectedEvent;
@property (nonatomic, retain) NSDate* selectedDate;
@property (nonatomic, retain) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView* gamePicker;

- (IBAction)tweet:(id)sender;

@end
