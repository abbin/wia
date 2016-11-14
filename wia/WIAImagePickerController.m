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

static const CGFloat WIAPhotoFetchScaleResizingRatio = 0.75;

@interface WIAImagePickerController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic, strong) NSArray *collectionItems;
@property (nonatomic, strong) NSDictionary *currentCollectionItem;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, assign) NSUInteger WIANumberOfPhotoColumns;
@property (nonatomic, assign) CGSize cellPortraitSize;

@property (nonatomic, weak) IBOutlet UICollectionView *photoCollectionView;

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)cancelPicker:(id)sender {
    
}

- (IBAction)donePickingImages:(id)sender {
    
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
    });
    
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
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utility Methods

- (void)setupCellSize{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.photoCollectionView.collectionViewLayout;
    
    CGFloat arrangementLength = MIN(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    CGFloat minimumInteritemSpacing = layout.minimumInteritemSpacing;
    UIEdgeInsets sectionInset = layout.sectionInset;
    
    CGFloat totalInteritemSpacing = MAX((self.WIANumberOfPhotoColumns - 1), 0) * minimumInteritemSpacing;
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
