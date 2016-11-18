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

+ (void)searchForItemWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler;
+ (void)searchForRestaurantWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
