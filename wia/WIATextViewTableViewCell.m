//
//  WIATextViewTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIATextViewTableViewCell.h"

@interface WIATextViewTableViewCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *cellTextView;

@end

@implementation WIATextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(WIATextViewTableViewCellDidChange:)]) {
        [self.delegate WIATextViewTableViewCellDidChange:self.cellTextView];
    }
}

@end
