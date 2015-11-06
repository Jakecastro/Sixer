//
//  Group.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>

@interface Group : PFObject

@property NSString *groupName;
@property PFRelation *members;


+ (NSString *)parseClassName;

@end
