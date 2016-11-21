//
//  WIARatingTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WIARatingTableViewCellDelegate <NSObject>

- (void)WIARatingTableViewCellRatingChanged:(NSNumber*)rating;

@end

@interface WIARatingTableViewCell : UITableViewCell

@property (weak, nonatomic) id <WIARatingTableViewCellDelegate> delegate;

@end
