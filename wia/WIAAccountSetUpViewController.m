//
//  WIAAccountSetUpViewController.m
//  wia
//
//  Created by Abbin Varghese on 16/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAAccountSetUpViewController.h"
#import "AppDelegate.h"
#import <GooglePlaces/GooglePlaces.h>
#import <PINCache.h>
#import "WIAConstants.h"
#import <CloudKit/CloudKit.h>

@interface WIAAccountSetUpViewController ()

@property (nonatomic, assign) BOOL shouldAnimate;
@property (strong, nonatomic) GMSPlacesClient *placesClient;

@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation WIAAccountSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldAnimate = YES;
    self.placesClient = [GMSPlacesClient sharedClient];
    
    NSString *userName = [[PINCache sharedCache] objectForKey:kWIAUserName];
    __block CLLocation *userLocation = [[PINCache sharedCache] objectForKey:kWIAUserLocation];
    __block NSString *userLocationName = [[PINCache sharedCache] objectForKey:kWIAUserLocationName];
    
    if (userLocationName.length > 0 && userLocation != nil) {
        [self updateUserWithName:userName location:userLocation locationName:userLocationName];
    }
    else{
        [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
            if (error != nil) {
                [self alertWithError:error];
                return;
            }
            if (placeLikelihoodList != nil) {
                GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
                if (place != nil) {
                    for (GMSAddressComponent *component in place.addressComponents) {
                        if ([component.type isEqualToString:@"locality"]) {
                            userLocationName = component.name;
                        }
                    }
                    userLocation = [[CLLocation alloc]initWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude];
                    [self updateUserWithName:userName location:userLocation locationName:userLocationName];
                }
            }
        }];
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.shouldAnimate) {
        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.logLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.logLabel.text = @"Doing more stuff...";
            if (self.shouldAnimate) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.logLabel.alpha = 1.0;
                } completion:^(BOOL finished) {
                    if (self.shouldAnimate) {
                        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.logLabel.alpha = 0.0;
                        } completion:^(BOOL finished) {
                            self.logLabel.text = @"Taking a break...";
                            if (self.shouldAnimate) {
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                    self.logLabel.alpha = 1.0;
                                } completion:^(BOOL finished) {
                                    if (self.shouldAnimate) {
                                        [UIView animateWithDuration:0.3 delay:5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                            self.logLabel.alpha = 0.0;
                                        } completion:^(BOOL finished) {
                                            self.logLabel.text = @"Back doing stuff...";
                                            if (self.shouldAnimate) {
                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                    self.logLabel.alpha = 1.0;
                                                } completion:^(BOOL finished) {
                                                    if (self.shouldAnimate) {
                                                        [UIView animateWithDuration:0.3 delay:4 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                            self.logLabel.alpha = 0.0;
                                                        } completion:^(BOOL finished) {
                                                            self.logLabel.text = @"This is taking too long...🤔";
                                                            if (self.shouldAnimate) {
                                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                    self.logLabel.alpha = 1.0;
                                                                } completion:^(BOOL finished) {
                                                                    if (self.shouldAnimate) {
                                                                        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                            self.logLabel.alpha = 0.0;
                                                                        } completion:^(BOOL finished) {
                                                                            self.logLabel.text = @"Ok, Finishing up...";
                                                                            if (self.shouldAnimate) {
                                                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                                    self.logLabel.alpha = 1.0;
                                                                                } completion:nil];
                                                                            }
                                                                        }];
                                                                    }
                                                                }];
                                                            }
                                                        }];
                                                    }
                                                }];
                                            }
                                        }];
                                    }
                                }];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utility Methods

-(void)updateUserWithName:(NSString *)name location:(CLLocation *)location locationName:(NSString*)locationName{
    CKContainer *myContainer = [CKContainer defaultContainer];
    [myContainer fetchUserRecordIDWithCompletionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error3) {
        if (!error3) {
            CKRecordID *userRecordID = [[CKRecordID alloc] initWithRecordName:[NSString stringWithFormat:@"%@%@",kWIARecordTypeUserProfile,recordID.recordName]];
            CKRecord *userRecord = [[CKRecord alloc] initWithRecordType:kWIARecordTypeUserProfile recordID:userRecordID];
            
            userRecord[kWIAUserName] = name;
            userRecord[kWIAUserLocation] = location;
            userRecord[kWIAUserLocationName] = locationName;
            
            CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
            [publicDatabase saveRecord:userRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error2) {
                if (!error2) {
                    [self cacheUserWithRecord:record];
                    [self switchRootViewController];
                }
                else if (error2.code == CKErrorServerRecordChanged){
                    CKRecord *serverRecord = [error2.userInfo objectForKey:@"ServerRecord"];
                    serverRecord[kWIAUserName] = name;
                    serverRecord[kWIAUserLocation] = location;
                    serverRecord[kWIAUserLocationName] = locationName;
                    [publicDatabase saveRecord:serverRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error1) {
                        if (!error1) {
                            [self cacheUserWithRecord:record];
                            [self switchRootViewController];
                        }
                        else{
                            [self alertWithError:error1];
                        }
                    }];
                }
                else{
                    [self alertWithError:error2];
                }
            }];
        }
        else{
            [self alertWithError:error3];
        }
    }];
}

-(void)alertWithError:(NSError*)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Somthing went wrong" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)switchRootViewController{
    self.shouldAnimate = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UITabBarController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WIATabBarController"];
        [delegate switchRootViewControllerWith:controller];
    });
}

- (void)cacheUserWithRecord:(CKRecord*)record{
    PINCache *userCache = [[PINCache alloc]initWithName:kWIARecordTypeUserProfile];
    [userCache setObject:record[kWIAUserName] forKey:kWIAUserName];
    [userCache setObject:record[kWIAUserLocation] forKey:kWIAUserLocation];
    [userCache setObject:record[kWIAUserLocationName] forKey:kWIAUserLocationName];
    
    [[PINCache sharedCache] removeAllObjects];
}

@end
