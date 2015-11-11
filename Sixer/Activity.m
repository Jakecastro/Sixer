//
//  Activity.m
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Activity.h"

@implementation Activity

@dynamic exercise;
@dynamic score;
@synthesize isGroupActivity = _isGroupActivity;

+ (NSString *)parseClassName {
    return @"Activity";
}

- (void)setIsGroupActivity:(NSNumber *)isGroupActivity {
    _isGroupActivity = isGroupActivity;
}

- (NSNumber *)isGroupActivity {
    return _isGroupActivity;
}

+ (void)load {
    [self registerSubclass];
}

@end
