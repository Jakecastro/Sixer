//
//  TimerViewController.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "Group.h"

@interface StopwatchController : UIViewController
@property Exercise *selectedExercise;
@property NSInteger groupActivity;
@property Group *groupName;

@end
