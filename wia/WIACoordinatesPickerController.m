//
//  WIACoordinatesPickerController.m
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIACoordinatesPickerController.h"

@interface WIACoordinatesPickerController ()

@end

@implementation WIACoordinatesPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePicking:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
