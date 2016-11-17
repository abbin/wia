//
//  WIAImageCollectionViewCell.m
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAImageCollectionViewCell.h"

@interface WIAImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation WIAImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellImage:(UIImage *)cellImage{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        UICollectionView *collectionView = (UICollectionView*)self.contentView.superview;
        CGSize newSize = CGSizeMake(collectionView.frame.size.height*cellImage.size.width/cellImage.size.height, collectionView.frame.size.height);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
        [cellImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            _cellImageView.image = newImage;
        });
    });
}

@end
