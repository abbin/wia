//
//  WIAImagePickerController.h
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WIAImagePickerController;

@protocol WIAImagePickerControllerDelegate <NSObject>

- (void)WIAImagePickerController:(WIAImagePickerController*) picker didFinishPickingImages:(NSArray*)images animated:(BOOL)animated;
- (void)WIAImagePickerControllerDidCancel:(WIAImagePickerController*) picker;

@end


@interface WIAImagePickerController : UIViewController

@property (weak, nonatomic) id <WIAImagePickerControllerDelegate> delegate;

@end
