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
        NSLog(@"%@",images);
    }];
}

-(void)WIAImagePickerControllerDidCancel:(WIAImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (IBAction)saveUpload:(id)sender {
    
}

- (IBAction)cancelUpload:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"The photos you selected have not finished uploading" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [actionSheet addAction:yes];
    [actionSheet addAction:cancel];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
