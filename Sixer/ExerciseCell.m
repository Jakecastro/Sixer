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
    [self.layer setCornerRadius:10.0f];
    self.backgroundColor = [Color whiteColor];
    self.exerciseImage.backgroundColor = [Color flatCloudsColor];
    self.exerciseLabel.backgroundColor = [Color flatSilverColor];
    self.exerciseLabel.textColor = [Color whiteColor];
}

@end
