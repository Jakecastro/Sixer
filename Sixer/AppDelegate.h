//
//  AppDelegate.h
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSArray *defaultExercises;
@property NSMutableArray *exerciseArray;
@property BOOL alreadyLaunchedOnce;

@end

