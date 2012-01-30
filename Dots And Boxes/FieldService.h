//
//  FieldService.h
//  Dots And Boxes
//
//  Created by Martin Markov on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface FieldService : NSObject {
    int** horizontalLines;
    int** verticalLines;
    int dotsCount;
}

@property int** horizontalLines;
@property int** verticalLines;
@property int dotsCount;

-(id) initWithVerticalLines:(int**) initVerticalLines HorizontalLines:(int**) initHorizontalLines AndDotsCount:(int) initDotsCount;

-(bool)checkForBoxAboveTheLine:(Coordinate*)line;
-(bool)checkForBoxUnderTheLine:(Coordinate*)line; 
-(bool)checkForBoxLeftOFTheLine:(Coordinate*)line;
-(bool)checkForBoxRightOFTheLine:(Coordinate*)line;

-(int)checkForMaxNumberOfLines:(Coordinate*) coordinate;
-(NSArray*)checkForBoxes:(Coordinate*) coordinate;
-(NSArray*)getBoxesAroundLine:(Coordinate*)line;
@end
