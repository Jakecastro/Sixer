//
//  RemindersViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "RemindersViewController.h"


@interface RemindersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *myRemindersLabel;
@property NSMutableArray *remindersArray;

@end



@implementation RemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];

    //Display notification info
    [cell.textLabel setText:localNotification.alertBody];
    [cell.detailTextLabel setText:[localNotification.fireDate description]];

    return cell;
}

@end
