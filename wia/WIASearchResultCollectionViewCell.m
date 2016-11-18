//
//  WIASearchResultCollectionViewCell.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIASearchResultCollectionViewCell.h"

@interface WIASearchResultCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *celldetailTextLabel;

@end

@implementation WIASearchResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self prepareForReuse];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.cellTextLabel.text = @"";
    self.celldetailTextLabel.text = @"";
}

-(void)setCellText:(NSString *)cellText{
    _cellTextLabel.text = cellText;
}

-(void)setCellDetailText:(NSString *)cellDetailText{
    _celldetailTextLabel.text = cellDetailText;
}

@end
