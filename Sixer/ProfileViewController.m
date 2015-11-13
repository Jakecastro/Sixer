//
//  ProfileViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

// Imports
#import "ProfileViewController.h"
#import "Settings.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"

// Delegates
@interface ProfileViewController ()< UITableViewDelegate, UITableViewDataSource>

// Properties
@property NSArray *settingsArray;
@property NSArray *userScoreArray;
@property NSInteger sumOfUserScores;
@property PFUser *currentUser;

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScoreLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Making an instance of PFUser
    self.currentUser = [PFUser currentUser];

// If there's no current user present login screen
    if (!self.currentUser) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistrationAndLogin" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else {
 
// Call Methods
        [self retrieveUsernameAndPhoto];
        [self calculateUsersWeeklyScore];

    }
}

-(void)viewDidAppear:(BOOL)animated {
    
// Call Methods
    [self retrieveUsernameAndPhoto];
    [self calculateUsersWeeklyScore];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
// Call Methods
    [self retrieveUsernameAndPhoto];
    [self calculateUsersWeeklyScore];
    
}
#pragma mark - TableViewDelegate Methods
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

// Setting the number of rows in the tableview to the number of indexes in the array
    return self.settingsArray.count;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    Settings *Object = [self.settingsArray objectAtIndex:indexPath.row];
    
// Setting the Cell labels and images
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
    
// Return cell
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
// If user selects the Edit, do the following:
    if (indexPath.row == 0) {
   
// Present Edit Screen
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditScreen"];
        [self presentViewController:editVC animated:YES completion:nil];
 
// If user selects the logout, do the following:
    } else if (indexPath.row == 1){
  
// Log user out
        [PFUser logOut];
        
// Present Login Screen
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistrationAndLogin" bundle:nil];
        UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
        
    
}

-(void) calculateUsersWeeklyScore {
    // Retrieving data for the user's score objects for the week
    PFQuery *userscoreQuery = [PFQuery queryWithClassName:@"Week"];
    [userscoreQuery whereKey:@"user" equalTo:self.currentUser];
    [userscoreQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        // Setting the objectsArray to the userScoreArray
        self.userScoreArray = objects;
        
        // Giving the sumOfUserScores property an initial value of zero
        self.sumOfUserScores = 0;
        
        // Iterating through the usersScore array and setting the sum of all the score objects to the sumOfUsersScore property
        for (PFObject *userScores in self.userScoreArray) {
            self.sumOfUserScores += [[userScores objectForKey:@"score"]intValue];
            
        }
        // Setting the sumofUserScores property to the userScoreLabel text
        self.userScoreLabel.text = [NSString stringWithFormat:@"Weekly Score: %li", (long)self.sumOfUserScores];
    }];
    
    // Initializing the properties of the Settings class
    Settings *edit = [[Settings alloc] initWithName:@"Edit" withImage:[UIImage imageNamed:@"Settings"]];
    Settings *logout = [[Settings alloc] initWithName:@"Logout" withImage:[UIImage imageNamed:@"User"]];
    
    // Adding settings objects to the settings array
    self.settingsArray = [NSArray arrayWithObjects:edit, logout
                          , nil];
    
}

-(void) retrieveUsernameAndPhoto {
    
    // Retrieving the user's photo data from parse and setting it to the userimageview
    PFFile *profilePicture = self.currentUser[@"Photo"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *profileImage = [UIImage imageWithData:data];
        self.userImage.image = profileImage;
    }];
    
//    // Making the profile picture the shape of a circle
//    self.userImage.layer.cornerRadius = 50;
//    self.userImage.clipsToBounds = YES;
//    self.userImage.layer.borderWidth = 0.5;
//    self.userImage.layer.borderColor = [UIColor grayColor].CGColor;
    
    // Setting the username label text
    self.usernameLabel.text = self.currentUser.username;

    
}

@end
