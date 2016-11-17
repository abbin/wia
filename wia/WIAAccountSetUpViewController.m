//
//  WIAAccountSetUpViewController.m
//  wia
//
//  Created by Abbin Varghese on 16/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAAccountSetUpViewController.h"
#import "AppDelegate.h"

@interface WIAAccountSetUpViewController ()

@property (nonatomic, assign) BOOL shouldAnimate;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation WIAAccountSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldAnimate = YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.shouldAnimate) {
        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.logLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.logLabel.text = @"Doing more stuff...";
            if (self.shouldAnimate) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.logLabel.alpha = 1.0;
                } completion:^(BOOL finished) {
                    if (self.shouldAnimate) {
                        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.logLabel.alpha = 0.0;
                        } completion:^(BOOL finished) {
                            self.logLabel.text = @"Taking a break...";
                            if (self.shouldAnimate) {
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                    self.logLabel.alpha = 1.0;
                                } completion:^(BOOL finished) {
                                    if (self.shouldAnimate) {
                                        [UIView animateWithDuration:0.3 delay:5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                            self.logLabel.alpha = 0.0;
                                        } completion:^(BOOL finished) {
                                            self.logLabel.text = @"Back doing stuff...";
                                            if (self.shouldAnimate) {
                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                    self.logLabel.alpha = 1.0;
                                                } completion:^(BOOL finished) {
                                                    if (self.shouldAnimate) {
                                                        [UIView animateWithDuration:0.3 delay:4 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                            self.logLabel.alpha = 0.0;
                                                        } completion:^(BOOL finished) {
                                                            self.logLabel.text = @"This is taking too long...🤔";
                                                            if (self.shouldAnimate) {
                                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                    self.logLabel.alpha = 1.0;
                                                                } completion:^(BOOL finished) {
                                                                    if (self.shouldAnimate) {
                                                                        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                            self.logLabel.alpha = 0.0;
                                                                        } completion:^(BOOL finished) {
                                                                            self.logLabel.text = @"Ok, Finishing up...";
                                                                            if (self.shouldAnimate) {
                                                                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                                                                    self.logLabel.alpha = 1.0;
                                                                                } completion:^(BOOL finished) {
                                                                                    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                                                                    UITabBarController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WIATabBarController"];
                                                                                    [delegate switchRootViewControllerWith:controller];
                                                                                }];
                                                                            }
                                                                        }];
                                                                    }
                                                                }];
                                                            }
                                                        }];
                                                    }
                                                }];
                                            }
                                        }];
                                    }
                                }];
                            }
                        }];
                    }
                }];
            }
        }];
    }
}

@end
