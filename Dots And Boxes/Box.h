//
//  Box.h
//  Dots And Boxes
//
//  Created by Martin Markov on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Box : NSObject {
    int left;
    int right;
    int up;
    int down;
}

@property int left, right, up, down;

-(int)getSidesCount;

@end
