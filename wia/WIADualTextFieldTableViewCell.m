//
//  WIADualTextFieldTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 20/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIADualTextFieldTableViewCell.h"

@interface WIADualTextFieldTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cellHeaderLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *cellHeaderLabelTwo;
@property (weak, nonatomic) IBOutlet UITextField *cellTextFieldOne;
@property (weak, nonatomic) IBOutlet UITextField *cellTextFieldTwo;

@property (strong, nonatomic) UIDatePicker *datePickerOne;
@property (strong, nonatomic) UIDatePicker *datePickerTwo;

@end

@implementation WIADualTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.datePickerOne = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePickerOne setBackgroundColor:[UIColor whiteColor]];
    [self.datePickerOne setDatePickerMode:UIDatePickerModeTime];
    [self.datePickerOne addTarget:self action:@selector(fromDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.cellTextFieldOne.inputView = self.datePickerOne;
    
    self.datePickerTwo = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    NSDate *currentDate = self.datePickerOne.date;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
    [self.datePickerTwo setMinimumDate:datePlusOneMinute];
    [self.datePickerTwo setBackgroundColor:[UIColor whiteColor]];
    [self.datePickerTwo setDatePickerMode:UIDatePickerModeTime];
    [self.datePickerTwo addTarget:self action:@selector(tillDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.cellTextFieldTwo.inputView = self.datePickerTwo;
}

- (void)tillDatepickerChangedValue:(UIDatePicker*)sender{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.cellTextFieldTwo.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
    
    if ([self.delegate respondsToSelector:@selector(WIADualTextFieldTableViewCellTextFieldTwoDidChangeEditing:)]) {
        [self.delegate WIADualTextFieldTableViewCellTextFieldTwoDidChangeEditing:dateString];
    }
}

- (void)fromDatepickerChangedValue:(UIDatePicker*)sender{
    
    NSDate *currentDate = self.datePickerOne.date;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
    [self.datePickerTwo setMinimumDate:datePlusOneMinute];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.cellTextFieldOne.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
    
    if ([self.delegate respondsToSelector:@selector(WIADualTextFieldTableViewCellTextFieldOneDidChangeEditing:)]) {
        [self.delegate WIADualTextFieldTableViewCellTextFieldOneDidChangeEditing:dateString];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellPlaceHolderOne:(NSString *)cellPlaceHolderOne{
    _cellTextFieldOne.placeholder = cellPlaceHolderOne;
}

-(void)setCellPlaceHolderTwo:(NSString *)cellPlaceHolderTwo{
    _cellTextFieldTwo.placeholder = cellPlaceHolderTwo;
}

-(void)setCellInputViewOne:(UIView *)cellInputViewOne{
    _cellTextFieldOne.inputView = cellInputViewOne;
}

-(void)setCellInputViewTwo:(UIView *)cellInputViewTwo{
    _cellTextFieldTwo.inputView = cellInputViewTwo;
}

@end
