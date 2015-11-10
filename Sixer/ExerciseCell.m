//
//  ExerciseCell.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ExerciseCell.h"
#import "Color.h"

@implementation ExerciseCell

- (void)awakeFromNib {
    [self.layer setBorderWidth:2.0f];
    [self.layer setCornerRadius:30.0f];
    [self.exerciseImage.layer setCornerRadius:30.f];
    self.backgroundColor = [UIColor whiteColor];
    self.exerciseLabel.textColor = [UIColor blackColor];
    self.exerciseImage.backgroundColor = [UIColor whiteColor];
    [self.layer setBorderColor:[Color hourNormalStateBorderColor].CGColor];
    [self.exerciseLabel.layer setBackgroundColor:[UIColor whiteColor].CGColor];
}

@end
