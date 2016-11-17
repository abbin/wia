//
//  WIACollectionViewTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIACollectionViewTableViewCell.h"
#import "WIAImageCollectionViewCell.h"

@interface WIACollectionViewTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *cellCollectionView;

@end

@implementation WIACollectionViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cellCollectionView registerNib:[UINib nibWithNibName:@"WIAImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WIAImageCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WIAImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WIAImageCollectionViewCell" forIndexPath:indexPath];
    cell.cellImage = self.cellImages[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = [self.cellImages objectAtIndex:indexPath.row];
    return CGSizeMake(collectionView.frame.size.height*image.size.width/image.size.height, collectionView.frame.size.height);
}

-(void)setCellImages:(NSArray *)cellImages{
    _cellImages = cellImages;
    [self.cellCollectionView reloadData];
}

@end
