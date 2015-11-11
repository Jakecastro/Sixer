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
@property NSData *selectedImageData;
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
        
        [self.currentUser saveInBackground];
    }];

 
}
- (IBAction)onCancelButtonTapped:(UIButton *)sender {
    
// Dismiss the EditViewController
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onDoneButtonTapped:(UIButton *)sender {
 
// Set and Save new values
    [self saveNewPhoto];
    [self saveNewPassword];
    [self saveNewUsername]; 
    [self saveNewEmail];
    
// Dismiss ViewController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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

-(void)saveNewPassword {
 
// initializing variables
    NSString *newPassword = self.passwordTextfield.text;
    NSString *confirmNewPassword = self.confirmPasswordTextField.text;
 
// if password fields are blank
    if (newPassword.length <= 0 || confirmNewPassword.length <= 0) {
        
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
    
// if password fields do not match
    if (newPassword != confirmNewPassword) {

// Display Alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Passwords do not match. Please try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
        self.currentUser.password = self.passwordTextfield.text;
        [self.currentUser saveInBackground];
    
    
}
-(void)saveNewPhoto {

// Convert profile image into data
    self.selectedImageData = UIImageJPEGRepresentation(self.profileImageView.image, 1);

// If there is a profile image
    if(self.selectedImageData != nil) {
        
// Convert the profile image data into a PFFile
        PFFile *imageFile = [PFFile fileWithName:@"image" data:self.selectedImageData];

// Set the current user's photo property in parse to the image file
        self.currentUser[@"Photo"] = imageFile;
        
// Save new image to Parse
        [self.currentUser saveInBackground];
        
    }
    
    
}

-(void) saveNewUsername {
 
// Initialize variable
    NSString *newUsername = self.usernameTextField.text;
  
// If nothing is entered in the new username textfield
    if (newUsername.length <= 0) {
        
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
    
// Set new username to current user's username and save to parse
     self.currentUser.username = newUsername;
    [self.currentUser saveInBackground];
}

-(void) saveNewEmail {
    
// Initialize variable
    NSString *newEmail = self.emailTextField.text;
    
// If nothing is entered in the new username textfield
    if (newEmail.length <= 0) {
        
// Do nothing
        
    } else {
    
// Set new email to current user's email and save to parse
    self.currentUser.email = newEmail;
    [self.currentUser saveInBackground];
        
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
// Hide textfield when it is no longer in use
    [textField resignFirstResponder];
    
    return YES;
}

@end
