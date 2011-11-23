//
//  Player.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize color;
@synthesize name;
@synthesize boxesCount;

-(id)initWithColor:(NSString *)inColor Name:(NSString *)inName {
    self = [super init];
    if (self) {
        color = inColor;
        name = inName;
    }
    return (self);
}

-(UIImage*)getPlayerHorizontalLineImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@HorizontalLine.png", color]];
}

-(UIImage*)getPlayerBoxImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@Box.png", color]];
}

-(UIImage*)getPlayerVerticalLineImage {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@HorizontalLine.png", color]];
}

@end
