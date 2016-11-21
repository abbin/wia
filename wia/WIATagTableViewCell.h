//
//  WIATagTableViewCell.h
//  wia
//
//  Created by Abbin Varghese on 20/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTagsControl.h"

@interface WIATagTableViewCell : UITableViewCell

@property (assign, nonatomic) id<TLTagsControlDelegate> tapDelegate;

@end
