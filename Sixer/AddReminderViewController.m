//
//  AddReminderViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddReminderViewController.h"

@implementation AddReminderViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"reloadData" object:nil];

    self.enterExerciseTextField.delegate = self;
}

- (IBAction)onPushSaveButton:(UIButton *)sender {

// From stack
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
//    [outputFormatter setDateFormat:@"HH:mm"];
//    NSString *dateString = [outputFormatter stringFromDate:self.datePicker.date];
//    [outputFormatter release];

    [self.enterExerciseTextField resignFirstResponder];

    NSDate *pickerDate = [self.datePicker date];
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = pickerDate;
    localNotification.alertBody = self.enterExerciseTextField.text;
    localNotification.alertAction = @"Time to Workout";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] +1;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];


    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
