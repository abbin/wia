//
//  UIViewController+WIAImagePickerController.m
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "UIViewController+WIAImagePickerController.h"
#import <Photos/Photos.h>
#import "WIAImagePickerController.h"

@implementation UIViewController (WIAImagePickerController)

-(void)presentWIAImagePickerController{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized){
        [self presentPicker];
    }
    else if (status == PHAuthorizationStatusDenied
             || status == PHAuthorizationStatusRestricted){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow photo album access?", nil) message:NSLocalizedString(@"Need your permission to access photo albumbs", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:dismissAction];
        [alertController addAction:settingsAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self presentPicker];
                }
            });
        }];

    }
}

-(void)presentPicker{
    UINavigationController *imagePickerNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAImagePickerController"];
    [self presentViewController:imagePickerNav animated:YES completion:nil];
}

@end
