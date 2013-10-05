//
//  User.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray* eventArray;
@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* twitterHandle;
@property (nonatomic, retain) NSString* userAddress;
@property (nonatomic, retain) UIImage* image;

+(User*) sharedInstance;
-(void) setName:(NSString*)name twitterHandle:(NSString*)handle address:(NSString*)address andImage:(UIImage*)img;
-(void)reloadData; //method to be written with use of twitter controller. controller can get data and use setName method to update this class
-(void) addEvent:(Event*)event;

@end
