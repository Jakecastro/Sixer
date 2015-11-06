//
//  TimerViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "TimerViewController.h"
#import "Exercise.h"
#import "Week.h"

@interface TimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *exerciseImageButton;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;

@end

@implementation TimerViewController


bool isExerciseTime;
int totalSessionTime;
int timeTick;
NSTimer *timer;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    Week *scoreToAdd = [Week objectWithClassName:@"Week"];

    scoreToAdd[@"score"] = [NSNumber numberWithInt:(int)totalSessionTime];
    scoreToAdd[@"isActive"] = @YES;

    [scoreToAdd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"no dice %@",error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    timeTick =0;
    totalSessionTime=0;
    isExerciseTime = true;
    [self startTimer];
}

- (void)startTimer {
//TODO: "Ready, Set, Begin!"
    [timer invalidate];
    self.timeCountLabel.text = @"0";

    if (isExerciseTime == true) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
    else if (isExerciseTime == false) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
}

- (void)tick {
    timeTick++;
    NSString *time = [[NSString alloc] initWithFormat:@"%d", timeTick];
    self.timeCountLabel.text = time;
}


- (IBAction)onExerciseImageTapped:(UIButton *)sender {
    [timer invalidate];
    isExerciseTime = ! isExerciseTime;
    timeTick =0;

    if (isExerciseTime == true) {
        self.view.backgroundColor = [UIColor colorWithRed:123.0 / 255.0 green:183.0 / 255.0 blue:75.0 / 255.0 alpha:1.0];
        self.timeCountLabel.backgroundColor = [UIColor colorWithRed:83.0 / 255.0 green:124.0 / 255.0 blue:50.0 / 255.0 alpha:1.0];
        self.timeCountLabel.textColor = [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:122.0 / 255.0 alpha:1.0];
        [self.exerciseImageButton setTitle:@"" forState:UIControlStateNormal];
    }
    else if (isExerciseTime == false) {
        // converts the number from the countdown label to an int and adds it to the total session time
        int i = [self.timeCountLabel.text intValue];
        totalSessionTime += i;
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.timeCountLabel.backgroundColor = [UIColor darkGrayColor];
        self.timeCountLabel.textColor = [UIColor blackColor];
        [self.exerciseImageButton setTitle:[NSString stringWithFormat:@"%d",totalSessionTime] forState:UIControlStateNormal];
        [self.exerciseImageButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.exerciseImageButton.titleLabel.font = [UIFont systemFontOfSize:140];
    }
    NSLog(@"%ld", (long)totalSessionTime);
    [self startTimer];
}


- (IBAction)onFinishButtonTapped:(id)sender {


//    Week *scoreToAdd = [Week objectWithClassName:@"Week"];
//    scoreToAdd[@"score"] = [NSNumber numberWithInt:(int)totalSessionTime];
//    [scoreToAdd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"no dice %@",error);
//        }
//    }];
}



@end
