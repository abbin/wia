//
//  WIAImagePickerController.m
//  wia
//
//  Created by Abbin Varghese on 14/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAImagePickerController.h"
#import <Photos/Photos.h>
#import "WIAImagePickerCollectionViewCell.h"
#import "WIAImagePickerPreviewViewController.h"

static const CGFloat WIAPhotoFetchScaleResizingRatio = 0.75;

@interface WIAImagePickerController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic, strong) NSArray *collectionItems;
@property (nonatomic, strong) NSDictionary *currentCollectionItem;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, assign) NSUInteger WIANumberOfPhotoColumns;
@property (nonatomic, assign) CGSize cellPortraitSize;

@property (nonatomic, weak) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end

@implementation WIAImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.WIANumberOfPhotoColumns = 3;
        self.imageManager = [[PHCachingImageManager alloc] init];
        self.selectedPhotos = [NSMutableArray array];
        [self fetchCollections];
        [self updateViewWithCollectionItem:[self.collectionItems firstObject]];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)cancelPicker:(id)sender {
    
}

- (IBAction)donePickingImages:(id)sender {
    
}

- (IBAction)presentSinglePhoto:(id)sender{
    if ([sender isKindOfClass:[UILongPressGestureRecognizer class]]) {
        UILongPressGestureRecognizer *gesture = sender;
        if (gesture.state != UIGestureRecognizerStateBegan) {
            return;
        }
        WIAImagePickerCollectionViewCell *cell = (WIAImagePickerCollectionViewCell *)gesture.view;
        NSIndexPath *indexPath = [self.photoCollectionView indexPathForCell:cell];
        PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
        PHAsset *asset = fetchResult[indexPath.item];
        
        [UIView animateWithDuration:0.1 animations:^{
            cell.transform = CGAffineTransformMakeScale(0.95, 0.95);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                cell.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                WIAImagePickerPreviewViewController *presentedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WIAImagePickerPreviewViewController"];
                presentedViewController.currentAsset = asset;
                presentedViewController.imageManager = self.imageManager;
                [self presentViewController:presentedViewController animated:YES completion:nil];
            }];
        }];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
    return fetchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WIAImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WIAImagePickerCollectionViewCell" forIndexPath:indexPath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
        PHAsset *asset = fetchResult[indexPath.item];
        cell.representedAssetIdentifier = asset.localIdentifier;
        CGFloat scale = [UIScreen mainScreen].scale * WIAPhotoFetchScaleResizingRatio;
        CGSize imageSize = CGSizeMake(CGRectGetWidth(cell.frame) * scale, CGRectGetHeight(cell.frame) * scale);
        [cell loadPhotoWithManager:self.imageManager forAsset:asset targetSize:imageSize];
        [cell.longPressGestureRecognizer addTarget:self action:@selector(presentSinglePhoto:)];
    });
    
    PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
    PHAsset *asset = fetchResult[indexPath.item];
    
    if ([self.selectedPhotos containsObject:asset]) {
        [cell selectCell];
    }
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (CGSizeEqualToSize(CGSizeZero, self.cellPortraitSize)) {
        [self setupCellSize];
    }
    return self.cellPortraitSize;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WIAImagePickerCollectionViewCell class]]) {
        [(WIAImagePickerCollectionViewCell *)cell highlightCell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WIAImagePickerCollectionViewCell class]]) {
        [(WIAImagePickerCollectionViewCell *)cell unHighlightCell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
    PHAsset *asset = fetchResult[indexPath.item];
    if ([self.selectedPhotos containsObject:asset]) {
        [self.selectedPhotos removeObject:asset];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[WIAImagePickerCollectionViewCell class]]) {
            [(WIAImagePickerCollectionViewCell *)cell deSelectCell];
        }
    }
    else{
        [self.selectedPhotos addObject:asset];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[WIAImagePickerCollectionViewCell class]]) {
            [(WIAImagePickerCollectionViewCell *)cell selectCell];
        }
    }
    if (self.selectedPhotos.count>0) {
        self.doneItem.enabled = YES;
    }
    else{
        self.doneItem.enabled = NO;
    }
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
    PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:fetchResult];
    if (collectionChanges == nil) {
        [self fetchCollections];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        PHFetchResult *fetchResult = [collectionChanges fetchResultAfterChanges];
        NSInteger index = [self.collectionItems indexOfObject:self.currentCollectionItem];
        self.currentCollectionItem = @{
                                       @"assets": fetchResult,
                                       @"collection": self.currentCollectionItem[@"collection"]
                                       };
        if (index != NSNotFound) {
            NSMutableArray *updatedCollectionItems = [self.collectionItems mutableCopy];
            [updatedCollectionItems replaceObjectAtIndex:index withObject:self.currentCollectionItem];
            self.collectionItems = [updatedCollectionItems copy];
        }
        UICollectionView *collectionView = self.photoCollectionView;
        
        if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]
            || ([collectionChanges removedIndexes].count > 0
                && [collectionChanges changedIndexes].count > 0)) {
                [collectionView reloadData];
            }
        else {
            [collectionView performBatchUpdates:^{
                
                NSIndexSet *removedIndexes = [collectionChanges removedIndexes];
                NSMutableArray *removeIndexPaths = [NSMutableArray arrayWithCapacity:removedIndexes.count];
                [removedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    [removeIndexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                }];
                if ([removedIndexes count] > 0) {
                    [collectionView deleteItemsAtIndexPaths:removeIndexPaths];
                }
                NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
                NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:insertedIndexes.count];
                [insertedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    [insertIndexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                }];
                if ([insertedIndexes count] > 0) {
                    [collectionView insertItemsAtIndexPaths:insertIndexPaths];
                }
                
                NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
                NSMutableArray *changedIndexPaths = [NSMutableArray arrayWithCapacity:changedIndexes.count];
                [changedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
                    if (![removeIndexPaths containsObject:indexPath]) {
                        [changedIndexPaths addObject:indexPath];
                    }
                }];
                if ([changedIndexes count] > 0) {
                    [collectionView reloadItemsAtIndexPaths:changedIndexPaths];
                }
            } completion:^(BOOL finished) {
                [self refreshPhotoSelection];
            }];
        }
    });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utility Methods

- (UIImage *)yms_orientationNormalizedImage:(UIImage *)image{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)setupCellSize{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.photoCollectionView.collectionViewLayout;
    
    CGFloat arrangementLength = MIN(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    CGFloat minimumInteritemSpacing = layout.minimumInteritemSpacing;
    UIEdgeInsets sectionInset = layout.sectionInset;
    
    CGFloat totalInteritemSpacing = MAX((self.WIANumberOfPhotoColumns), 0) * minimumInteritemSpacing;
    CGFloat totalHorizontalSpacing = totalInteritemSpacing + sectionInset.left + sectionInset.right;
    
    CGFloat size = (CGFloat)floor((arrangementLength - totalHorizontalSpacing) / self.WIANumberOfPhotoColumns);
    self.cellPortraitSize = CGSizeMake(size, size);
}

- (void)updateViewWithCollectionItem:(NSDictionary *)collectionItem{
    self.currentCollectionItem = collectionItem;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.photoCollectionView reloadData];
        [self refreshPhotoSelection];
    });
}

- (void)refreshPhotoSelection{
    PHFetchResult *fetchResult = self.currentCollectionItem[@"assets"];
    for (int i=0; i<fetchResult.count; i++) {
        PHAsset *asset = [fetchResult objectAtIndex:i];
        if ([self.selectedPhotos containsObject:asset]) {
            [self.photoCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
}

- (void)fetchCollections{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    NSMutableArray *allAblums = [NSMutableArray array];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    __block __weak void (^weakFetchAlbums)(PHFetchResult *collections);
    void (^fetchAlbums)(PHFetchResult *collections);
    weakFetchAlbums = fetchAlbums = ^void(PHFetchResult *collections){
        PHFetchOptions *options = [PHFetchOptions new];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        for (PHCollection *collection in collections) {
            if ([collection isKindOfClass:[PHAssetCollection class]]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
                if (assetsFetchResult.count > 0) {
                    [allAblums addObject:@{@"collection": assetCollection
                                           , @"assets": assetsFetchResult}];
                }
            }
            else if ([collection isKindOfClass:[PHCollectionList class]]) {
                PHCollectionList *collectionList = (PHCollectionList *)collection;
                PHFetchResult *fetchResult = [PHCollectionList fetchCollectionsInCollectionList:(PHCollectionList *)collectionList options:nil];
                weakFetchAlbums(fetchResult);
            }
        }
    };
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    fetchAlbums(topLevelUserCollections);
    
    for (PHAssetCollection *collection in smartAlbums) {
        PHFetchOptions *options = [PHFetchOptions new];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        if (assetsFetchResult.count > 0) {
            
            if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                [allAblums insertObject:@{@"collection": collection
                                          , @"assets": assetsFetchResult} atIndex:0];
            }
            else {
                [allAblums addObject:@{@"collection": collection
                                       , @"assets": assetsFetchResult}];
            }
        }
    }
    self.collectionItems = [allAblums copy];
}

@end
