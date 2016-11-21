//
//  WIACoordinatesPickerController.m
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIACoordinatesPickerController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface WIACoordinatesPickerController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *pinHeadImageView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstUpdateFinished;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation WIACoordinatesPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.pinHeadImageView.image = [self.pinHeadImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)cancelPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePicking:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)goTocurrentLocation:(id)sender {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                            longitude:self.currentLocation.coordinate.longitude
                                                                 zoom:15];
    [self.mapView animateToCameraPosition:camera];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (!self.firstUpdateFinished) {
        self.currentLocation = [locations lastObject];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                                longitude:self.currentLocation.coordinate.longitude
                                                                     zoom:15];
        [self.mapView animateToCameraPosition:camera];
    }
    [self.locationManager stopUpdatingLocation];
}

@end
