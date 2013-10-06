//
//  EventsTableViewController.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventDetailViewController;

@interface EventsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    
    NSMutableArray *eventsArray;
    EventDetailViewController* eventDetailController;
    
}

@property (nonatomic,retain) NSMutableArray *eventsArray;
@property (nonatomic,retain) EventDetailViewController* eventDetailController;
- (IBAction)addEvent:(id)sender;

@end
