//
//  User.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray* eventArray;
@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* twitterHandle;
@property (nonatomic, retain) NSString* userAddress;

-(id) initWithName:(NSString*)name twitterHandle:(NSString*)handle andAddress:(NSString*)address;

@end
