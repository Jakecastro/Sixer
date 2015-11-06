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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];

    return cell;
}
- (IBAction)onAddButtonTapped:(UIButton *)sender {

    Group *groupToAdd = [Group objectWithClassName:@"Group"];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Group" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"group name";
    }];

    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTextField = [[alertController textFields] firstObject];
        NSLog(@"%@", nameTextField.text);
        groupToAdd[@"name"] = [NSString stringWithFormat:@"%@", nameTextField.text];
//        groupToAdd.groupName = nameTextField.text;
        [groupToAdd saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"well fuck");
            }
            else {
            }
        }];

//        [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//                // The object has been saved.
//            } else {
//                // There was a problem, check error.description
//            }


// TODO: change below to current user
//        groupToAdd.members = @"current user";


    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];

    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
