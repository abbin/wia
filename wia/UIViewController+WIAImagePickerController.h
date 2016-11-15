//
//  UIViewController+WIAImagePickerController.h
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIAImagePickerController.h"

@interface UIViewController (WIAImagePickerController)

-(void)presentWIAImagePickerControllerWithDelegate:(id<WIAImagePickerControllerDelegate>)delegate;
-(void)presentWIACameraControllerWithDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)delegate;

@end
