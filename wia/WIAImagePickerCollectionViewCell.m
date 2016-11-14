//
//  WIAImagePickerCollectionViewCell.m
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAImagePickerCollectionViewCell.h"

@interface WIAImagePickerCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UIView *cellSelectionView;
@property (weak, nonatomic) IBOutlet UIView *cellHighlightView;
@property (weak, nonatomic) IBOutlet UIImageView *cellSelectionImageview;

@property (nonatomic, weak) PHImageManager *imageManager;
@property (nonatomic, assign) PHImageRequestID imageRequestID;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, assign) CGFloat selectionAlpha;

@end

@implementation WIAImagePickerCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self prepareForReuse];
    self.selectionAlpha = 0.5;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.cellSelectionView.alpha = 0;
    self.cellHighlightView.alpha = 0;
    self.cellSelectionImageview.alpha = 0;
    [self deSelectCell];
}

- (void)loadPhotoWithManager:(PHImageManager *)manager forAsset:(PHAsset *)asset targetSize:(CGSize)size{
    self.imageManager = manager;
    self.imageRequestID = [self.imageManager requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:nil
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        // Set the cell's thumbnail image if it's still showing the same asset.
                                                        if ([self.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                                            self.thumbnailImage = result;
                                                        }
                                                    }];
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage{
    _thumbnailImage = thumbnailImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cellImageView.image = thumbnailImage;
    });
}

- (void)selectCell{
    self.cellSelectionView.alpha = self.selectionAlpha;
    self.cellSelectionImageview.alpha = 1;
}

- (void)deSelectCell{
    self.cellSelectionView.alpha = 0;
    self.cellSelectionImageview.alpha = 0;
}

- (void)highlightCell{
    self.cellHighlightView.alpha = self.selectionAlpha;
}

- (void)unHighlightCell{
    self.cellHighlightView.alpha = 0;
}

@end
