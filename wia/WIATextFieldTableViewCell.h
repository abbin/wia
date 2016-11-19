//
//  WIATextFieldTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WIATextFieldTableViewCellDelegate <NSObject>

@optional

- (BOOL)WIATextFieldTableViewCellShouldBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath*)indexPath;
- (void)WIATextFieldTableViewCellDidBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath*)indexPath;

- (void)WIATextFieldTableViewCellDidEndEditing:(UITextField *)textField withIndexPath:(NSIndexPath*)indexPath;

- (BOOL)WIATextFieldTableViewCell:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string withIndexPath:(NSIndexPath*)indexPath;
- (void)WIATextFieldTableViewCellEditingChanged:(UITextField *)textField withIndexPath:(NSIndexPath*)indexPath;

@end

@interface WIATextFieldTableViewCell : UITableViewCell

@property (assign, nonatomic) UITextAutocorrectionType cellAutocorrectionType;
@property (assign, nonatomic) UIKeyboardType cellKeyBoardType;
@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (strong, nonatomic) NSString *cellText;
@property (strong, nonatomic) NSString *cellPlaceHolder;
@property (strong, nonatomic) UIImage *cellImage;
@property (strong, nonatomic) UICollectionView *cellInputAccessoryView;

@property (weak, nonatomic) id <WIATextFieldTableViewCellDelegate> delegate;

@end
