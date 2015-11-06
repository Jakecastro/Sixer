//
//  Week.h
//  Sixer
//
//  Created by Jake Castro on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface Week : PFObject

@property PFRelation *activity;
@property PFRelation *user;
@property NSNumber *score;
@property bool isActive;

+ (NSString *)parseClassName;

@end
