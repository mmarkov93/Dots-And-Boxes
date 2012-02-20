//
//  ComputerEasy.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComputerEasy.h"
#import "FieldService.h"

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



-(Coordinate*)makeMove {
    FieldService *fieldService = [[FieldService alloc] initWithVerticalLines:game.verticalLines HorizontalLines:game.horizontalLines AndDotsCount:game.dotsCount];
    NSArray *posibleMoves = [self getPosibleMoves];
    [self print:posibleMoves];
    NSMutableArray *boxMoves = [[NSMutableArray alloc] init];
    NSMutableArray *noBoxMoves = [[NSMutableArray alloc] init];
    

    
    
    for (Coordinate *line in posibleMoves) {
        int lines = [fieldService checkForMaxNumberOfLines:line];
        if (lines == 3) {
            [boxMoves addObject:line];
        } else if (lines < 2){
            [noBoxMoves addObject:line];
        } 
    }
    //NSLog(@"Box Moves:%d", [boxMoves count]);
    if ([boxMoves count] > 0) {
        int randomBox = arc4random() % ([boxMoves count]);
        return [boxMoves objectAtIndex:randomBox];
    } else if ([noBoxMoves count] > 0) {
        int randomNoBox = arc4random() % ([noBoxMoves count]);
        return [noBoxMoves objectAtIndex:randomNoBox];
    }
    
    int random = arc4random() % ([posibleMoves count]);
    
    return [posibleMoves objectAtIndex:random];
}

-(void) dealloc {
    [game release];
    [super dealloc];
}

@end
