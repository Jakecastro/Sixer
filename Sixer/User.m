//
//  User.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic profileImage;
@dynamic totalScore;
@dynamic activities;

+ (NSString *)parseClassName{
    return @"User";
}

@end
