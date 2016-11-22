//
//  WIADaysPickerController.m
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIADaysPickerController.h"
#import "WIADayTableViewCell.h"

typedef NS_ENUM(NSInteger, WIADaySection) {
    WIADaySectionSunday,
    WIADaySectionMonday,
    WIADaySectionTuesday,
    WIADaySectionWednesday,
    WIADaySectionThrusday,
    WIADaySectionFriday,
    WIADaySectionSaturday
};

typedef NS_ENUM(NSInteger, WIADayStatus) {
    isOff,
    isOn
};

@interface WIADaysPickerController ()<UITableViewDelegate,UITableViewDataSource,WIADayTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dayTableView;

@property (strong, nonatomic) NSMutableArray *daysArray;

@end

@implementation WIADaysPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.daysArray = [[NSMutableArray alloc]init];
    
    [self.dayTableView registerNib:[UINib nibWithNibName:@"WIADayTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIADayTableViewCell"];
    
    for (NSDictionary *dict in self.workingDaysArray) {
        NSInteger day = [[[dict objectForKey:@"close"] objectForKey:@"day"] integerValue];
        switch (day) {
            case 0:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 1:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 2:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 3:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 4:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 5:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
            case 6:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                break;
                
            default:
                break;
        }
    }
}

- (IBAction)donePickingDays:(id)sender {
    NSMutableArray *arrayOfDays = [NSMutableArray new];
    for (NSNumber *num in self.daysArray) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSArray *daySymbols = dateFormatter.standaloneWeekdaySymbols;
        
        NSInteger dayIndex = [num integerValue]; // 0 = Sunday, ... 6 = Saturday
        NSString *dayName = daySymbols[dayIndex];
        
        NSMutableDictionary *close = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *open = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *mainDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:close,@"close",open,@"open", nil];
        [arrayOfDays addObject:mainDict];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(WIADaysPickerController:didFinishWithdays:)]) {
            [self.delegate WIADaysPickerController:self didFinishWithdays:arrayOfDays];
        }
    }];
}

- (IBAction)cancelPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WIADayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIADayTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    if ([self.daysArray containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
        cell.cellIsOn = YES;
    }
    else{
        cell.cellIsOn = NO;
    }
    if (indexPath.row == WIADaySectionSunday) {
        cell.cellText = @"Sunday";
    }
    else if (indexPath.row == WIADaySectionMonday) {
        cell.cellText = @"Monday";
    }
    else if (indexPath.row == WIADaySectionTuesday){
        cell.cellText = @"Tuesday";
    }
    else if (indexPath.row == WIADaySectionWednesday){
        cell.cellText = @"Wednesday";
    }
    else if (indexPath.row == WIADaySectionThrusday){
        cell.cellText = @"Thursday";
    }
    else if (indexPath.row == WIADaySectionFriday){
        cell.cellText = @"Friday";
    }
    else {
        cell.cellText = @"Saturday";
    }
    return cell;
}

-(void)dayTableViewCell:(WIADayTableViewCell *)cell didChangeStatus:(BOOL)status withIndexPath:(NSIndexPath *)indexPath{
    if (status == isOn){
        [self.daysArray addObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    else{
        [self.daysArray removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }
}

@end
