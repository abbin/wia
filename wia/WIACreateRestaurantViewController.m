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

typedef NS_ENUM(NSInteger, WIARestaurantDetailTableViewSection) {
    WIARestaurantDetailTableViewSectionName = 0,
    WIARestaurantDetailTableViewSectionAddress,
    WIARestaurantDetailTableViewSectionCoordinates,
    WIARestaurantDetailTableViewSectionPhoneNumber,
    WIARestaurantDetailTableViewSectionWorkingDays,
    WIARestaurantDetailTableViewSectionWorkingHours
};

@interface WIACreateRestaurantViewController ()

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
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionAddress){
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"type here";
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionCoordinates){
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"tap here";
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionPhoneNumber){
        WIATagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATagTableViewCell"];
        return cell;
    }
    else if (indexPath.section == WIARestaurantDetailTableViewSectionWorkingDays){
        WIATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIATextFieldTableViewCell"];
        cell.cellPlaceHolder = @"tap here";
        return cell;
    }
    else{
        WIADualTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIADualTextFieldTableViewCell"];
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

@end
