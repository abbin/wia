//
//  WIATextFieldTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WIATextFieldTableViewCell;

@protocol WIATextFieldTableViewCellDelegate <NSObject>

-(BOOL)WIATextFieldTableViewCellShouldBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath*)indexPath;

@end

@interface WIATextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (strong, nonatomic) NSString *cellText;
@property (strong, nonatomic) NSString *cellPlaceHolder;
@property (strong, nonatomic) UIImage *cellImage;

@property (weak, nonatomic) id <WIATextFieldTableViewCellDelegate> delegate;

@end
