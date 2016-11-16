//
//  WIANameViewController.m
//  wia
//
//  Created by Abbin Varghese on 16/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIANameViewController.h"
#import "WIALocationViewController.h"

@interface WIANameViewController ()

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@end

@implementation WIANameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.inputAccessoryView = self.toolBar;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nameTextField resignFirstResponder];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WIALocationViewControllerSegue"]) {
        WIALocationViewController *vc = segue.destinationViewController;
        vc.userName = self.nameTextField.text;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)nameTextFieldDidChangeEditing:(UITextField *)sender {
    if (sender.text.length>0) {
        self.nextItem.enabled = YES;
    }
    else{
        self.nextItem.enabled = NO;
    }
}

@end
