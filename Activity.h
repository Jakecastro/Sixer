//
//  Activity.h
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface Activity : PFObject <PFSubclassing>

@property NSString *name;
@property NSNumber *isGroup;

+ (NSString *)parseClassName;

@end
