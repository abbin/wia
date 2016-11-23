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
#import <PINCache.h>
#import "WIAConstants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PINCache *userCache = [[PINCache alloc]initWithName:kWIARecordTypeUserProfile];
    self.title = [userCache objectForKey:kWIAUserLocationName];
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)initializeImagePicker:(id)sender {
    [self presentWIAImagePickerController];
}

@end
