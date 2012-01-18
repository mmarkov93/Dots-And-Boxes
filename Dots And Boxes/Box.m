//
//  Box.m
//  Dots And Boxes
//
//  Created by Martin Markov on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Box.h"

@implementation Box

@synthesize left, right, up, down;

-(int) getSidesCount {
    return (left + right + up + down);
}

@end
