//
//  WIACreateRestaurantViewController.h
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIAManager.h"

@class WIACreateRestaurantViewController;

@protocol WIACreateRestaurantViewControllerDelegate <NSObject>

- (void)WIACreateRestaurantViewController:(WIACreateRestaurantViewController*)controller didFinishWithRecord:(CKRecord*)record;

@end

@interface WIACreateRestaurantViewController : UITableViewController

@property (strong, nonatomic) NSString *restaurantName;

@property (weak, nonatomic) id <WIACreateRestaurantViewControllerDelegate> delegate;

@end
