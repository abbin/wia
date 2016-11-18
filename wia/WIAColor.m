//
//  WIAColor.m
//  wia
//
//  Created by Abbin Varghese on 16/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAColor.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation WIAColor

+ (UIColor*)mainColor{
    // Color Options
    // UIColorFromRGB(0xBC1128); - red from stackoverflow
    // UIColorFromRGB(0xFF3B31); - light red from apple
    // UIColorFromRGB(0xFF2D55); - darkbright red from apple
    // UIColorFromRGB(0xdb3236); - google red
    // UIColorFromRGB(0xCB212D); - zomato red
    return UIColorFromRGB(0x345EF2);
}

+ (UIColor*)keyBoardColor{
    return UIColorFromRGB(0xbbc2c9);
}

+ (UIColor*)colorForRating:(CGFloat)rating{
    if (rating>4.5) {
        return UIColorFromRGB(0x4CD964);
    }
    else if (rating>4){
        return UIColorFromRGB(0x79D64B);
    }
    else if (rating>3.5){
        return UIColorFromRGB(0xA6D332);
    }
    else if (rating>3){
        return UIColorFromRGB(0xD2CF19);
    }
    else if (rating>2.5){
        return UIColorFromRGB(0xFFCC00);
    }
    else if (rating>2){
        return UIColorFromRGB(0xFCA70C);
    }
    else if (rating>1.5){
        return UIColorFromRGB(0xF98217);
    }
    else if (rating>1){
        return UIColorFromRGB(0xF65D23);
    }
    else{
        return UIColorFromRGB(0xF3382E);
    }
}

@end
