//
//  WIAManager.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAManager.h"

@implementation WIAManager

+ (void)searchForCuisineWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    completionHandler([NSArray new], nil);
}

+ (void)searchForItemWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    completionHandler([NSArray new], nil);
}

+ (void)searchForRestaurantWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    completionHandler([NSArray new], nil);
}

@end
