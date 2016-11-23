//
//  WIAManager.h
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WIAManager : NSObject

+ (void)searchForCuisineWith:(NSString *)string completionHandler:(void (^)(NSMutableArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler;
+ (void)searchForItemWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler;
+ (void)searchForRestaurantWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler;

+ (BOOL)isUserSet;

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
