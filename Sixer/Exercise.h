//
//  Exercise.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <Parse/Parse.h>


@interface Exercise : PFObject <PFSubclassing>

@property NSString *name;
@property PFFile *image;
@property NSNumber *isUserExercise;
@property (nonatomic, strong, readonly) NSDate *updatedAt;

+ (NSString *)parseClassName;

@end
