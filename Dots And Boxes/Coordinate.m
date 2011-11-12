//
//  Coordinate.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Coordinate.h"


@implementation Coordinate

@synthesize row, column, objectType;

-(id)initWithRow:(int)inRow Column:(int)inColumn AndObjectType:(ObjectType)inType {
    self = [super init];
    if (self) {
        row = inRow;
        column = inColumn;
        objectType = inType;
    }
    return (self);
}

@end
