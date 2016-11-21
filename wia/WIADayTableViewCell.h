//
//  WIADayTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 21/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WIADayTableViewCell;

@protocol WIADayTableViewCellDelegate <NSObject>

-(void)dayTableViewCell:(WIADayTableViewCell*)cell didChangeStatus:(BOOL)status withIndexPath:(NSIndexPath*)indexPath;

@end


@interface WIADayTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property (strong, nonatomic) NSString *cellText;
@property (assign, nonatomic) BOOL cellIsOn;

@property (weak, nonatomic) id <WIADayTableViewCellDelegate> delegate;

@end
