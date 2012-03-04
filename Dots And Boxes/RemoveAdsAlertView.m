//
//  RemoveAdsAlertView.m
//  Dots And Boxes
//
//  Created by Martin Markov on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RemoveAdsAlertView.h"
#import "InAppPurchaseManager.h"

@implementation RemoveAdsAlertView

#pragma mark Alert View Delegate Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
    } else if (buttonIndex == 1) {
        InAppPurchaseManager *purchaseManager = [[InAppPurchaseManager alloc] init];
        [purchaseManager loadStore];
        if ([purchaseManager canMakePurchases]) {
            [purchaseManager purchaseProUpgrade];
        }
    }
}
@end
