//
//  EditViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/10/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "EditViewController.h"
#import <Parse/Parse.h>

@interface EditViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordImageView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@property PFUser *currentUser;
@property UIImagePickerController *picker;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

// Instantiating Current User
    self.currentUser = [PFUser currentUser];

// Setting the delegates of the textfields
    self.usernameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextfield.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    
// Setting tags for the textfields
    self.usernameTextField.tag = 1;
    self.emailTextField.tag = 2;
    self.passwordTextfield.tag = 3;
    self.confirmPasswordTextField.tag = 4;
    
// Setting the placeholder text for the textfields
    self.usernameTextField.placeholder = self.currentUser.username;
    self.emailTextField.placeholder = self.currentUser.email;

// Making the shape of the profile image view circular
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2;
    self.profileImageView.clipsToBounds = YES;

// Setting the image of the profileImageView to the current user's photo

    PFFile *profilePicture = self.currentUser[@"Photo"];
    [profilePicture getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *profileImage = [UIImage imageWithData:data];
        self.profileImageView.image = profileImage;
    }];

 
}
- (IBAction)onCancelButtonTapped:(UIButton *)sender {
    
// Dismiss the EditViewController
//    UIViewController *editViewController = [ UIViewController new];
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *menuVC = [storyboard instantiateViewControllerWithIdentifier:@"MenuScreen"];
//    [self.navigationController pushViewController:menuVC animated:YES];
}

- (IBAction)onDoneButtonTapped:(UIButton *)sender {
    
    self.currentUser.username = self.usernameTextField.text;
    self.currentUser.password = self.passwordTextfield.text;
    self.currentUser.email =  self.emailTextField.text;
    [self.currentUser saveEventually];
    
    
}
- (IBAction)onEditButtonTapped:(UIButton *)sender {
    
// Allow user to select new photo from their library
    self.picker = [UIImagePickerController new];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

// Set profile image to the new image selected by the user
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = selectedImage;
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

// Hide textfield when it is no longer in use
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
