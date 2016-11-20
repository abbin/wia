//
//  WIADualTextFieldTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 20/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WIADualTextFieldTableViewCellDelegate <NSObject>

- (void)WIADualTextFieldTableViewCellTextFieldOneDidChangeEditing:(NSString*)string;
- (void)WIADualTextFieldTableViewCellTextFieldTwoDidChangeEditing:(NSString*)string;

@end

@interface WIADualTextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *cellPlaceHolderOne;
@property (strong, nonatomic) NSString *cellPlaceHolderTwo;

@property (strong, nonatomic) UIView *cellInputViewOne;
@property (strong, nonatomic) UIView *cellInputViewTwo;


@property id <WIADualTextFieldTableViewCellDelegate> delegate;

@end
