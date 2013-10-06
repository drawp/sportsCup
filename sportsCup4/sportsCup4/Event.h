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
@property (nonatomic, retain) NSNumber* hour;
@property (nonatomic, retain) NSString* originalTweet;
@property (nonatomic, retain) NSNumber* RSVPs;
@property (nonatomic, retain) NSString* hashtag;
@property (nonatomic, retain) NSMutableArray* userList;

-(Event*) initWithName:(NSString*)eName date:(NSDate*)eDate hour:(NSNumber*)eHour andOriginalTweet:(NSString*)eTweet;
-(Event*) initWithName:(NSString*)eName date:(NSDate*)eDate hour:(NSNumber*)eHour originalTweet:(NSString*)eTweet andHashTag:(NSString*)tag;

@end
