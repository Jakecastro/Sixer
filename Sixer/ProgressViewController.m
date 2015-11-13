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
#import "Activity.h" 
#import <Parse/Parse.h>
#import "Color.h"
#import "LoginViewController.h"


// Delegates
@interface ProgressViewController () <UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

// Properties
@property NSArray *progressArray;
@property NSArray *userScoreArray;
@property NSInteger *sumOfScores;
@property PFUser *currentUser;


@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *titleImage = [UIImage imageNamed:@"Get Active!"];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:titleImage];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:194.0/255.0 green:222.0/255.0 blue:17.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    self.progressArray = [NSArray new];
    self.currentUser = [PFUser currentUser];
    [self retrieveDataFromParse];
    [self retrieveUsernameAndPhoto];
  
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (![PFUser currentUser]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistrationAndLogin" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [self presentViewController:loginVC animated:YES completion:nil];
        [self retrieveUsernameAndPhoto];
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
-(void) retrieveUsernameAndPhoto {
    
    // Retrieving the user's photo data from parse and setting it to the userimageview
    PFFile *profilePicture = self.currentUser[@"Photo"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *profileImage = [UIImage imageWithData:data];
        self.userImageView.image = profileImage;
    }];
    
    // Making the profile picture the shape of a circle
    self.userImageView.layer.cornerRadius = 40;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.borderWidth = 0.5;
    self.userImageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    // Setting the username label text
    self.usernameLabel.text = self.currentUser.username;
    
    
}


@end
