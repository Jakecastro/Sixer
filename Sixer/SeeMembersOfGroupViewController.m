//
//  SeeMembersOfGroupViewController.m
//  Sixer
//
//  Created by Matt Burrill on 11/9/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "SeeMembersOfGroupViewController.h"
#import "AddGroupViewController.h"
#import "Group.h"

@interface SeeMembersOfGroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *membersArray;
@property PFUser *user;

@end

@implementation SeeMembersOfGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.membersArray = [NSMutableArray new];

    PFRelation *groupMemberRelation = [self.selectedGroup relationForKey:@"members"];
    PFQuery *query = [groupMemberRelation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"It's Jake's Fault");
        }else {
            self.membersArray = objects;
            [self.tableView reloadData];

        }
        
    }];



    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.membersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"membersCell" forIndexPath:indexPath];

    self.user = [self.membersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = self.user.username;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"addMemsToGroupSegue"]) {
        AddGroupViewController *vc = segue.destinationViewController;
        vc.selectedGroupTwo = self.selectedGroup;
    }


    
}





@end
