//
//  GroupViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "GroupViewController.h"
#import "Group.h"

@interface GroupViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *groupsArray;

@end


@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groupsArray = [NSMutableArray new];

    PFQuery *groupsQuery = [PFQuery queryWithClassName:@"Group"];
    [groupsQuery whereKeyExists:@"name"];

    [groupsQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Matt come fix this %@",error);
        }
        else {
            self.groupsArray = [objects mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    Group *userGroups = [self.groupsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [userGroups objectForKey:@"name"];
    return cell;
}
- (IBAction)onAddButtonTapped:(UIButton *)sender {
    Group *groupToAdd = [Group objectWithClassName:@"Group"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Group"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"group name";
    }];

    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {

        UITextField *groupName = [[alertController textFields] firstObject];
        NSLog(@"%@", groupName.text);
        groupToAdd[@"name"] = [NSString stringWithFormat:@"%@", groupName.text];
        [groupToAdd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"well fuck %@",error);
            }
        }];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * _Nonnull action) {
    }];

    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end













