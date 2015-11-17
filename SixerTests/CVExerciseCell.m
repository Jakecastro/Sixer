//
//  CVExerciseCell.m
//  Sixer
//
//  Created by Jake Castro on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "CVExerciseCell.h"

@implementation CVExerciseCell

- (void)awakeFromNib {
    [self.layer setBorderWidth:2.0f];
    [self.layer setCornerRadius:30.0f];
    [self.imageView.layer setCornerRadius:30.0f];
    self.nameLabel.textColor = [UIColor blackColor];
}

@end
