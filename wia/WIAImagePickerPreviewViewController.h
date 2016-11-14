//
//  WIAImagePickerPreviewViewController.h
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface WIAImagePickerPreviewViewController : UIViewController

@property (nonatomic, strong) PHAsset *currentAsset;
@property (nonatomic, weak) PHImageManager *imageManager;

@end
