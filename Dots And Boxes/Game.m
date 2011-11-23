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
@synthesize player1, player2, currentPlayer;
@synthesize horizontalLines, verticalLines, boxes;
@synthesize dotsCount;

- (id) init {
    self = [super init];
    if (self != nil) {
        currentPlayer = player1;
        dotsCount = 4;
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
                horizontalLines[x][y] = 0;
                if (x != dotsCount-1 & y != dotsCount-1) {
                    boxes[x][y] = 0;
                }
                
            }
        }
        // initializations go here.
    }
    return self;
}

-(bool)checkForBoxAboveTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return (verticalLines[row-1][column] == 1 & verticalLines[row-1][column+1] == 1 & horizontalLines [row-1][column] == 1);
}

-(bool)checkForBoxUnderTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return (verticalLines[row][column] == 1 & verticalLines[row][column+1] == 1 & horizontalLines [row+1][column] == 1);
}

-(bool)checkForBoxLeftOFTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return (horizontalLines[row][column-1] == 1 & horizontalLines[row+1][column-1] == 1 & verticalLines [row][column-1] == 1);
}

-(bool)checkForBoxRightOFTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return (horizontalLines[row][column-1] == 1 & horizontalLines[row+1][column-1] == 1 & verticalLines [row][column-1] == 1);
}

-(void)putBoxes:(NSArray *)boxesArray {
    for (Coordinate *box in boxesArray) {
        int row = box.row;
        int column = box.column;
        boxes[row][column] = 1;
    }
}

-(NSArray*)checkForBoxes:(Coordinate *)coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    ObjectType objectType = coordinate.objectType;
    NSMutableArray *boxesArray = [[NSMutableArray alloc] init];
    
    if (objectType == kHorizontalLine) {
        NSLog(@"HorizontalLine");
        //check for box above the line
        if (row > 0) {
            if ((verticalLines[row-1][column] == 1) && (verticalLines[row-1][column+1] == 1) && (horizontalLines [row-1][column] == 1)) {
                Coordinate *box1Coordinate = [[Coordinate alloc] initWithRow:(row-1) Column:column AndObjectType:kBox];
                [boxesArray addObject:box1Coordinate];
                
                [box1Coordinate release];
                NSLog(@"Box row:%d column:%d", row-1, column);
            }
        }
        //check for box under the line
        if(column < dotsCount -1 & row < dotsCount-1) {
            if ((verticalLines[row][column] == 1) && (verticalLines[row][column+1] == 1) && (horizontalLines [row+1][column] == 1)) {
                Coordinate *box2Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:kBox];
                [boxesArray addObject:box2Coordinate];
                
                [box2Coordinate release];
                NSLog(@"Box row:%d column:%d", row, column);
            }
        }
        
    } else if (objectType == kVerticalLine) {
        NSLog(@"VerverticalLines");
        //check for box left of the line
        if ((horizontalLines[row][column-1] == 1) && (horizontalLines[row+1][column-1] == 1) && (verticalLines[row][column-1] == 1)) {
            Coordinate *box3Coordinate = [[Coordinate alloc] initWithRow:row Column:(column-1) AndObjectType:kBox];
            [boxesArray addObject:box3Coordinate];
            
            [box3Coordinate release];
            NSLog(@"Box row:%d column:%d", row-1, column);
        }
        //check for box right of the line
        if (column < dotsCount - 1) {
            if ((horizontalLines[row][column] == 1) && (horizontalLines[row+1][column] == 1) && (verticalLines [row][column+1] == 1)) {
                Coordinate *box4Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:objectType];
                [boxesArray addObject:box4Coordinate];
                
                [box4Coordinate release];
                NSLog(@"Box row:%d column:%d", row, column);
            }
            
        }
        
    }
    
    return boxesArray;
}

-(void)changeCurrentPlayer {
    if (currentPlayer == player1) {
        currentPlayer = player2;
    } else {
        currentPlayer = player1;
    }
}

@end
