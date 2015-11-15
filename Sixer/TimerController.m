//
//  TimerUpController.m
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "TimerController.h"
#import "Game.h"
#import "Color.h"

@interface TimerController ()

@property (weak, nonatomic) IBOutlet UIButton *hostGameButton;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;
@property (weak, nonatomic) IBOutlet UIButton *quitGameButton;

@end

@implementation TimerController {
    BOOL _performAnimations;
}

- (void)viewDidLoad {
    [self.view setBackgroundColor:[Color flatWetAsphalt]];
}

#pragma mark - HostViewControllerDelegate
- (void)hostViewControllerDidCancel:(HostViewController *)controller {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)hostViewController:(HostViewController *)controller didEndSessionWithReason:(QuitReason)reason {
    if (reason == QuitReasonNoNetwork) {
        [self showNoNetworkAlert];
    }
}

- (void)hostViewController:(HostViewController *)controller startGameWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients
{
    _performAnimations = NO;
    
    [self dismissViewControllerAnimated:NO completion:^
     {
         _performAnimations = YES;
         
         [self startGameWithBlock:^(Game *game)
          {
              [game startServerGameWithSession:session playerName:name clients:clients];
          }];
     }];
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
    
    UIAlertController *alertDisconnected = [UIAlertController alertControllerWithTitle:@"Disconnected"
                                                                   message:@"You were disconnected from the game"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *okDisconnected = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    
    [alertDisconnected addAction:okDisconnected];
    [self presentViewController:alertDisconnected
                       animated:YES
                     completion:nil];

}

- (void)showNoNetworkAlert {
    
    UIAlertController *alertNoNetwork = [UIAlertController alertControllerWithTitle:@"No Network"
                                                                   message:@"please enable Bluetooth or Wi-Fi in your device's Settings"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *okNoNetwork = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                               }];
    
    
    [alertNoNetwork addAction:okNoNetwork];
    [self presentViewController:alertNoNetwork
                       animated:YES
                     completion:nil];
}

- (void)joinViewController:(JoinViewController *)controller startGameWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID {
    _performAnimations = NO;
//    
//    [self dismissViewControllerAnimated:NO completion:^ {
//         _performAnimations = YES;
    
         [self startGameWithBlock:^(Game *game) {
              [game startClientGameWithSession:session playerName:name server:peerID];
          }];
//     }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _performAnimations = NO;
    }
    return self;
}

- (void)startGameWithBlock:(void (^)(Game *))block
{
    MultiplayerViewController *multiplayerViewController = [[MultiplayerViewController alloc] initWithNibName:@"MultiplayerViewController" bundle:nil];
    multiplayerViewController.delegate = self;
    
    [self presentViewController:multiplayerViewController animated:NO completion:^
     {
         Game *game = [[Game alloc] init];
         multiplayerViewController.game = game;
         game.delegate = multiplayerViewController;
         block(game);
     }];
}

#pragma mark - MultiplayerViewControllerDelegate

- (void)multiplayerViewController:(MultiplayerViewController *)controller didQuitWithReason:(QuitReason)reason {
    [self dismissViewControllerAnimated:NO completion:^
     {
         if (reason == QuitReasonConnectionDropped)
         {
             [self showDisconnectedAlert];
         }
     }];
}

- (IBAction)onHostButtonTapped:(UIButton *)sender {
}

- (IBAction)onJoinGameButtonTapped:(UIButton *)sender {
}



@end
