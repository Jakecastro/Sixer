//
//  ProfileViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ProfileViewController.h"
#import "Settings.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"

//Add UITableViewDataSource and drag properties
@interface ProfileViewController ()< UITableViewDelegate, UITableViewDataSource>
@property NSArray *settingsArray;
@property NSArray *userScoreArray;
@property NSInteger sumOfUserScores;


@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScoreLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Making an instance of PFUser
    PFUser *currentUser = [PFUser currentUser];

// If there's no current user present login screen
    if (!currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistrationAndLogin" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
          
// If there's a current user do the following
    PFFile *profilePicture = currentUser[@"Photo"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *profileImage = [UIImage imageWithData:data];
        self.userImage.image = profileImage;
    }];
    
    self.userImage.layer.cornerRadius = 50;
    self.userImage.clipsToBounds = YES;
    self.userImage.layer.borderWidth = 0.5;
    self.userImage.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.usernameLabel.text = currentUser.username;
    PFQuery *userscoreQuery = [PFQuery queryWithClassName:@"Week"];
    [userscoreQuery whereKey:@"user" equalTo:currentUser];
    [userscoreQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.userScoreArray = objects;
        self.sumOfUserScores = 0;
        
        for (PFObject *userScores in self.userScoreArray) {
            self.sumOfUserScores += [[userScores objectForKey:@"score"]intValue];
            
        }
        self.userScoreLabel.text = [NSString stringWithFormat:@"Weekly Score: %li", (long)self.sumOfUserScores];
    }];
 

    Settings *edit = [[Settings alloc] initWithName:@"Edit" withImage:[UIImage imageNamed:@"Settings"]];
    Settings *logout = [[Settings alloc] initWithName:@"Logout" withImage:[UIImage imageNamed:@"User"]];
    
    self.settingsArray = [NSArray arrayWithObjects:edit, logout
                          , nil];

    }
}

#pragma mark - TableViewDelegate Methods
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingsArray.count;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    Settings *Object = [self.settingsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = Object.cellName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = Object.cellImage;
    
    // Changing the length and color of the separator line between tableview cells
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setSeparatorColor:[UIColor blackColor]];
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.settingsTableView.sectionIndexColor = [UIColor whiteColor];
    self.settingsTableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    
  
    

    return cell;
}




@end
