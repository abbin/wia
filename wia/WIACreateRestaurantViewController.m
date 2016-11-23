//
//  WIACreateRestaurantViewController.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIACreateRestaurantViewController.h"
#import "WIATextFieldTableViewCell.h"
#import "WIATagTableViewCell.h"
#import "WIADualTextFieldTableViewCell.h"
#import "TLTagsControl.h"
#import "WIACoordinatesPickerController.h"
#import "WIADaysPickerController.h"
#import "WIAConstants.h"

typedef NS_ENUM(NSInteger, WIARestaurantDetailTableViewSection) {
    WIARestaurantDetailTableViewSectionName = 0,
    WIARestaurantDetailTableViewSectionAddress,
    WIARestaurantDetailTableViewSectionCoordinates,
    WIARestaurantDetailTableViewSectionPhoneNumber,
    WIARestaurantDetailTableViewSectionWorkingDays,
    WIARestaurantDetailTableViewSectionWorkingHours
};

@interface WIACreateRestaurantViewController ()<WIATextFieldTableViewCellDelegate,TLTagsControlDelegate,WIACoordinatesPickerControllerDelegate,WIADaysPickerControllerDelegate,WIADualTextFieldTableViewCellDelegate>

@property (strong, nonatomic) NSString *fromString;
@property (strong, nonatomic) NSString *tillString;
@property (strong, nonatomic) NSString *restaurantAddress;
@property (strong, nonatomic) NSArray *restaurantPhoneNumbers;
@property (strong, nonatomic) NSMutableArray *restaurantWorkingDays;
@property (assign, nonatomic) CLLocationCoordinate2D restaurantCoordinates;

@end

@implementation WIACreateRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIATagTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIATagTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIADualTextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIADualTextFieldTableViewCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.frame];
    imageView.image = [UIImage imageNamed:@"FirstLaunchBackground"];
    imageView.alpha  = 0.5;
    self.tableView.backgroundView = imageView;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(createRecord:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction

- (void)createRecord:(id)sender{
    if (self.restaurantName.length > 0 && self.restaurantAddress.length > 0 && CLLocationCoordinate2DIsValid(self.restaurantCoordinates)) {
        if (self.restaurantWorkingDays.count > 0) {
            if (self.tillString.length > 0 && self.fromString.length > 0) {
                [self initRecord];
            }
            else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing hours" message:@"Working hours are needed along with working days" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        else{
            [self initRecord];
        }
    }
}

- (void)initRecord{
    CKRecord *restRecord = [[CKRecord alloc] initWithRecordType:kWIARecordTypeRestaurant];
    restRecord[kWIARestaurantName] = self.restaurantName;
    restRecord[kWIARestaurantAddress] = self.restaurantAddress;
    restRecord[kWIARestaurantCoordinates] = [[CLLocation alloc]initWithLatitude:self.restaurantCoordinates.latitude longitude:self.restaurantCoordinates.longitude];
    if (self.restaurantPhoneNumbers.count > 0) {
        restRecord[kWIARestaurantPhoneNumber] = self.restaurantPhoneNumbers;
    }
//    if (self.restaurantWorkingDays.count > 0) {
//        for (NSMutableDictionary *dict in self.restaurantWorkingDays) {
//            [[dict objectForKey:@"close"] setObject:self.tillString forKey:@"time"];
//            [[dict objectForKey:@"open"] setObject:self.fromString forKey:@"time"];
//        }
////        restRecord[kWIARestaurantWorkingdays] = self.restaurantWorkingDays;
//    }
    if ([self.delegate respondsToSelector:@selector(WIACreateRestaurantViewController:didFinishWithRecord:)]) {
        [self.delegate WIACreateRestaurantViewController:self didFinishWithRecord:restRecord];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionName) {
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"type here";
        cell.cellText = self.restaurantName;
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionAddress){
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"type here";
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionCoordinates){
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"tap here";
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionPhoneNumber){
        WIATagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATagTableViewCell"];
        cell.tapDelegate = self;
        cell.cellIndexPath = indexPath;
        cell.cellPlaceHolder = @"type here";
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionWorkingDays){
        WIATagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATagTableViewCell"];
        cell.tapDelegate = self;
        cell.cellIndexPath = indexPath;
        cell.cellPlaceHolder = @"tap here";
        return cell;
    }
    else{
        WIADualTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIADualTextFieldTableViewCell"];
        cell.delegate = self;
        return cell;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == WIARestaurantDetailTableViewSectionName) {
        return @"Restaurant name";
    }
    else if (section == WIARestaurantDetailTableViewSectionAddress){
        return @"Address";
    }
    else if (section == WIARestaurantDetailTableViewSectionCoordinates){
        return @"Coordinates";
    }
    else if (section == WIARestaurantDetailTableViewSectionPhoneNumber){
        return @"Phone Number (optional)";
    }
    else if (section == WIARestaurantDetailTableViewSectionWorkingDays){
        return @"Working days (optional)";
    }
    else{
        return @"Working Hours (optional)";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionWorkingHours) {
        return 70;
    }
    else{
        return 44;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIATextFieldTableViewCellDelegate

-(void)WIATextFieldTableViewCellEditingChanged:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionName) {
        self.restaurantName = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionAddress){
        self.restaurantAddress = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

-(BOOL)WIATextFieldTableViewCellShouldBeginEditing:(UITextField *)textField withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionCoordinates) {
        UINavigationController *pickerNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIACoordinatesPickerController"];
        WIACoordinatesPickerController *picker = [pickerNav.viewControllers firstObject];
        picker.delegate = self;
        [self presentViewController:pickerNav animated:YES completion:nil];
        return NO;
    }
    else{
        return YES;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TLTagsControlDelegate

-(void)tagsControl:(TLTagsControl *)tagsControl didUpdateTags:(NSArray *)tagArray withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionPhoneNumber) {
        self.restaurantPhoneNumbers = tagArray;
    }
}

-(BOOL)tagsControlShouldBeginEditing:(TLTagsControl *)tagsControl withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == WIARestaurantDetailTableViewSectionPhoneNumber) {
        return YES;
    }
    else{
        UINavigationController *pickerNav = [self.storyboard instantiateViewControllerWithIdentifier:@"WIADaysPickerController"];
        WIADaysPickerController *picker = [pickerNav.viewControllers firstObject];
        picker.delegate = self;
        picker.workingDaysArray = [self.restaurantWorkingDays mutableCopy];
        [self presentViewController:pickerNav animated:YES completion:nil];
        return NO;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIACoordinatesPickerControllerDelegate

-(void)WIACoordinatesPickerController:(WIACoordinatesPickerController *)picker didFinishWithCoordinates:(CLLocationCoordinate2D)coordinates{
    WIATextFieldTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:WIARestaurantDetailTableViewSectionCoordinates]];
    cell.cellText = [NSString stringWithFormat:@"%f, %f",coordinates.latitude,coordinates.longitude];
    self.restaurantCoordinates = coordinates;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIADaysPickerControllerDelegate

-(void)WIADaysPickerController:(WIADaysPickerController *)picker didFinishWithdays:(NSMutableArray *)daysArray{
    WIATagTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:WIARestaurantDetailTableViewSectionWorkingDays]];
    NSMutableArray *tagsArray = [NSMutableArray new];
    for (NSDictionary *dict in daysArray) {
        NSString *tag = [[dict objectForKey:@"close"] objectForKey:@"dayName"];
        [tagsArray addObject:tag];
    }
    cell.cellTags = tagsArray;
    self.restaurantWorkingDays = daysArray;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WIADualTextFieldTableViewCellDelegate

-(void)WIADualTextFieldTableViewCellTextFieldOneDidChangeEditing:(NSString *)string{
    self.fromString = string;
}

-(void)WIADualTextFieldTableViewCellTextFieldTwoDidChangeEditing:(NSString *)string{
    self.tillString = string;
}

@end
