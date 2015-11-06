//
//  RegistrationViewController.h
//  Sixer
//
//  Created by Danielle Smith on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end
