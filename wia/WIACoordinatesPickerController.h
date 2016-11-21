//
//  WIACoordinatesPickerController.h
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@class WIACoordinatesPickerController;

@protocol WIACoordinatesPickerControllerDelegate <NSObject>

- (void) WIACoordinatesPickerController:(WIACoordinatesPickerController*)picker didFinishWithCoordinates:(CLLocationCoordinate2D)coordinates;

@end

@interface WIACoordinatesPickerController : UIViewController

@property (weak, nonatomic) id <WIACoordinatesPickerControllerDelegate> delegate;

@end
