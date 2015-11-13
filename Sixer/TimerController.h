//
//  TimerUpController.h
//  Sixer
//
//  Created by Jake Castro on 11/11/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HostViewController.h"
#import "JoinViewController.h"
#import "MultiplayerViewController.h"


@interface TimerController : UIViewController <HostViewControllerDelegate, JoinViewControllerDelegate, MultiplayerViewControllerDelegate>
@end
