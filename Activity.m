//
//  Activity.m
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Activity.h"

@implementation Activity

@dynamic name;
@dynamic score;
@dynamic group;
@dynamic exercise;
@synthesize isGroup = _isGroup;

+ (NSString *)parseClassName {
    return @"Activity";
}

- (void)setIsGroup:(NSNumber *)isGroup {
    _isGroup = isGroup;
}

- (NSNumber *)isGroup {
    return _isGroup;
}

+ (void)load {
    [self registerSubclass];
}

@end
