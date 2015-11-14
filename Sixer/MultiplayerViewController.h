//
//  MultiplayerViewController.h
//  Sixer
//
//  Created by Jake Castro on 11/13/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@class MultiplayerViewController;

@protocol MultiplayerViewControllerDelegate <NSObject>

- (void)multiplayerViewController:(MultiplayerViewController *)controller didQuitWithReason:(QuitReason)reason;

@end

@interface MultiplayerViewController : UIViewController <UIAlertViewDelegate, GameDelegate>

@property (nonatomic, weak) id <MultiplayerViewControllerDelegate> delegate;
@property (nonatomic, strong) Game *game;

@end
