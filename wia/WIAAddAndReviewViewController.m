//
//  WIAAddAndReviewViewController.m
//  wia
//
//  Created by Abbin Varghese on 15/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAAddAndReviewViewController.h"

@interface WIAAddAndReviewViewController ()

@end

@implementation WIAAddAndReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)WIAImagePickerController:(WIAImagePickerController *)picker didFinishPickingImages:(NSArray *)images animated:(BOOL)animated{
    self.view.alpha = 1;
    self.navigationController.navigationBarHidden = NO;
    [picker dismissViewControllerAnimated:animated completion:^{
        
    }];
}

-(void)WIAImagePickerControllerDidCancel:(WIAImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
