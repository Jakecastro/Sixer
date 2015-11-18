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
    [self.layer setCornerRadius:30.0f];
    self.nameLabel.textColor = [Color whiteColor];
    self.nameLabel.backgroundColor = [Color flatSilverColor];
    self.backgroundColor = [Color flatCloudsColor];
    
    self.imageView.backgroundColor = [Color flatCloudsColor];
}

@end
