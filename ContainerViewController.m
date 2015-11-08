//
//  ContainerViewController.m
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

// Imports
#import "ContainerViewController.h"
#import "ProfileViewController.h"
#import "ExerciseViewController.h"

// Delegates -- add exercise delegate
@interface ContainerViewController ()<ProfileDelegate>

// Properties

//property for frontViewLeftMargin
//property for frontViewRightMargin
@property ProfileViewController *pvc;
@property ExerciseViewController *evc;
@property BOOL revealTapped;
@end


@implementation ContainerViewController

//IBAction for panGestureRecognizer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.revealTapped = YES;
   
}

// Delegate Method from ProfileViewController
-(void)showMenu {
    

}

// Delegate Method from ExerciseViewcontroller
//-(void)frontRevealButtonTapped {
//    if (self.revealTapped) {
//        self.frontViewLeftMargin.constant = self.view.bounds.size.width * 0.4;
//        self.frontViewRightMargin.constant = -self.view.bounds.size.width * 0.4;
//        self.revealTapped = NO;
//    }
//    else
//    {
//        self.frontViewLeftMargin.constant = -20;
//        self.frontViewRightMargin.constant = -20;
//        self.revealTapped = YES;
//    }
//    [UIView animateWithDuration: 0.3 animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if([segue.identifier isEqualToString:@"FrontSegue"]) {
//        UINavigationController *navigationVC = segue.destinationViewController;
//        self.evc = navigationVC.childViewControllers[0];
//        self.evc.delegate = self;
//    }
//    if ([segue.identifier isEqualToString:@"LeftSegue"]) {
//        self.pvc = segue.destinationViewController;
//        self.pvc.delegate = self;
//        
//        
//        
//    }
//}
@end
