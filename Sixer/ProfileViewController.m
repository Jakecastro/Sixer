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

//Add UITableViewDataSource and drag properties
@interface ProfileViewController ()< UITableViewDelegate, UITableViewDataSource>
@property NSArray *settingsArray;
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
    PFFile *profilePicture = currentUser[@"Photo"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *profileImage = [UIImage imageWithData:data];
        self.userImage.image = profileImage;
    }];
    
    self.userImage.layer.cornerRadius = 50;
    self.userImage.clipsToBounds = YES;
    self.userImage.layer.borderWidth = 5;
    self.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    Settings *edit = [[Settings alloc] initWithName:@"Edit" withImage:[UIImage imageNamed:@"Settings"]];
    Settings *logout = [[Settings alloc] initWithName:@"Logout" withImage:[UIImage imageNamed:@"User"]];
    
    self.settingsArray = [NSArray arrayWithObjects:edit, logout
                          , nil];

    
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
    self.settingsTableView.sectionIndexColor = [UIColor whiteColor];
    self.settingsTableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
    
    
    // Changing cell's selected background color
    UIView *cellBackground = [[UIView alloc] initWithFrame:cell.frame];
    cellBackground.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView = cellBackground;
    

    return cell;
}




@end
