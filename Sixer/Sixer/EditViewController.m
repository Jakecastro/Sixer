//
//  EditViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/10/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordImageView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
- (IBAction)onCancelButtonTapped:(UIButton *)sender {
}

- (IBAction)onDoneButtonTapped:(UIButton *)sender {
}
- (IBAction)onEditButtonTapped:(UIButton *)sender {
}


@end
