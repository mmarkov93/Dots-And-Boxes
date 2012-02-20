//
//  Game.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "ComputerEasy.h"
#import "FieldService.h"


@implementation Game
@synthesize player1, player2, currentPlayer;
@synthesize horizontalLines, verticalLines, boxes;
@synthesize dotsCount;

- (id) initWithBoxCount:(int)boxCount {
    self = [super init];
    if (self != nil) {
        currentPlayer = player1;
        dotsCount = boxCount + 1;
        horizontalLines = (int **) malloc(dotsCount*sizeof(int));
        verticalLines = (int **) malloc(dotsCount*sizeof(int));
        boxes = (int **) malloc(dotsCount*sizeof(int));
        for (int i = 0; i < dotsCount; i++) {
            horizontalLines[i] = (int *) malloc(dotsCount*sizeof(int));
            verticalLines[i] = (int *) malloc(dotsCount*sizeof(int));
            if (i != dotsCount-1) {
                boxes[i] = (int *) malloc(dotsCount*sizeof(int));
            }
            
        }
        
        for (int x = 0; x < dotsCount; x++) {
            for (int y = 0; y < dotsCount; y++) {
                horizontalLines[x][y] = 0;
                verticalLines[x][y] = 0;
                if (x != dotsCount-1 & y != dotsCount-1) {
                    boxes[x][y] = 0;
                }
                
            }
        }
        // initializations go here.
    }
    return self;
}

-(void)putBoxes:(NSArray *)boxesArray {
    for (Coordinate *box in boxesArray) {
        int row = box.row;
        int column = box.column;
        boxes[row][column] = 1;
    }
}

-(NSArray*)checkForBoxes:(Coordinate*) coordinate; {
    FieldService *fieldService = [[FieldService alloc] initWithVerticalLines:verticalLines HorizontalLines:horizontalLines AndDotsCount:dotsCount];
    
    NSArray *boxesArray = [fieldService checkForBoxes:coordinate];
    
    [fieldService release];
    
    return boxesArray;
    
}


-(void)changeCurrentPlayer {
    if (currentPlayer == player1) {
        currentPlayer = player2;
    } else {
        currentPlayer = player1;
    }
}

-(void) dealloc {
    [player1 release];
    [player2 release];
    [currentPlayer release];
    
    [super dealloc];
}

@end
