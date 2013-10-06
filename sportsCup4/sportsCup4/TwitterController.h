//
//  TwitterController.h
//  sportsCup4
//
//  Created by Ben Juhn on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface TwitterController : NSObject
- (void)setTwitterUserInfo:(User *)user;
- (void)setTwitterEvents:(User *)user;
@end
