//
//  WIAImagePickerCollectionViewCell.h
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface WIAImagePickerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *representedAssetIdentifier;

- (void)loadPhotoWithManager:(PHImageManager *)manager forAsset:(PHAsset *)asset targetSize:(CGSize)size;

- (void)selectCell;

- (void)deSelectCell;

- (void)highlightCell;

- (void)unHighlightCell;

@end
