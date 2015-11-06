//
//  User.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser

@property PFFile *profileImage;
@property PFRelation *totalScore;
@property PFRelation *activities;

+ (NSString *)parseClassName;

@end
