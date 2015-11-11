//
//  Activity.h
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>
#import "Exercise.h"

@interface Activity : PFObject <PFSubclassing>

@property Exercise *exercise;
@property NSNumber *score;
@property NSNumber *isGroupActivity;

+ (NSString *)parseClassName;

@end
