//
//  RemoveAdsAlertView.m
//  Dots And Boxes
//
//  Created by Martin Markov on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RemoveAdsAlertView.h"

@implementation RemoveAdsAlertView

#pragma mark Alert View Delegate Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Button 1");
    } else if (buttonIndex == 1) {
        NSLog(@"Button 2");
    }
}
@end
