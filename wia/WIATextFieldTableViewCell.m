//
//  WIATextFieldTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIATextFieldTableViewCell.h"

@interface WIATextFieldTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;

@end

@implementation WIATextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.cellTextField.inputAccessoryView = nil;
    self.cellImageView.image = nil;
    self.cellTextField.placeholder = nil;
    self.cellTextField.text = nil;
    self.cellTextField.keyboardType = UIKeyboardTypeDefault;
    self.cellTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellAutocorrectionType:(UITextAutocorrectionType)cellAutocorrectionType{
    _cellTextField.autocorrectionType = cellAutocorrectionType;
}

-(void)setCellKeyBoardType:(UIKeyboardType)cellKeyBoardType{
    _cellTextField.keyboardType = cellKeyBoardType;
}

-(void)setCellInputAccessoryView:(UICollectionView *)cellInputAccessoryView{
    _cellTextField.inputAccessoryView = cellInputAccessoryView;
}

-(void)setCellPlaceHolder:(NSString *)cellPlaceHolder{
    _cellTextField.placeholder = cellPlaceHolder;
}

-(void)setCellImage:(UIImage *)cellImage{
    _cellImageView.image = cellImage;
}

-(void)setCellText:(NSString *)cellText{
    _cellTextField.text = cellText;
}

-(NSString *)cellText{
    return _cellTextField.text;
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    if ([self.delegate respondsToSelector:@selector(WIATextFieldTableViewCellEditingChanged:withIndexPath:)]) {
        [self.delegate WIATextFieldTableViewCellEditingChanged:self.cellTextField withIndexPath:self.cellIndexPath];
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(WIATextFieldTableViewCellShouldBeginEditing:withIndexPath:)]) {
        return [self.delegate WIATextFieldTableViewCellShouldBeginEditing:self.cellTextField withIndexPath:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(WIATextFieldTableViewCellDidBeginEditing:withIndexPath:)]) {
        [self.delegate WIATextFieldTableViewCellDidBeginEditing:self.cellTextField withIndexPath:self.cellIndexPath];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(WIATextFieldTableViewCell:shouldChangeCharactersInRange:replacementString:withIndexPath:)]) {
        return [self.delegate WIATextFieldTableViewCell:self.cellTextField shouldChangeCharactersInRange:range replacementString:string withIndexPath:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(WIATextFieldTableViewCellDidEndEditing:withIndexPath:)]) {
        [self.delegate WIATextFieldTableViewCellDidEndEditing:self.cellTextField withIndexPath:self.cellIndexPath];
    }
}

@end
