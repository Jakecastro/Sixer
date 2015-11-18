//
//  Exercise.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Exercise.h"

@implementation Exercise

@dynamic name;
@dynamic image;
@dynamic updatedAt;
@synthesize isUserExercise = _isUserExercise;

+ (NSString *)parseClassName{
    return @"Exercise";
}

-(void)setIsUserExercise:(NSNumber *)isUserExercise {
    _isUserExercise = isUserExercise;
}

-(NSNumber *)isUserExercise {
    return _isUserExercise;
}

+ (void)load {
    [self registerSubclass];
}


@end
