//
//  ProgressViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

// Imported Files
#import "ProgressViewController.h"
#import "ProgressCell.h"
#import <Parse/Parse.h>

// Delegates
@interface ProgressViewController () <UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Properties
@property NSArray *progressArray;
@property PFUser *currentUser;


@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressArray = [NSArray new];
    self.currentUser = [PFUser currentUser];
    [self retrieveDataFromParse];
  
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (![PFUser currentUser]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistrationAndLogin" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

// Setting the number of rows to the number of indexes in the array
    return self.progressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressCell"];
    PFObject *userScore = [self.progressArray objectAtIndex:indexPath.row];
    NSString *date = @"jumping jacks";
    cell.exerciseNameLabel.text = date;
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",userScore[@"score"]];

    

    return cell;
}

-(void) retrieveDataFromParse {
    
    // Retrieving data for the user's score objects for the week
    PFQuery *userscoreQuery = [PFQuery queryWithClassName:@"Activity"];
    [userscoreQuery whereKey:@"user" equalTo:self.currentUser];
    
    [userscoreQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        // Setting the objectsArray to the userScoreArray
        self.progressArray = objects;
        [self.tableView reloadData];
    }];

}

@end
