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
#import "WIAConstants.h"

typedef NS_ENUM(NSInteger, WIAItemDetailTableViewSection) {
    WIAItemDetailTablewViewSectionName = 0,
    WIAItemDetailTablewViewSectionPrice,
    WIAItemDetailTablewViewSectionCusine,
    WIAItemDetailTablewViewSectionDescription
};

@interface WIACreateItemViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WIATextFieldTableViewCellDelegate,WIATextViewTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *cuisineSearchResults;
@property (strong, nonatomic) UICollectionView *cuisineSearchResultCollectionView;

@property (strong, nonatomic) NSNumber *itemPrice;
@property (strong, nonatomic) CKRecord *itemCuisine;
@property (strong, nonatomic) NSString *itemDescription;

@end

@implementation WIACreateItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextViewTableViewCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.frame];
    imageView.image = [UIImage imageNamed:@"FirstLaunchBackground"];
    imageView.alpha  = 0.5;
    self.tableView.backgroundView = imageView;
    
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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(createRecord:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (void)createRecord:(id)sender{
    if (self.itemName.length>0 && self.itemPrice>0 && self.itemCuisine != nil) {
        CKRecord *itemRecord = [[CKRecord alloc] initWithRecordType:kWIARecordTypeItem];
        itemRecord[kWIAItemName ] = self.itemName;
        itemRecord[kWIAItemPrice] = self.itemPrice;
        
        CKReference *cuisineReference = [[CKReference alloc] initWithRecord:self.itemCuisine action:CKReferenceActionNone];
        
        itemRecord[kWIAItemCuisine] = cuisineReference;
        
        if (self.itemDescription.length>0){
            itemRecord[kWIAItemDescription] = self.itemDescription;
        }
        else{
            itemRecord[kWIAItemDescription] = @"";
        }
        if ([self.delegate respondsToSelector:@selector(WIACreateItemViewController:didFinishWithRecord:)]) {
            [self.delegate WIACreateItemViewController:self didFinishWithRecord:itemRecord];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
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
        cell.delegate = self;
        return cell;
    }
    else{
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        
        if (indexPath.section == WIAItemDetailTablewViewSectionName) {
            cell.cellPlaceHolder = @"type here";
            cell.cellText = self.itemName;
        }
        else if (indexPath.section == WIAItemDetailTablewViewSectionPrice){
            cell.cellPlaceHolder = @"type here";
            cell.cellKeyBoardType = UIKeyboardTypeDecimalPad;
        }
        else{
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
        return @"Description (Optional)";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionDescription) {
        return 100;
    }
    else{
        return 44;
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
        CKRecord *cuisine = self.cuisineSearchResults[indexPath.row];
        cell.cellText = cuisine[kWIACuisineName];
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
        NSString *cuisineName = self.cuisineSearchResults[indexPath.row];
        if (![cuisineName isEqualToString:@"Start typing..."]) {
            CKRecordID *cusineRecordID = [[CKRecordID alloc] initWithRecordName:cuisineName];
            CKRecord *cusineRecord = [[CKRecord alloc] initWithRecordType:kWIARecordTypeCuisine recordID:cusineRecordID];
            cusineRecord[kWIACuisineName] = cuisineName;
            self.itemCuisine = cusineRecord;
            [self.tableView endEditing:YES];
        }
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
    else if (indexPath.section == WIAItemDetailTablewViewSectionCusine){
        if (self.itemCuisine == nil) {
            textField.text = @"";
        }
        else{
            textField.text = self.itemCuisine[kWIACuisineName];
        }
    }
}

-(void)WIATextFieldTableViewCellEditingChanged:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIAItemDetailTablewViewSectionCusine) {
        if (textField.text.length>0) {
            NSString *searchText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [WIAManager searchForCuisineWith:searchText completionHandler:^(NSMutableArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
                if (results.count>0) {
                    self.cuisineSearchResults = results;
                }
                else{
                    [self.cuisineSearchResults removeAllObjects];
                    [self.cuisineSearchResults addObject:searchText];
                }
                [self.cuisineSearchResultCollectionView reloadData];
            }];
        }
        else{
            [self.cuisineSearchResults removeAllObjects];
            [self.cuisineSearchResults addObject:@"Start typing..."];
            [self.cuisineSearchResultCollectionView reloadData];
        }
    }
    else if (indexPath.section == WIAItemDetailTablewViewSectionPrice){
        NSString *priceString = [textField.text substringFromIndex:1];
        NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
        NSNumber *priceNum = [format numberFromString:priceString];
        self.itemPrice = priceNum;
    }
    else if (indexPath.section == WIAItemDetailTablewViewSectionName){
        NSString *itemNameString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.itemName = itemNameString;
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextViewTableViewCellDelegate

-(void)WIATextViewTableViewCellDidChange:(UITextView *)textView{
    self.itemDescription = textView.text;
    NSLog(@"%@",self.itemDescription);
}

@end
