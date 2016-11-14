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
@property (nonatomic, weak) PHImageManager *imageManager;
@property (nonatomic, assign) PHImageRequestID imageRequestID;
@property (nonatomic, strong) UIImage *thumbnailImage;

@end

@implementation WIAImagePickerCollectionViewCell

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

@end
