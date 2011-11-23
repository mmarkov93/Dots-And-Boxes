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
                
                if (game.verticalLines[i][j] == 0) {
                    
                    Coordinate *verticalCord = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kVerticalLine];
                    [posibleMoves addObject:verticalCord];
                    
                }
            }
            
            if (j<game.dotsCount - 1) {
                
                if (game.horizontalLines[i][j]) {
                    
                    Coordinate *horizontalCord = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kHorizontalLine];
                    [posibleMoves addObject:horizontalCord];
                    
                }
            }
        }
    }
    
    return posibleMoves;
}

-(Coordinate*)makeMove {
    NSArray *posibleMoves = [self getPosibleMoves];
    
    NSMutableArray *boxMoves = [[NSMutableArray alloc] init];
    NSMutableArray *noBoxMoves = [[NSMutableArray alloc] init];
    
    for (Coordinate *line in posibleMoves) {
        NSArray *boxes = [game checkForBoxes:line];
        if ([boxes count] > 0) {
            [boxMoves addObject:line];
        } else {
            //When there AI can't make box
            //TO-DO have to check if other player will make box after AI turn
            [noBoxMoves addObject:line];
        }
    }
    
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
