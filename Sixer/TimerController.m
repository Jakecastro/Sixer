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

#pragma mark - HostViewControllerDelegate

- (void)hostViewControllerDidCancel:(HostViewController *)controller {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)hostViewController:(HostViewController *)controller didEndSessionWithReason:(QuitReason)reason {
    if (reason == QuitReasonNoNetwork)
    {
        [self showNoNetworkAlert];
    }
}

#pragma mark - JoinViewControllerDelegate
- (void)joinViewControllerDidCancel:(JoinViewController *)controller {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)joinViewController:(JoinViewController *)controller didDisconnectWithReason:(QuitReason)reason {
    if (reason == QuitReasonConnectionDropped) {
        
        [self dismissViewControllerAnimated:NO completion:^ {
             [self showDisconnectedAlert];
         }];
    }
}


- (void)showDisconnectedAlert {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Disconnected", @"Client disconnected alert title")
                              message:NSLocalizedString(@"You were disconnected from the game.", @"Client disconnected alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)showNoNetworkAlert {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"No Network", @"No network alert title")
                              message:NSLocalizedString(@"To use multiplayer, please enable Bluetooth or Wi-Fi in your device's Settings.", @"No network alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
    [alertView show];
}


- (IBAction)onHostButtonTapped:(UIButton *)sender {
}

- (IBAction)onJoinGameButtonTapped:(UIButton *)sender {
}



@end
