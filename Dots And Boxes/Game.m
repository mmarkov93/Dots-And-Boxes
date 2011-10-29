//
//  Game.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "ComputerEasy.h"


@implementation Game
@synthesize player1;
@synthesize player2;
@synthesize horizontalLines, verticalLines, boxes;

- (id) init {
    self = [super init];
    if (self != nil) {
        horizontalLines = (int **) malloc(5*sizeof(int));
        verticalLines = (int **) malloc(5*sizeof(int));
        boxes = (int **) malloc(5*sizeof(int));
        for (int i = 0; i < 5; i++) {
            horizontalLines[i] = (int *) malloc(5*sizeof(int));
            verticalLines[i] = (int *) malloc(5*sizeof(int));
            boxes[i] = (int *) malloc(5*sizeof(int));
        }
        
        for (int x = 0; x < 5; x++) {
            for (int y = 0; y < 5; y++) {
                horizontalLines[x][y] = 0;
                verticalLines[x][y] = 0;
                boxes[x][y] = 0;
            }
        }
        // initializations go here.
    }
    return self;
}

@end
