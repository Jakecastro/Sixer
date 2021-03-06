//
//  SecondViewController.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"


// Delegate
@protocol FrontDelegate <NSObject>

// Declare Delegate Method
-(void) frontRevealButtonTapped;

@end

@interface ExerciseViewController : UIViewController

//Set Delegate
@property (nonatomic, weak) id<FrontDelegate> delegate;
@property Group *groupCurrentlyIn;

@property (weak, nonatomic) IBOutlet UIButton *groupNameButton;

@end

