//
//  InAppPurchaseManager.h
//  Dots And Boxes
//
//  Created by Martin Markov on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"



@interface InAppPurchaseManager : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    
    SKProduct *removeAdsProduct;
    SKProductsRequest *productsRequest;
    
    NSString *localizedPrice;
}

@property (nonatomic, readonly) NSString *localizedPrice;

-(void) requestRemoveAdsData;

- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;

@end
