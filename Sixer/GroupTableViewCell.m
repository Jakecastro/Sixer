//
//  GroupTableViewCell.m
//  Sixer
//
//  Created by Matt Burrill on 11/9/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "GroupTableViewCell.h"
#import "ExerciseViewController.h"
#import "GroupViewController.h"



@implementation GroupTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    [self bringSubviewToFront:self.onButtonPressSelectGroup];
//}
- (IBAction)buttonGrabGroup:(UIButton *)sender {

    [self.delegate groupTableViewCell:self didTapButton:sender withGroup:self.groupNameLabel.text];
    
}




@end
