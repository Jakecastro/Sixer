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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.remindersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemdinderCell" forIndexPath:indexPath];

    return cell;
}

@end
