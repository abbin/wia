//
//  WIATextViewTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WIATextViewTableViewCellDelegate <NSObject>

-(void)WIATextViewTableViewCellDidChange:(UITextView *)textView;

@end


@interface WIATextViewTableViewCell : UITableViewCell

@property (weak, nonatomic) id <WIATextViewTableViewCellDelegate> delegate;

@end
