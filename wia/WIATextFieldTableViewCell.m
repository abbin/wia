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
    self.cellImageView.image = nil;
    self.cellTextField.placeholder = nil;
    self.cellTextField.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
