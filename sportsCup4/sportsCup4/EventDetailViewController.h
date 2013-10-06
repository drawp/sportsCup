//
//  EventDetailViewController.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventDetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) Event* event;
@property (nonatomic, retain) IBOutlet UILabel* name;
@property (nonatomic, retain) IBOutlet UILabel* date;
@property (nonatomic, retain) IBOutlet UILabel* hour;
@property (nonatomic, retain) IBOutlet UILabel* origTweet;
@property (nonatomic, retain) IBOutlet UILabel* RSVPs;

@end
