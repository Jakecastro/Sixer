//
//  TimerUpController.m
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "TimerController.h"
#import "Color.h"

@interface TimerController ()

@property (weak, nonatomic) IBOutlet UIButton *hostGameButton;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;
@property (weak, nonatomic) IBOutlet UIButton *quitGameButton;

@end

@implementation TimerController

- (void)viewDidLoad {
    [self.view setBackgroundColor:[Color flatWetAsphalt]];
}


- (IBAction)onHostButtonTapped:(UIButton *)sender {
}

- (IBAction)onJoinGameButtonTapped:(UIButton *)sender {
}



@end
