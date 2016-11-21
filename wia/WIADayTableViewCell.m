//
//  WIADayTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIADayTableViewCell.h"

@interface WIADayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cellDayLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@end

@implementation WIADayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(dayTableViewCell:didChangeStatus:withIndexPath:)]) {
        [self.delegate dayTableViewCell:self didChangeStatus:sender.isOn withIndexPath:self.cellIndexPath];
    }
}

- (void)setCellIsOn:(BOOL)cellIsOn{
    _cellIsOn = cellIsOn;
    [_cellSwitch setOn:cellIsOn];
}

-(void)setCellText:(NSString *)cellText{
    _cellDayLabel.text = cellText;
}

@end
