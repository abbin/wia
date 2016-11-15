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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)initializeImagePicker:(id)sender { 
    UINavigationController *addNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAAddAndReviewViewController"];
    addNav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    addNav.navigationBarHidden = YES;
    WIAAddAndReviewViewController *addVc = [addNav.viewControllers firstObject];
    addVc.view.alpha = 0;
    [self presentViewController:addNav animated:NO completion:^{
        [addVc presentPickerWithDelegate:addVc];
    }];
}

@end
