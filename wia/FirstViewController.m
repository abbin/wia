//
//  FirstViewController.m
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+WIAImagePickerController.m"
#import "WIAAddAndReviewViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)initializeImagePicker:(id)sender {
    [self presentWIAImagePickerController];
}

@end
