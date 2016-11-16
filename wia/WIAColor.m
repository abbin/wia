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
    return UIColorFromRGB(0x345EF2);
}

@end
