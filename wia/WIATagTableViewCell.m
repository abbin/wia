//
//  WIATagTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 20/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIATagTableViewCell.h"

@interface WIATagTableViewCell ()

@property (weak, nonatomic) IBOutlet TLTagsControl *tagView;

@end

@implementation WIATagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagView.tagsBackgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTapDelegate:(id<TLTagsControlDelegate>)tapDelegate{
    _tagView.tapDelegate = tapDelegate;
}

-(void)setCellIndexPath:(NSIndexPath *)cellIndexPath{
    _tagView.tagIndexPath = cellIndexPath;
}

-(void)setCellPlaceHolder:(NSString *)cellPlaceHolder{
    _tagView.tagPlaceholder = cellPlaceHolder;
}

-(void)setCellTags:(NSArray *)cellTags{
    _tagView.tags = [cellTags mutableCopy];
    [_tagView reloadTagSubviews];
}

@end
