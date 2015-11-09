//
//  SeeMembersOfGroupViewController.m
//  Sixer
//
//  Created by Matt Burrill on 11/9/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "SeeMembersOfGroupViewController.h"

@interface SeeMembersOfGroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *membersArray;

@end

@implementation SeeMembersOfGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"membersCell" forIndexPath:indexPath];


    return cell;
}






@end
