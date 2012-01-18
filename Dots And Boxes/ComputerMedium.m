//
//  ComputerMedium.m
//  Dots And Boxes
//
//  Created by Martin Markov on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComputerMedium.h"
#import "Chain.h"
#import "Box.h"

@implementation ComputerMedium


-(BOOL)containsTwoOrThreeSides:(Coordinate*) coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    
    int count = game.horizontalLines[row][column] + game.horizontalLines[row+1][column] + game.verticalLines[row][column] + game.verticalLines[row][column+1];
    
    if (count == 2 || count == 3) {
        return true;
    }
    
    return false;
}

-(Box*)getBoxWithRow:(int) row andColumn:(int) column {
    Box *box =[[Box alloc] init];
    
    box.left = game.verticalLines[row][column];
    box.right = game.verticalLines[row][column + 1];
    box.up = game.horizontalLines[row][column];
    box.down = game.horizontalLines[row + 1][column];
    
    return box;
}

-(BOOL)isBeginingOfChain:(Coordinate*) coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    
    Box *box = [self getBoxWithRow:coordinate.row andColumn:coordinate.column];
    int countOfSides = [box getSidesCount];
    int countOfBoxesAround = 0;
    
    if (countOfSides == 2 || countOfSides == 3) {
        NSLog(@"Box row:%d column:%d", row, column);
        if ((coordinate.row > 0) && (box.up == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row - 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        } 
        
        if ((coordinate.row < (game.dotsCount - 1)) && (box.down == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row + 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        }
        
        if ((coordinate.column < (game.dotsCount - 1)) && (box.right == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column + 1 AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        }       
        
        if ((coordinate.row > 0) && (box.left == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column-1 AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        }        
    } else {
        return false;
    }
    
    if (countOfBoxesAround < 2) {
        return true;
    }
    
    return false;
}

-(Chain*)getChain:(Coordinate*) coordinate {
    Chain *chain = [[Chain alloc] init];
    
    int row = coordinate.row;
    int column = coordinate.column;
    
    
     
    BOOL isChain = true;
    
    while (isChain){
        Box *box = [self getBoxWithRow:row andColumn:column]; 
        
        if ([box getSidesCount] == 2) {
            Coordinate *coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:kBox];
            
            [chain addObject:coordinate];
            
            [coordinate release];   
        } else {
            isChain = false;
        }
    } 
    
    return chain;
}

-(NSArray*)getLongChains {
    NSMutableArray *longChanins = [[NSMutableArray alloc] init];
    
    for (int i=0; i<game.dotsCount - 1; i++) {
        for (int j=0; j<game.dotsCount - 1; j++) {
            Coordinate *boxCoordinate = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kBox];
            
            if ([self isBeginingOfChain:boxCoordinate]) {

                NSLog(@"\n\nBegining row:%d column:%d\n\n", boxCoordinate.row, boxCoordinate.column);
                //Chain *chain = [self getChain:boxCoordinate];
               // if (chain.count > 2) {
                 //   [longChanins addObject:chain];
                //}
            }
            
            [boxCoordinate release];            
        }
    }
    
    return longChanins;
}

-(Coordinate*)makeMove {
    [self getLongChains];
    
    NSArray *posibleMoves = [self getPosibleMoves];
    //[self print:posibleMoves];
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
    //NSLog(@"Box Moves:%d", [boxMoves count]);
    if ([boxMoves count] > 0) {
        int randomBox = arc4random_uniform([boxMoves count]);
        return [boxMoves objectAtIndex:randomBox];
    } else if ([noBoxMoves count] > 0) {
        int randomNoBox = arc4random_uniform([noBoxMoves count]);
        return [noBoxMoves objectAtIndex:randomNoBox];
    }
    
    int random = arc4random_uniform([posibleMoves count]);
    
    
    return [posibleMoves objectAtIndex:random];}

@end
