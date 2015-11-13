//
//  LoginViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

// Imports
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ExerciseViewController.h"

// Delegates
@interface LoginViewController () <UITextFieldDelegate>

//Outlets
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

// Properties
@property ExerciseViewController *exerciseViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

// Delegates set in storyboard
  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"Login button"] forState:UIControlStateNormal];
}

-(void)userlogin {
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextFieldOutlet.text;
    
    if (username.length <= 0 || password.length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Inorder to proceed, all fields must be completed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                 
                                                                 
                                                                 
                                                                 
                                                             }];
        [alert addAction:okayButton];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        
        

    } else {
     
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (user) {
            [self performSegueWithIdentifier:@"StartSegue" sender:nil];
            NSLog(@"successful login");
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:okayButton];
            [self presentViewController:alert animated:YES completion:nil];
      }
    }];
  }
}

- (IBAction)onLoginButtonTapped:(UIButton *)sender {
    
    [self userlogin];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}



@end
