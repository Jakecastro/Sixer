//
//  InitialScreenViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/6/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

// Imports
#import "InitialScreenViewController.h"
#import "ExerciseViewController.h"
#import <Parse/Parse.h>

@interface InitialScreenViewController ()

// Properties

@property PFUser *currentUser;
@property BOOL userLoggedIn;

@end

@implementation InitialScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self checkCurrentUser];
}

- (void)checkCurrentUser {
    
    if (self.currentUser) {
        [self performSegueWithIdentifier:@"MainSegue"sender:nil];
    } else {
        [self performSegueWithIdentifier:@"RegistrationSegue" sender:nil];
    }
    
}


@end
