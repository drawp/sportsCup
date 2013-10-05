//
//  Event.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSInteger* hour;
@property (nonatomic, retain) NSString* originalTweet;
@property (nonatomic, retain) NSNumber* RSVPs;

-(Event*) initWithName:(NSString*)eName date:(NSDate*)eDate hour:(NSInteger*)eHour andOriginalTweet:(NSString*)eTweet;

@end
