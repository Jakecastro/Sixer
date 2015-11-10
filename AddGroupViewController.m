//
//  AddGroupViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddGroupViewController.h"
#import "Group.h"
#import "User.h"
#import "AppDelegate.h"

@interface AddGroupViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSArray *searchResultsArray;
@property NSMutableArray *filteredResultsArray;
@property BOOL isFiltered;
@property (strong, nonatomic) PFUser *allUser;
@property NSMutableArray *friends;
@property PFUser *user;

@end

@implementation AddGroupViewController
// this is where you search for users and add them to the relation a group
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResultsArray = [NSArray new];
    self.friends = [NSMutableArray new];

    [self SearchUsers];



}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    if (self.isFiltered) {
        return self.filteredResultsArray.count;
    }else {

        return self.searchResultsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddGroupCell" forIndexPath:indexPath];

    if (self.isFiltered) {
        self.allUser = [self.filteredResultsArray objectAtIndex:indexPath.row];
    }
    else {
        self.allUser = [self.searchResultsArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = self.allUser.username;
    return cell;


}



- (void)SearchUsers {
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.searchResultsArray  = objects;
            [self.tableView reloadData];
        }
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.searchResultsArray objectAtIndex:indexPath.row];
//    PFUser *currentUser = [PFUser currentUser];
    PFRelation *groupMemberRelation = [self.selectedGroupTwo relationForKey:@"members"];

    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryNone;

        for(PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }

        [groupMemberRelation removeObject:user];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.friends addObject:user];
        [groupMemberRelation addObject:user];
    }
    [self.selectedGroupTwo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (BOOL)isFriend:(PFUser *)user {
    for(PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }

    return NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.searchBar.text.length == 0) {
        self.isFiltered = NO;
    }
    else {
        self.isFiltered = YES;
        self.filteredResultsArray = [NSMutableArray new];

        for (User *user in self.searchResultsArray) {
            NSRange nameRange = [user.username rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];

            if (nameRange.location != NSNotFound) {
                [self.filteredResultsArray addObject:user];
            }


        }
        
    }
    [self.tableView reloadData];
}




@end
