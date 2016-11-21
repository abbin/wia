//
//  WIADaysPickerController.h
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WIADaysPickerController;

@protocol WIADaysPickerControllerDelegate <NSObject>

- (void)WIADaysPickerController:(WIADaysPickerController*)picker didFinishWithdays:(NSArray*)daysArray;

@end


@interface WIADaysPickerController : UIViewController

@property (strong, nonatomic) NSMutableArray *workingDaysArray;

@property (weak, nonatomic) id <WIADaysPickerControllerDelegate> delegate;

@end
