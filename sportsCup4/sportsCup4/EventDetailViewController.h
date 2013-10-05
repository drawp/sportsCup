//
//  EventDetailViewController.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventDetailViewController : UIViewController

@property (nonatomic, retain) Event* event;
@property (nonatomic, retain) IBOutlet NSString* name;
@property (nonatomic, retain) IBOutlet NSDate* date;
@property (nonatomic, retain) IBOutlet NSNumber* hour;
@property (nonatomic, retain) IBOutlet NSString* origTweet;
@property (nonatomic, retain) IBOutlet NSNumber* RSVPs;

@end
