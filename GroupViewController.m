//
//  GroupViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "GroupViewController.h"
#import "Group.h"
#import "SeeMembersOfGroupViewController.h"
#import "GroupTableViewCell.h"
#import "ExerciseViewController.h"

@interface GroupViewController () <UITableViewDelegate, UITableViewDataSource, PassNameOfGroupDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *groupsArray;
@property NSIndexPath *checkmarkedRow;
@property NSInteger *selectedIndex;

@property Group *passedGroup;

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

    [self.tableView setAllowsMultipleSelection:NO];

    ExerciseViewController *eVC = self.tabBarController.viewControllers[1];
    NSLog(@"viewcontrollers: %@", self.presentingViewController.tabBarController.viewControllers);
//    eVC.groupNameButton.titleLabel.text = @"PEEENIIIS";


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    cell.delegate = self;
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupCell"];
//
//        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
//        cell.accessoryView = switchView;
//        
//    }

    Group *userGroups = [self.groupsArray objectAtIndex:indexPath.row];
    cell.groupNameLabel.text = [userGroups objectForKey:@"name"];
    cell.groupInCell = userGroups;
    //groupInCell is in the customCell
    
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//
//    
//}

- (IBAction)onDoneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.senderEVC.groupNameButton.titleLabel.text = [self.passedGroup objectForKey:@"name"];
    self.senderEVC.groupCurrentlyIn = self.passedGroup;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectedRowSegue"]) {

        SeeMembersOfGroupViewController *vc = segue.destinationViewController;
        GroupTableViewCell *cell = sender;
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        Group *tempGroup = [self.groupsArray objectAtIndex:path.row];
        vc.selectedGroup = tempGroup;
        //selected group is the on the destination vc

    }

}

-(void)groupTableViewCell:(id)cell didTapButton:(UIButton *)button withGroup:(Group *)group{
    
    self.passedGroup = group;
}

@end













