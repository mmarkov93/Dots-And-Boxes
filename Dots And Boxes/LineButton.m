//
//  LineButton.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LineButton.h"


@implementation LineButton

@synthesize coordinate;

-(void) dealloc {
    [coordinate release];
    
    [super dealloc];
}

@end
