//
//  WIACreateItemViewController.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIACreateItemViewController.h"
#import "WIATextFieldTableViewCell.h"
#import "WIATextViewTableViewCell.h"
#import "WIAColor.h"
#import "WIASearchResultCollectionViewCell.h"
#import "WIAManager.h"

typedef NS_ENUM(NSInteger, WIAItemDetailTablewViewSection) {
    WIAItemDetailTablewViewSectionName = 0,
    WIAItemDetailTablewViewSectionPrice,
    WIAItemDetailTablewViewSectionCusine,
    WIAItemDetailTablewViewSectionDescription
};

@interface WIACreateItemViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WIATextFieldTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *cuisineSearchResults;
@property (nonatomic, strong) UICollectionView *cuisineSearchResultCollectionView;

@end

@implementation WIACreateItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextViewTableViewCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.estimatedItemSize = CGSizeMake(self.view.frame.size.width, 44);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.cuisineSearchResultCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) collectionViewLayout:flowLayout];
    self.cuisineSearchResultCollectionView.delegate = self;
    self.cuisineSearchResultCollectionView.dataSource = self;
    self.cuisineSearchResultCollectionView.backgroundColor = [WIAColor keyBoardColor];
    self.cuisineSearchResultCollectionView.showsHorizontalScrollIndicator = NO;
    [self.cuisineSearchResultCollectionView registerNib:[UINib nibWithNibName:@"WIASearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WIASearchResultCollectionViewCell"];
    
    self.cuisineSearchResults = [NSMutableArray arrayWithObject:@"Start typing..."];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionDescription) {
        WIATextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextViewTableViewCell"];
        return cell;
    }
    else{
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        
        if (indexPath.section == WIAItemDetailTablewViewSectionName) {
            cell.cellImage = [UIImage imageNamed:@"Burger"];
            cell.cellPlaceHolder = @"name of the item";
        }
        else if (indexPath.section == WIAItemDetailTablewViewSectionPrice){
            cell.cellImage = [UIImage imageNamed:@"PriceTag"];
            cell.cellPlaceHolder = @"price of the item";
            cell.cellKeyBoardType = UIKeyboardTypeDecimalPad;
        }
        else{
            cell.cellImage = [UIImage imageNamed:@"ChopSticks"];
            cell.cellPlaceHolder = @"e.g. Chinese, Italian";
            cell.cellAutocorrectionType = UITextAutocorrectionTypeNo;
            cell.cellInputAccessoryView = self.cuisineSearchResultCollectionView;
        }
        return cell;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == WIAItemDetailTablewViewSectionName) {
        return @"Item Name";
    }
    else if (section == WIAItemDetailTablewViewSectionPrice){
        return @"Price";
    }
    else if (section == WIAItemDetailTablewViewSectionCusine){
        return @"Cuisine";
    }
    else {
        return @"Description";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionDescription) {
        return 100;
    }
    else{
        return 50;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.cuisineSearchResults.count>0) {
        return self.cuisineSearchResults.count;
    }
    else{
        return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WIASearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WIASearchResultCollectionViewCell" forIndexPath:indexPath];
    
    if ([self.cuisineSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
        
    }
    else{
        if ([self.cuisineSearchResults[indexPath.row] isEqualToString:@"Start typing..."]) {
            cell.cellText =  self.cuisineSearchResults[indexPath.row];
        }
        else{
            cell.cellText =  [NSString stringWithFormat:@"Add '%@' as a new cuisine",self.cuisineSearchResults[indexPath.row]];
        }
    }
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cuisineSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
        
    }
    else{
        
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextFieldTableViewCellDelegate

-(void)WIATextFieldTableViewCellDidBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionPrice) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        }
    }
}

-(void)WIATextFieldTableViewCellDidEndEditing:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionPrice) {
        if ([textField.text isEqualToString:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]]) {
            textField.text = @"";
        }
    }
}

-(void)WIATextFieldTableViewCellEditingChanged:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionCusine) {
        if (textField.text.length>0) {
            NSString *searchText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [WIAManager searchForCuisineWith:searchText completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
                if (results.count>0) {
                    
                }
                else{
                    [self.cuisineSearchResults removeAllObjects];
                    [self.cuisineSearchResults addObject:searchText];
                }
            }];
        }
        else{
            [self.cuisineSearchResults removeAllObjects];
            [self.cuisineSearchResults addObject:@"Start typing..."];
        }
        [self.cuisineSearchResultCollectionView reloadData];
    }
}

-(BOOL)WIATextFieldTableViewCell:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionPrice) {
        if ((range.location == 0 && range.length == 1) || (range.location > 6 && range.length == 0)) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
}

@end
