//
//  WIARatingTableViewCell.m
//  wia
//
//  Created by Abbin Varghese on 17/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIARatingTableViewCell.h"
#import "WIAColor.h"

@interface WIARatingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UIView *viewFour;
@property (weak, nonatomic) IBOutlet UIView *viewFive;
@property (weak, nonatomic) IBOutlet UIView *viewSix;
@property (weak, nonatomic) IBOutlet UIView *viewSeven;
@property (weak, nonatomic) IBOutlet UIView *viewEight;
@property (weak, nonatomic) IBOutlet UIView *viewNine;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation WIARatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIPanGestureRecognizer * swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [self.containerView addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.containerView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTap:(UITapGestureRecognizer *)sender{
    CGFloat x = [sender locationOfTouch:0 inView:self.containerView].x;
    CGFloat value = ((x/self.containerView.frame.size.width)*9);
    [self updateViewWithValue:value];
}

- (IBAction)didSwipe:(UIPanGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateEnded) {
        CGFloat x = [sender locationOfTouch:0 inView:self.containerView].x;
        CGFloat value = ((x/self.containerView.frame.size.width)*9);
        [self updateViewWithValue:value];
    }
}

- (void)updateViewWithValue:(CGFloat)value{
    if (value > 8) {
        self.viewNine.backgroundColor = [WIAColor colorForRating:5];
        self.viewEight.backgroundColor = [WIAColor colorForRating:4.5];
        self.viewSeven.backgroundColor = [WIAColor colorForRating:4];
        self.viewSix.backgroundColor = [WIAColor colorForRating:3.5];
        self.viewFive.backgroundColor = [WIAColor colorForRating:3];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"5.0";
    }
    else if (value > 7){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorForRating:4.5];
        self.viewSeven.backgroundColor = [WIAColor colorForRating:4];
        self.viewSix.backgroundColor = [WIAColor colorForRating:3.5];
        self.viewFive.backgroundColor = [WIAColor colorForRating:3];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"4.5";
    }
    else if (value > 6){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorForRating:4];
        self.viewSix.backgroundColor = [WIAColor colorForRating:3.5];
        self.viewFive.backgroundColor = [WIAColor colorForRating:3];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"4.0";
    }
    else if (value > 5){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorForRating:3.5];
        self.viewFive.backgroundColor = [WIAColor colorForRating:3];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"3.5";
    }
    else if (value > 4){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFive.backgroundColor = [WIAColor colorForRating:3];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"3.0";
    }
    else if (value > 3){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFive.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFour.backgroundColor = [WIAColor colorForRating:2.5];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"2.5";
    }
    else if (value > 2){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFive.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFour.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewThree.backgroundColor = [WIAColor colorForRating:2];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"2.0";
    }
    else if (value > 1){
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFive.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFour.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewThree.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewTwo.backgroundColor = [WIAColor colorForRating:1.5];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"1.5";
    }
    else{
        self.viewNine.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewEight.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSeven.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewSix.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFive.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewFour.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewThree.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewTwo.backgroundColor = [WIAColor colorWithWhite:0.9 alpha:1];
        self.viewOne.backgroundColor = [WIAColor colorForRating:1];
        self.ratingLabel.text = @"1.0";
    }
}

@end
