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
@property (weak, nonatomic) IBOutlet UIImageView *usernameIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

// Properties
@property ExerciseViewController *exerciseViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

// Delegates set in storyboard
 
    
    
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
     
    
    }
}

- (IBAction)onLoginButtonTapped:(UIButton *)sender {
}




@end
