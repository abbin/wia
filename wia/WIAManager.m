//
//  WIAManager.m
//  wia
//
//  Created by Abbin Varghese on 18/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAManager.h"
#import <PINCache.h>
#import "WIAConstants.h"

@interface WIAManager ()

@property (strong, nonatomic)CKQueryOperation *queryOp;

@end

@implementation WIAManager

+ (instancetype)sharedManager {
    static WIAManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

+ (void)searchForCuisineWith:(NSString *)string completionHandler:(void (^)(NSMutableArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    
    [[WIAManager sharedManager].queryOp cancel];
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc]init];
    
    CKDatabase *publicDatabase = [[CKContainer defaultContainer] publicCloudDatabase];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH %@", kWIACuisineCappedName, [string lowercaseString]];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:kWIARecordTypeCuisine predicate:predicate];
    
    CKQueryOperation *queryOp = [[CKQueryOperation alloc]initWithQuery:query];
    [WIAManager sharedManager].queryOp = queryOp;
    
    queryOp.recordFetchedBlock = ^(CKRecord * _Nonnull record) {
        [resultsArray addObject:record];
    };
    queryOp.queryCompletionBlock = ^(CKQueryCursor * _Nullable cursor, NSError * _Nullable error) {
        if (error == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(resultsArray, error);
            });
        }
    };
    
    [publicDatabase addOperation:queryOp];
}

+ (void)searchForItemWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    completionHandler([NSArray new], nil);
}

+ (void)searchForRestaurantWith:(NSString *)string completionHandler:(void (^)(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error))completionHandler{
    completionHandler([NSArray new], nil);
}

+ (BOOL)isUserSet{
    PINCache *userCache = [[PINCache alloc]initWithName:kWIARecordTypeUserProfile];
    if ([userCache containsObjectForKey:kWIAUserName] && [userCache containsObjectForKey:kWIAUserLocation]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
