//
//  RootViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductFetchedNotification @"kInAppPurchaseManagerProductFetchedNotification"

@interface RootViewController : UIViewController<SKProductsRequestDelegate> {
    SKProduct *removeAdsProduct;
    SKProductsRequest *productRequest;
}

-(IBAction)onePlayerButtonPressed;
-(IBAction)twoPlayerButtonPressed;
-(void) requestRemoveAdsData;

@end
