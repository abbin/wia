//
//  WIACreateItemViewController.h
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIAManager.h"

@class WIACreateItemViewController;

@protocol WIACreateItemViewControllerDelegate <NSObject>

-(void)WIACreateItemViewController:(WIACreateItemViewController*)controller didFinishWithRecord:(CKRecord*)record;

@end


@interface WIACreateItemViewController : UITableViewController

@property (strong, nonatomic) NSString *itemName;

@property (weak, nonatomic) id <WIACreateItemViewControllerDelegate> delegate;

@end
