//
//  TimerViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "StopwatchController.h"
#import "Exercise.h"
#import "User.h"
#import "Group.h"
#import "Activity.h"
#import "Color.h"
#import "Week.h"

@interface StopwatchController ()

@property (weak, nonatomic) IBOutlet UIButton *exerciseImageButton;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation StopwatchController

bool isExerciseTime;
int totalSessionTime;
int timeTick;
NSTimer *timer;
Group *solo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIForCountUpActive];
    NSLog(@"%ld", (long)self.groupActivity);

    

    timeTick =0;
    totalSessionTime=0;
    isExerciseTime = true;
    [self startTimer];
    self.exerciseNameLabel.text = [NSString stringWithFormat:@"%@", self.selectedExercise.name];


//    PFFile *imageFile = self.selectedExercise.image;
//    NSData *imageData = imageFile;
//    self.imageView.image = [UIImage imageWithData:imageData];
}

#pragma mark - Setup IU Methods
- (void)setUIForCountUpActive {
    self.view.backgroundColor = [Color flatTurquoiseColor];
    self.timeCountLabel.textColor = [Color flatPumpkinColor];
    self.imageView.backgroundColor = [Color flatTurquoiseColor];
    self.timeCountLabel.backgroundColor = [Color flatNephritisColor];
    self.totalScoreNameLabel.backgroundColor = [Color flatNephritisColor];
    self.totalScoreNameLabel.textColor = [Color flatCloudsColor];
    self.totalTimeScoreLabel.backgroundColor = [Color flatNephritisColor];
    self.totalTimeScoreLabel.textColor = [Color flatCloudsColor];
}

- (void)setUIForCountUpRest {
    self.view.backgroundColor = [Color flatPeterRiverColor];
    self.timeCountLabel.textColor = [Color flatMidnightBlue];
    self.imageView.backgroundColor = [Color flatPeterRiverColor];
    self.timeCountLabel.backgroundColor = [Color flatBelizeHoleColor];

    self.totalTimeScoreLabel.backgroundColor = [Color flatBelizeHoleColor];
    self.totalScoreNameLabel.backgroundColor = [Color flatBelizeHoleColor];
    self.totalTimeScoreLabel.textColor = [Color flatCloudsColor];
    self.totalScoreNameLabel.textColor = [Color flatCloudsColor];

    if ([self.totalTimeScoreLabel.text isEqualToString:@"0"]) {
        self.totalTimeScoreLabel.hidden = true;
        self.totalScoreNameLabel.hidden = true;
    }
    else {
        self.totalTimeScoreLabel.hidden = false;
        self.totalScoreNameLabel.hidden = false;
    }
}

#pragma mark - Timer Methods
- (void)startTimer {
//TODO: "Ready, Set, Begin!"
    [timer invalidate];
    self.timeCountLabel.text = @"0";

    if (isExerciseTime == true) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
    else if (isExerciseTime == false) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
}

- (void)tick {
    timeTick++;
    NSString *time = [[NSString alloc] initWithFormat:@"%d", timeTick];
    self.timeCountLabel.text = time;
}

#pragma mark - onButtonTapped Methods
- (IBAction)onExerciseImageTapped:(UIButton *)sender {
    [timer invalidate];
    isExerciseTime = ! isExerciseTime;
    timeTick = 0;

    if (isExerciseTime == true) {
        [self setUIForCountUpActive];
    }
    else if (isExerciseTime == false) {

        //converts the number from the countdown label to an int and adds it to the total session time
        int i = [self.timeCountLabel.text intValue];
        totalSessionTime += i;

        self.timeCountLabel.text = [NSString stringWithFormat:@"0"];
        self.totalTimeScoreLabel.text = [NSString stringWithFormat:@"%d",totalSessionTime];

        [self setUIForCountUpRest];
    }
    [self startTimer];
}

- (IBAction)onFinishButtonTapped:(id)sender {
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    PFUser *user = [PFUser currentUser];
    Activity *activity = [Activity objectWithClassName:@"Activity"];
    NSNumber *withGroup = [NSNumber numberWithBool:self.groupActivity];

    activity[@"score"] = [NSNumber numberWithInt:(int)totalSessionTime];
    activity[@"isActive"] = @YES;
    activity[@"user"] = user;
    activity[@"exercise"] = self.selectedExercise;
    activity[@"group"] = self.groupName;

    if ([withGroup boolValue] == true) {
        activity[@"isGroup"] = @YES;
    }
    else if ([withGroup boolValue] == false) {
        activity[@"isGroup"] = @NO;
    }

    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error did not save to Parse %@",error);
        }
    }];


}

@end
