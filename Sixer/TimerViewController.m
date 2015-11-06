//
//  TimerViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;
@property BOOL isExerciseTime;

@end

@implementation TimerViewController

int timeTick = 0;
NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isExerciseTime = true;
    [self startExerciseTimer];
}

- (void)startExerciseTimer {
// "Ready, 3, 2, 1, Begin!"
    [timer invalidate];
    self.timeCountLabel.text = @"0";
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick {
    timeTick++;
    NSString *timeString = [[NSString alloc] initWithFormat:@"%d", timeTick];
    self.timeCountLabel.text = timeString;
}

- (void)startRestTimer {
    self.view.backgroundColor = [UIColor lightGrayColor];
    [timer invalidate];
    self.timeCountLabel.text = @"0";
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}


- (IBAction)onFinishButtonTapped:(UIBarButtonItem *)sender {
}



@end
