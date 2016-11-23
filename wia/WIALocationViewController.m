//
//  WIALocationViewController.m
//  wia
//
//  Created by Abbin Varghese on 16/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIALocationViewController.h"
#import "WIAColor.h"
#import <CoreLocation/CoreLocation.h>
#import "WIAAccountSetUpViewController.h"
#import <PINCache.h>
#import "WIAConstants.h"

@interface WIALocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *autodetectButoon;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstupdateOver;

@end

@implementation WIALocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autodetectButoon.backgroundColor = [WIAColor mainColor];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)autoDectectLocation:(id)sender {
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)setLocationManually:(id)sender {
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationManager stopUpdatingLocation];
    if (!self.isFirstupdateOver) {
        self.isFirstupdateOver = YES;
        WIAAccountSetUpViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAAccountSetUpViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
