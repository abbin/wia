//
//  WIATagTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 20/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIATagTableViewCell.h"
#import "TLTagsControl.h"

@interface WIATagTableViewCell ()

@property (weak, nonatomic) IBOutlet TLTagsControl *tagView;

@end

@implementation WIATagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagView.tagPlaceholder = @"type here";
    self.tagView.tagsBackgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
