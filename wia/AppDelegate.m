//
//  AppDelegate.m
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <CloudKit/CloudKit.h>
#import "WIAFirstLaunchViewController.h"
#import "WIAColor.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
    NSLog(@"DEBUG");
#else
    [self initilizeFabric];
#endif
    
    [GMSServices provideAPIKey:@"AIzaSyA68xxrM0-IpriUnNvxu-wz8BTN9cGEhSI"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDMGccE_ROa_aX8UL5-6Xgw-bTOz7hf2Mo"];
    
//    if (YES) {
//        UINavigationController *firstLaunch = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WIAFirstLaunchViewController"];
//        self.window.rootViewController = firstLaunch;
//    }
    
    [[UIView appearance] setTintColor:[WIAColor mainColor]];
    
    return YES;
}

- (void)initilizeFabric{
    [Fabric with:@[[Crashlytics class]]];
    CKContainer *container = [CKContainer defaultContainer];
    [container accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError *error) {
        if (accountStatus == CKAccountStatusAvailable) {
            [container fetchUserRecordIDWithCompletionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
                [CrashlyticsKit setUserIdentifier:recordID.recordName];
            }];
        }
    }];
}

- (void)switchRootViewControllerWith:(UIViewController*)controller{
    self.window.rootViewController = controller;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
