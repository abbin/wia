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

typedef NS_ENUM(NSInteger, WIADetailTablewViewSection) {
    WIADetailTablewViewSectionImagePreview = 0,
    WIADetailTablewViewSectionItem,
    WIADetailTablewViewSectionRestaurant,
    WIADetailTablewViewSectionRating,
    WIADetailTablewViewSectionReview
};

@interface WIAAddAndReviewViewController ()<UITableViewDelegate,UITableViewDataSource,WIATextFieldTableViewCellDelegate>

@property (strong, nonatomic) NSArray *images;

@end

@implementation WIAAddAndReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIARatingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIARatingTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIACollectionViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIACollectionViewTableViewCell"];
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
    else{
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.delegate = self;
        
        if (indexPath.section == WIADetailTablewViewSectionItem) {
            cell.cellImage = [UIImage imageNamed:@"Burger"];
            cell.cellPlaceHolder = @"tap here to tag an item";
        }
        else if (indexPath.section == WIADetailTablewViewSectionRestaurant){
            cell.cellImage = [UIImage imageNamed:@"Restaurant"];
            cell.cellPlaceHolder = @"tap here to tag a restaurant";
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
            return @"Item";
            break;
        case WIADetailTablewViewSectionRestaurant:
            return @"Restaurant";
            break;
        case WIADetailTablewViewSectionRating:
            return @"Rating";
            break;
        case WIADetailTablewViewSectionReview:
            return @"Review";
            break;
            
        default:
            return @"";
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIADetailTablewViewSectionImagePreview) {
        return (self.view.frame.size.width-30)*9/16;
    }
    else{
        return 50;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextFieldTableViewCellDelegate

-(BOOL)WIATextFieldTableViewCellShouldBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
