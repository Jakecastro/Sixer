//
//  AppDelegate.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Exercise.h"
#import "Color.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Exercise registerSubclass];
    
    // Initialize Parse.
    [Parse setApplicationId:@"gVFJgoezxzMORzfgiTCgwIsvfEeTrQPL6IlOoBTP"
                  clientKey:@"fj22hAaOlF15CiAEncRWNHpeXzo5v5QBUh03xYrx"];
    [[UITabBar appearance] setTintColor:[Color chartreuse]];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
    tabBar.selectedIndex = 1;
    
    //Presents Initial Screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Initial" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"InitialScreen"];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    //For local notifications
    UILocalNotification *localNotif = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        application.applicationIconBadgeNumber = 0;
    }

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

    UIApplicationState state = [application applicationState];

    if (state == UIApplicationStateActive) {


        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"Every Hour" message:@"Time to exercise!" preferredStyle:UIAlertControllerStyleActionSheet];


        UIAlertAction *openApp = [UIAlertAction actionWithTitle:@"Open app" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //somehow open the app
        }];

        UIAlertAction *ignore = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // do nothing

        }];

        [alert addAction:openApp];
        [alert addAction:ignore];
        [alert presentViewController:alert animated:YES completion:nil];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    application.applicationIconBadgeNumber = 0;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[UIApplication sharedApplication].applicationIconBadgeNumber -1];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
