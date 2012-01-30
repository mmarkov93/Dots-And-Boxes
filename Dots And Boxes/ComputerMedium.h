//
//  ComputerMedium.h
//  Dots And Boxes
//
//  Created by Martin Markov on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComputerEasy.h"

#define kLongChains     @"LongChains"
#define kShortChains    @"ShortChains"

typedef enum CommonSide {
    Left,
    Right,
    Up,
    Down
}CommonSide;

@interface ComputerMedium : ComputerEasy {
    NSMutableArray *shortChains;
    NSMutableArray *loongChains;
    
}

@property(nonatomic, retain) NSMutableArray *shortChains;
@property(nonatomic, retain) NSMutableArray *longChains;

@end
