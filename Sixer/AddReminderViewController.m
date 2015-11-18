//
//  AddReminderViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddReminderViewController.h"

#import "AddReminderViewController.h"
#import "Exercise.h"
#import "Color.h"


@interface AddReminderViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property NSMutableArray *pickerArray;
@property Exercise *selectedExercise;

@end

@implementation AddReminderViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.pickerArray = [NSMutableArray new];

    [self queryExercises];

    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"reloadData" object:nil];
    self.view.backgroundColor=[Color flatCloudsColor];
    [self.pickerView reloadAllComponents];

}

- (IBAction)onPushSaveButton:(UIButton *)sender {

//    NSDate *pickerDate = [self.datePicker date];

    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = self.datePicker.date;
    localNotification.alertBody = self.selectedExercise.name;
    localNotification.alertAction = @"Time to Workout";
    localNotification.timeZone = [NSTimeZone localTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] +1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval = NSCalendarUnitDay;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

//    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];

    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |UIUserNotificationTypeSound;

    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];

    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];

    [self dismissViewControllerAnimated:YES completion:nil];



}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerArray.count;
}

-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Exercise *excer = [self.pickerArray objectAtIndex:row];

    return [excer objectForKey:@"name"];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Selected Row %ld", (long)row);
    self.selectedExercise = [self.pickerArray objectAtIndex:row];

}



-(void)queryExercises{

    PFQuery *exerciseQuery = [PFQuery queryWithClassName:@"Exercise"];
    [exerciseQuery whereKeyExists:@"name"];

    [exerciseQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"blah");
        }
        else {
            self.pickerArray = [objects mutableCopy];
            [self.pickerView reloadAllComponents];
        }
    }];
    
    
}
 
    




@end
