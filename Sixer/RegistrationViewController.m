//
//  RegistrationViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//
// Imports
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

// Delegates
@interface RegistrationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;

@property (weak, nonatomic) IBOutlet UIButton *signupButton;

// Properties
@property UIImage *userImage;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *titleImage = [UIImage imageNamed:@"Get Active!"];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:titleImage];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:194.0/255.0 green:222.0/255.0 blue:17.0/255.0 alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    // Set the textfield delegates
    self.usernameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
    self.userProfileImageView.image = [UIImage imageNamed:@"AddPhotoImage"];
    
    [self.signupButton setBackgroundImage:[UIImage imageNamed:@"SignupButton"] forState:UIControlStateNormal];
    
    
}
- (IBAction)onSelectProfilePictureButtonTapped:(UIButton *)sender {
    
    // Making an Instance of UIImagePickerController
    UIImagePickerController *pickerController = [UIImagePickerController new];
    
    // Setting its delegate
    pickerController.delegate = self;
    
    // Setting the sourcetype to the user's photo library
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Presenting the controller
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma  mark - UIImagePicker Delegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Setting the userimage property to the image selected by the user
    self.userImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // Setting the profile image to the image selected by the user
    self.userProfileImageView.image = self.userImage;
    
    // Dismissing the Controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)onSignUpButtonTapped:(UIButton *)sender {
    
    // Creating and initializing variables for all fields
    NSString *username = self.usernameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    
    // Make sure all fields have been completed by the user
    if (username.length <= 0 || email.length <= 0
        || password.length <= 0 || confirmPassword.length <= 0) {
        
        // Display Alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"In order to proceed, all fields must be completed." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                             }];
        [alert addAction:okayButton];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        
        
        
    }
    
    // Make sure the passwords entered by the user match
    if (password != confirmPassword) {
        
        // Display Alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Passwords do not match. Please try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                             }];
        [alert addAction:okayButton];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        
        
    }
    
    // Create an instance of the photo selected by user
    NSData *selectedImage = UIImageJPEGRepresentation(self.userImage, 1);
    
    // Create an instance of PFUser
    PFUser *user = [PFUser new];
    
    // Initializing the properties of PFUser
    user.username = username;
    user.password = password;
    user.email = email;
    
    // Check if the user selected an image
    if (selectedImage != nil) {
        
        // If there is an image, convert it to a PFFile
        PFFile *imageFile = [PFFile fileWithName:@"image" data:selectedImage];
        
        user[@"Photo"] = imageFile;
        
        // Call the signup method
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            // Message displayed if signup was successful
            NSString *userMessage = @"Registration was successful";
            
            if (!succeeded) {
                
                // Message displayed if signup was unsuccessful
                userMessage = error.localizedDescription;
                
            }
            // Display Alert
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:userMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                                 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                     // Dismiss Controller if signup was successful
//                                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                                     [[[self presentingViewController]  presentingViewController] dismissViewControllerAnimated:true completion:nil];
                                                                     //                                                                     [self presentViewController:alert
                                                                     //                                                                                        animated:YES
                                                                     //                                                                                      completion:nil];
                                                                     
                                                                 }];
            [alert addAction:okayButton];
            [self presentViewController:alert animated:true completion:nil];
            
        }];
        
        
    }
    
}

- (IBAction)onAlreadyAUserButtonTapped:(UIButton *)sender {
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}
@end
