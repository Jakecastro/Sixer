//
//  MultiplayerViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/13/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "MultiplayerViewController.h"

@interface MultiplayerViewController ()

@property (nonatomic, weak) IBOutlet UILabel *centerLabel;

@end

@implementation MultiplayerViewController

@synthesize delegate = _delegate;
@synthesize game = _game;

@synthesize centerLabel = _centerLabel;

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Actions

- (IBAction)exitAction:(id)sender {
    [self.game quitGameWithReason:QuitReasonUserQuit];
}

#pragma mark - GameDelegate

- (void)game:(Game *)game didQuitWithReason:(QuitReason)reason {
    [self.delegate multiplayerViewController:self didQuitWithReason:reason];
}

- (void)gameWaitingForServerReady:(Game *)game {
    self.centerLabel.text = NSLocalizedString(@"Waiting for game to start...", @"Status text: waiting for server");
}

- (void)gameWaitingForClientsReady:(Game *)game {
    self.centerLabel.text = NSLocalizedString(@"Waiting for other players...", @"Status text: waiting for clients");
}

@end






