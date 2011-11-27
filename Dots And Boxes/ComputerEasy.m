//
//  ComputerEasy.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComputerEasy.h"


@implementation ComputerEasy

@synthesize game;

-(NSArray*)getPosibleMoves {
    NSMutableArray *posibleMoves = [[NSMutableArray alloc] init];
    for (int i=0; i<game.dotsCount; i++) {
        
        for (int j=0; j<game.dotsCount; j++) {
            
            if (i<game.dotsCount - 1) {
                NSLog(@"NE");
                if (game.verticalLines[i][j] == 0) {
                    
                    Coordinate *verticalCord = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kVerticalLine];
                    [posibleMoves addObject:verticalCord];
                    NSLog(@"DA");
                    
                }
            }
            
            if (j<game.dotsCount - 1) {
                
                if (game.horizontalLines[i][j] == 0) {
                    
                    Coordinate *horizontalCord = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kHorizontalLine];
                    [posibleMoves addObject:horizontalCord];
                    
                }
            }
        }
    }
    
    return posibleMoves;
}

-(void)print:(NSArray*) arr {
    for (Coordinate *coord in arr) {
        if (coord.objectType == kHorizontalLine) {
            NSLog(@"Horizontal row:%d, column:%d", coord.row, coord.column);
        } else if (coord.objectType == kVerticalLine) {
            NSLog(@"Vertical row:%d, column:%d", coord.row, coord.column);
        }
    }
}

-(int)checkForNumberOfLines:(Coordinate*) coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    ObjectType objectType = coordinate.objectType;
    int numOfLines1 = 0;
    int numOfLines2 = 0;
    
    if (objectType == kHorizontalLine) {
        //check for box above the line
        if (row > 0) {
            numOfLines1= game.verticalLines[row-1][column] + game.verticalLines[row-1][column+1] + game.horizontalLines [row-1][column];
        } 
        //check for box under the line
        if(column < game.dotsCount -1 && row < game.dotsCount-1) {
            numOfLines2 = game.verticalLines[row][column] + game.verticalLines[row][column+1] + game.horizontalLines [row+1][column];
        }
        
    } else if (objectType == kVerticalLine) {
        //check for box left of the line
        if (column > 1) {
            numOfLines1 = game.horizontalLines[row][column-1] + game.horizontalLines[row+1][column-1] + game.verticalLines[row][column-1];
        }
        
        //check for box right of the line
        if (column < game.dotsCount - 1) {
            numOfLines2 = game.horizontalLines[row][column] + game.horizontalLines[row+1][column] + game.verticalLines [row][column+1];
            
        }
        
    }
    
    return MAX(numOfLines1, numOfLines2);

}

-(Coordinate*)makeMove {
    NSArray *posibleMoves = [self getPosibleMoves];
    [self print:posibleMoves];
    NSMutableArray *boxMoves = [[NSMutableArray alloc] init];
    NSMutableArray *noBoxMoves = [[NSMutableArray alloc] init];
    
    for (Coordinate *line in posibleMoves) {
        int lines = [self checkForNumberOfLines:line];
        if (lines == 3) {
            [boxMoves addObject:line];
        } else if (lines < 2){
            [noBoxMoves addObject:line];
        }
    }
    NSLog(@"Box Moves:%d", [boxMoves count]);
    if ([boxMoves count] > 0) {
        int randomBox = arc4random_uniform([boxMoves count]);
        return [boxMoves objectAtIndex:randomBox];
    } else if ([noBoxMoves count] > 0) {
        int randomNoBox = arc4random_uniform([noBoxMoves count]);
        return [noBoxMoves objectAtIndex:randomNoBox];
    }
    
    int random = arc4random_uniform([posibleMoves count]);
    
    return [posibleMoves objectAtIndex:random];
}

@end
