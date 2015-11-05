//
//  AddGroupViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddGroupViewController.h"

@interface AddGroupViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *searchResultsArray;

@end

@implementation AddGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResultsArray = [NSMutableArray new];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddGroupCell" forIndexPath:indexPath];

    return cell;
}


@end
