//
//  Group.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "Group.h"

@implementation Group

@dynamic groupName;
@dynamic members;

+ (NSString *)parseClassName{
    return @"Group";
}

- (instancetype)initWithGroupName:(NSString *)name {
    self = [super init];
    if (self) {
        self.groupName = name;
    }
    return self;
}

+ (void)load {
    [self registerSubclass];
}

@end
