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

@synthesize chainDictionary;


-(id) initWithColor:(NSString *)inColor Name:(NSString *)inName {
    self = [super init];
    if (self) {
        color = inColor;
        name = inName;
        chainDictionary = [[NSMutableDictionary alloc] init];
    }
    return (self);
}

-(void) dealloc {
    [chainDictionary release];
    
    [super dealloc];
}


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
//        NSLog(@"Box row:%d column:%d", row, column);
        if ((coordinate.row > 0) && (box.up == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row - 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        } 
        
        if ((coordinate.row < (game.dotsCount - 2)) && (box.down == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row + 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        }
        
        if ((coordinate.column < (game.dotsCount - 2)) && (box.right == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column + 1 AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
        }       
        
        if ((coordinate.column > 0) && (box.left == 0) ) {
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

-(NSArray*)getChain:(Coordinate*) coordinate {
    NSMutableArray *chain = [[NSMutableArray alloc] init];
    
    int row = coordinate.row;
    int column = coordinate.column;
     
    int prevRow = coordinate.row;
    int prevColumn = coordinate.column;
    int posibleSequelChain = 4;
    BOOL chainContinued = true;
    
    BOOL isChain = true;
    
    while (isChain && chainContinued){
        chainContinued = false;
        Box *box = [self getBoxWithRow:row andColumn:column];
        int countOfSides = box.up + box.down + box.left + box.right;
        
        if (countOfSides == 2 || countOfSides == 3) {
            [chain addObject: [[Coordinate alloc] initWithRow:row Column:column AndObjectType:kBox]];
            
            
//            NSLog(@"Box row:%d column:%d", row, column);
            if ((row > 0) && (box.up == 0) && (row - 1 != prevRow) && !chainContinued) {
                Coordinate * coord = [[Coordinate alloc] initWithRow:row - 1 Column:column AndObjectType:kBox];
                if ([self containsTwoOrThreeSides:coord]) {
                    chainContinued = true;
                    prevRow = row;
                    prevColumn = column;
                    
                    row = row - 1;
                } 
            } else {
                posibleSequelChain -= 1;
            }
            
            if ((row < (game.dotsCount - 2)) && (box.down == 0) && (row + 1 != prevRow) && !chainContinued) {
                Coordinate * coord = [[Coordinate alloc] initWithRow:row + 1 Column:column AndObjectType:kBox];
                if ([self containsTwoOrThreeSides:coord]) {
                    chainContinued = true;
                    prevRow = row;
                    prevColumn = column;
                    
                    row = row + 1;
                } 
            } else {
                posibleSequelChain -= 1;
            }
            
            if ((column < (game.dotsCount - 2)) && (box.right == 0) && (column + 1 != prevColumn) && !chainContinued ) {
                Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column + 1 AndObjectType:kBox];
                if ([self containsTwoOrThreeSides:coord]) {
                    chainContinued = true;
                    prevRow = row;
                    prevColumn = column;
                    
                    column = column + 1;
                } 
            } else {
                posibleSequelChain -= 1;
            }      
            
            if ((column > 0) && (box.left == 0) && (column - 1 != prevColumn) && !chainContinued) {
                Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column-1 AndObjectType:kBox];
                if ([self containsTwoOrThreeSides:coord]) {
                    chainContinued = true;
                    prevRow = row;
                    prevColumn = column;
                    
                    column = column - 1;
                } 
            } else {
                posibleSequelChain -= 1;
            }    
            
            if (posibleSequelChain == 0) {
                isChain = false;
            }
            
        } else {
            isChain = false;
        }
        
    } 
    
    return chain;
}

-(BOOL) isBoxInOtherChains:(Coordinate*)coordinate{
    NSArray *longChains = [chainDictionary objectForKey:kLongChains];
    NSArray *shortChains = [chainDictionary objectForKey:kShortChains];
    
    for (NSArray *chain in longChains) {
        Coordinate *lastCoordOfChain = [chain lastObject];
        if ((lastCoordOfChain.row == coordinate.row) && (lastCoordOfChain.column == coordinate.column)) {
            return false;
        }    }   
    
    for (NSArray *chain in shortChains) {
        Coordinate *lastCoordOfChain = [chain lastObject];
        if ((lastCoordOfChain.row == coordinate.row) && (lastCoordOfChain.column == coordinate.column)) {
            return false;
        }
    }
    return true;     
}

-(NSArray*)getAllChains {
    NSMutableArray *longChanins = [[NSMutableArray alloc] init];
    NSMutableArray *shortChains = [[NSMutableArray alloc] init];
    
    [chainDictionary removeAllObjects];
    [chainDictionary setObject:longChanins forKey:kLongChains];
    [chainDictionary setObject:shortChains forKey:kShortChains];
    
    for (int i=0; i<game.dotsCount - 1; i++) {
        for (int j=0; j<game.dotsCount - 1; j++) {
            Coordinate *boxCoordinate = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kBox];
            
            if ([self isBeginingOfChain:boxCoordinate]) {
                
                if ([self isBoxInOtherChains:boxCoordinate]) {

                    
                    NSArray *chain = [self getChain:boxCoordinate];
                    if ([chain count] > 2) {
                        [longChanins addObject:chain];
                        NSLog(@"Chain");
                        
                    } else if ([chain count] > 0) {
                        [shortChains addObject:chain];
                    }
                }
            }
            
            [boxCoordinate release];            
        }
    }
    
    NSLog(@"lChains: %d", [longChanins count]);
    NSLog(@"sChains: %d", [shortChains count]);


     
    NSLog(@"Long Chains : %d", [[chainDictionary objectForKey:kLongChains] count]);
    NSLog(@"Short Chains: %d", [[chainDictionary objectForKey:kShortChains] count]);
    
    
    return longChanins;
}

-(Coordinate*)makeMove {
    [self getAllChains];
    
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
    
    
    return [posibleMoves objectAtIndex:random];
    
}

@end
