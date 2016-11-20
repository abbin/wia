//
//  WIAAddAndReviewViewController.m
//  wia
//
//  Created by Abbin Varghese on 15/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAAddAndReviewViewController.h"
#import "WIATextFieldTableViewCell.h"
#import "WIARatingTableViewCell.h"
#import "WIACollectionViewTableViewCell.h"
#import "WIATextViewTableViewCell.h"
#import "WIASearchResultCollectionViewCell.h"
#import "WIAColor.h"
#import "WIAManager.h"
#import "WIACreateItemViewController.h"
#import "WIACreateRestaurantViewController.h"

typedef NS_ENUM(NSInteger, WIADetailTablewViewSection) {
    WIADetailTablewViewSectionImagePreview = 0,
    WIADetailTablewViewSectionItem,
    WIADetailTablewViewSectionRestaurant,
    WIADetailTablewViewSectionRating,
    WIADetailTablewViewSectionReview
};

@interface WIAAddAndReviewViewController ()<UITableViewDelegate,UITableViewDataSource,WIATextViewTableViewCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource,WIATextFieldTableViewCellDelegate>

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSMutableArray *itemSearchResults;
@property (strong, nonatomic) NSMutableArray *restaurantSearchResults;

@property (nonatomic, strong) UICollectionView *itemSearchResultCollectionView;
@property (nonatomic, strong) UICollectionView *restaurantSearchResultCollectionView;
@end

@implementation WIAAddAndReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemSearchResults = [NSMutableArray arrayWithObject:@"Start typing..."];
    self.restaurantSearchResults = [NSMutableArray arrayWithObject:@"Start typing..."];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.frame];
    imageView.image = [UIImage imageNamed:@"FirstLaunchBackground"];
    imageView.alpha  = 0.5;
    self.tableView.backgroundView = imageView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIARatingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIARatingTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIACollectionViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIACollectionViewTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextViewTableViewCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.estimatedItemSize = CGSizeMake(self.view.frame.size.width, 44);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.itemSearchResultCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) collectionViewLayout:flowLayout];
    self.itemSearchResultCollectionView.delegate = self;
    self.itemSearchResultCollectionView.dataSource = self;
    self.itemSearchResultCollectionView.backgroundColor = [WIAColor keyBoardColor];
    self.itemSearchResultCollectionView.showsHorizontalScrollIndicator = NO;
    [self.itemSearchResultCollectionView registerNib:[UINib nibWithNibName:@"WIASearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WIASearchResultCollectionViewCell"];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc]init];
    flowLayout2.estimatedItemSize = CGSizeMake(self.view.frame.size.width, 44);
    flowLayout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout2.minimumInteritemSpacing = 0;
    flowLayout2.minimumLineSpacing = 0;
    
    self.restaurantSearchResultCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) collectionViewLayout:flowLayout2];
    self.restaurantSearchResultCollectionView.delegate = self;
    self.restaurantSearchResultCollectionView.dataSource = self;
    self.restaurantSearchResultCollectionView.backgroundColor = [WIAColor keyBoardColor];
    self.restaurantSearchResultCollectionView.showsHorizontalScrollIndicator = NO;
    [self.restaurantSearchResultCollectionView registerNib:[UINib nibWithNibName:@"WIASearchResultCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WIASearchResultCollectionViewCell"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView endEditing:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (IBAction)saveUpload:(id)sender {
    
}

- (IBAction)cancelUpload:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"The photos you selected have not finished uploading" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [actionSheet addAction:yes];
    [actionSheet addAction:cancel];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIAImagePickerControllerDelegate

-(void)WIAImagePickerController:(WIAImagePickerController *)picker didFinishPickingImages:(NSArray *)images animated:(BOOL)animated{
    self.view.alpha = 1;
    self.navigationController.navigationBarHidden = NO;
    self.images = images;
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:animated completion:nil];
}

-(void)WIAImagePickerControllerDidCancel:(WIAImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIADetailTablewViewSectionRating) {
        WIARatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIARatingTableViewCell"];
        return cell;
    }
    else if (indexPath.section == WIADetailTablewViewSectionImagePreview){
        WIACollectionViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIACollectionViewTableViewCell"];
        cell.cellImages = self.images;
        return cell;
    }
    else if (indexPath.section == WIADetailTablewViewSectionReview){
        WIATextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextViewTableViewCell"];
        cell.delegate = self;
        return cell;
    }
    else{
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellIndexPath = indexPath;
        cell.delegate = self;
        cell.cellAutocorrectionType = UITextAutocorrectionTypeNo;
        
        if (indexPath.section == WIADetailTablewViewSectionItem) {
            cell.cellPlaceHolder = @"tag an item";
            cell.cellInputAccessoryView = self.itemSearchResultCollectionView;
        }
        else if (indexPath.section == WIADetailTablewViewSectionRestaurant){
            cell.cellPlaceHolder = @"tag a restaurant";
            cell.cellInputAccessoryView = self.restaurantSearchResultCollectionView;
        }
        return cell;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case WIADetailTablewViewSectionImagePreview:
            return @"Preview";
            break;
        case WIADetailTablewViewSectionItem:
            return @"Item Name";
            break;
        case WIADetailTablewViewSectionRestaurant:
            return @"Restaurant Name";
            break;
        case WIADetailTablewViewSectionRating:
            return @"Item Rating";
            break;
        case WIADetailTablewViewSectionReview:
            return @"Item Review";
            break;
            
        default:
            return @"";
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIADetailTablewViewSectionImagePreview) {
        return self.tableView.frame.size.height/4;
    }
    else if (indexPath.section == WIADetailTablewViewSectionReview){
        return 100;
    }
    else{
        return 44;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([collectionView isEqual:self.itemSearchResultCollectionView]) {
        if (self.itemSearchResults.count>0) {
            return self.itemSearchResults.count;
        }
        else{
            return 1;
        }
    }
    else{
        if (self.restaurantSearchResults.count>0) {
            return self.restaurantSearchResults.count;
        }
        else{
            return 1;
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WIASearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WIASearchResultCollectionViewCell" forIndexPath:indexPath];
    if ([collectionView isEqual:self.itemSearchResultCollectionView]) {
        if ([self.itemSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
            
        }
        else{
            if ([self.itemSearchResults[indexPath.row] isEqualToString:@"Start typing..."]) {
                cell.cellText =  self.itemSearchResults[indexPath.row];
            }
            else{
                cell.cellText =  [NSString stringWithFormat:@"Add '%@' as a new item",self.itemSearchResults[indexPath.row]];
            }
        }
    }
    else{
        if ([self.restaurantSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
            
        }
        else{
            if ([self.restaurantSearchResults[indexPath.row] isEqualToString:@"Start typing..."]) {
                cell.cellText =  self.restaurantSearchResults[indexPath.row];
            }
            else{
                cell.cellText =  [NSString stringWithFormat:@"Add '%@' as a new restaurant",self.restaurantSearchResults[indexPath.row]];
            }
        }
    }
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:self.itemSearchResultCollectionView]){
        if ([self.itemSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
            
        }
        else{
            NSString *string = self.itemSearchResults[indexPath.row];
            if (![string isEqualToString:@"Start typing..."]) {
                WIACreateItemViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WIACreateItemViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    else{
        if ([self.restaurantSearchResults[indexPath.row] isKindOfClass:[CKRecord class]]) {
            
        }
        else{
            NSString *string = self.restaurantSearchResults[indexPath.row];
            if (![string isEqualToString:@"Start typing..."]) {
                WIACreateRestaurantViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WIACreateRestaurantViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextFieldTableViewCellDelegate

-(void)WIATextFieldTableViewCellEditingChanged:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIADetailTablewViewSectionItem) {
        if (textField.text.length>0) {
            NSString *searchText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [WIAManager searchForItemWith:searchText completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
                if (results.count>0) {
                    
                }
                else{
                    [self.itemSearchResults removeAllObjects];
                    [self.itemSearchResults addObject:searchText];
                }
            }];
        }
        else{
            [self.itemSearchResults removeAllObjects];
            [self.itemSearchResults addObject:@"Start typing..."];
        }
        [self.itemSearchResultCollectionView reloadData];
    }
    else{
        if (textField.text.length>0) {
            NSString *searchText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [WIAManager searchForRestaurantWith:searchText completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
                if (results.count>0) {
                    
                }
                else{
                    [self.restaurantSearchResults removeAllObjects];
                    [self.restaurantSearchResults addObject:searchText];
                }
            }];
        }
        else{
            [self.restaurantSearchResults removeAllObjects];
            [self.restaurantSearchResults addObject:@"Start typing..."];
        }
        [self.restaurantSearchResultCollectionView reloadData];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextViewTableViewCellDelegate

-(void)WIATextViewTableViewCellDidChange:(UITextView *)textView{
    
}

@end
