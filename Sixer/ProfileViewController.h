//
//  ProfileViewController.h
//  Sixer
//
//  Created by Danielle Smith on 11/7/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileDelegate <NSObject>

-(void)showMenu;

@end
@interface ProfileViewController : UIViewController
@property (nonatomic, weak) id<ProfileDelegate> delegate;
@end
