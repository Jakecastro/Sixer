//
//  TimerUpController.m
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "TimerController.h"

@interface TimerController ()

@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImageView;
@property (weak, nonatomic) IBOutlet UILabel *countTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *editCountDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *editSetslLabel;
@property (weak, nonatomic) IBOutlet UILabel *editRestLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@end

@implementation TimerController



- (IBAction)onTimerButtonTapped:(UIButton *)sender {
}

@end
