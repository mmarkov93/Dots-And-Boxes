//
//  LineButton.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LineImageView.h"


@implementation LineImageView

@synthesize coordinate;
@synthesize enabled;

-(id)init {
    if (self = [super init]) {
        enabled = YES;
    }
    
    return self;
}


-(void) dealloc {
    [coordinate release];
    
    [super dealloc];
}

@end
