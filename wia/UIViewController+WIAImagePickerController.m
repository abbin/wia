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
#import "WIAAddAndReviewViewController.h"

@implementation UIViewController (WIAImagePickerController)

-(void)presentWIAImagePickerController{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized){
        [self launchPicker];
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
                    [self launchPicker];
                }
            });
        }];

    }
}

-(void)presentWIACameraControllerWithDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)delegate{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized){
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = delegate;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else if(status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow camera access?", nil) message:NSLocalizedString(@"Need your permission to take a photo", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            [alertController addAction:dismissAction];
            [alertController addAction:settingsAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if(status == AVAuthorizationStatusNotDetermined){
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^() {
                    if(granted){
                        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                        imagePickerController.delegate = delegate;
                        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:imagePickerController animated:YES completion:nil];
                    }
                });
            }];
        }
    }
}

-(void)launchPicker{
    UINavigationController *addNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAAddAndReviewViewController"];
    addNav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    addNav.navigationBarHidden = YES;
    WIAAddAndReviewViewController *addVc = [addNav.viewControllers firstObject];
    addVc.view.alpha = 0;
    
    [self presentViewController:addNav animated:NO completion:^{
        UINavigationController *imagePickerNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAImagePickerController"];
        imagePickerNav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        WIAImagePickerController *vc = [imagePickerNav.viewControllers firstObject];
        vc.delegate = addVc;
        [addVc presentViewController:imagePickerNav animated:YES completion:nil];
    }];
}

@end
