//
//  RemindersViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "RemindersViewController.h"
#import "Exercise.h"


@interface RemindersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *myRemindersLabel;
@property NSMutableArray *remindersArray;
@property Exercise *selectedExercise;

@end



@implementation RemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *titleImage = [UIImage imageNamed:@"Get Active!"];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:titleImage];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:194.0/255.0 green:222.0/255.0 blue:17.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self.tableView reloadData];

//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reloadTable)
//                                                 name:@"reloadData"
//                                               object:nil];

}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (IBAction)onAddButtonTapped:(UIButton *)sender {
    //segue to next page
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemdinderCell" forIndexPath:indexPath];

    // Get list of local notifications

    self.remindersArray = [[[UIApplication sharedApplication] scheduledLocalNotifications]mutableCopy];
    UILocalNotification *localNotification = [self.remindersArray objectAtIndex:indexPath.row];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];


    //Display notification info
    [cell.textLabel setText:localNotification.alertBody];
    [cell.detailTextLabel setText:[outputFormatter stringFromDate:localNotification.fireDate]];


    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSArray *localNotifications = [[UIApplication sharedApplication]  scheduledLocalNotifications];
        UILocalNotification *notify = [localNotifications objectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] cancelLocalNotification:notify];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [self.tableView reloadData];
    }
    
    
}

@end
