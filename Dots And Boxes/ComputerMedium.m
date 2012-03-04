//
//  ComputerMedium.m
//  Dots And Boxes
//
//  Created by Martin Markov on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComputerMedium.h"
#import "Box.h"
#import "FieldService.h"

@implementation ComputerMedium

@synthesize shortChains, longChains;


-(id) initWithColor:(NSString *)inColor Name:(NSString *)inName {
    self = [super init];
    if (self) {
        color = inColor;
        name = inName;
        shortChains = [[NSMutableArray alloc] init];
        longChains = [[NSMutableArray alloc] init];
    }
    return (self);
}

-(void) dealloc {
    [shortChains release];
    [longChains release];
    
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
        if ((coordinate.row > 0) && (box.up == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row - 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
            [coord release];
        } 
        
        if ((coordinate.row < (game.dotsCount - 2)) && (box.down == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row + 1 Column:column AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
            [coord release];
        }
        
        if ((coordinate.column < (game.dotsCount - 2)) && (box.right == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column + 1 AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
            [coord release];
        }       
        
        if ((coordinate.column > 0) && (box.left == 0) ) {
            Coordinate * coord = [[Coordinate alloc] initWithRow:row Column:column-1 AndObjectType:kBox];
            if ([self containsTwoOrThreeSides:coord]) {
                countOfBoxesAround += 1;
            }
            [coord release];
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
            
            if ((row > 0) && (box.up == 0) && (row - 1 != prevRow) && !chainContinued) {
                Coordinate * coord = [[Coordinate alloc] initWithRow:row - 1 Column:column AndObjectType:kBox];
                if ([self containsTwoOrThreeSides:coord]) {
                    chainContinued = true;
                    prevRow = row;
                    prevColumn = column;
                    
                    row = row - 1;
                } 
                [coord release];
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
                [coord release];
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
                [coord release];
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
                [coord release];
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

-(void)getAllChains {
    [shortChains removeAllObjects];
    [longChains removeAllObjects];
    
    for (int i=0; i<game.dotsCount - 1; i++) {
        for (int j=0; j<game.dotsCount - 1; j++) {
            Coordinate *boxCoordinate = [[Coordinate alloc] initWithRow:i Column:j AndObjectType:kBox];
            
            if ([self isBeginingOfChain:boxCoordinate]) {
                
                if ([self isBoxInOtherChains:boxCoordinate]) {

                    
                    NSArray *chain = [self getChain:boxCoordinate];
                    if ([chain count] > 2) {
                        [longChains addObject:chain];
                    } else if ([chain count] > 0) {
                        [shortChains addObject:chain];
                    }
                }
            }
            
            [boxCoordinate release];            
        }
    }   
    
}

-(BOOL)isInLongChain:(Coordinate*) box {
    for (NSArray *chain in longChains) {
        for (Coordinate *coord in chain) {
            if (coord.row == box.row && coord.column == box.column) {
                return YES;
            }
        }
    }
    return NO;
}

-(void)printChains {
    for (NSArray *chain in longChains) {
        NSLog(@"\nLongChain%d",[chain count]);
        for (Coordinate *cord in chain) {
            NSLog(@"\nrow:%d column:%d", cord.row, cord.column);
        }
    
    }   
    
    for (NSArray *chain in shortChains) {
        NSLog(@"\nShortChain%d",[chain count]);
        for (Coordinate *cord in chain) {
            NSLog(@"\nrow:%d column:%d", cord.row, cord.column);
        }
        
    }

    
}

-(BOOL)isSingleBox:(Coordinate*) box {
    for (NSArray *chain in shortChains) {
        
        for (Coordinate *coord in chain) {
            
            if (coord.row == box.row && coord.column == box.column) {
                if ([chain count] == 1) {
                    return YES;
                }
                
            }
        }
    }
    return NO;
}

-(Coordinate*)getLastMove:(Coordinate*) boxCoordinate andLine:(Coordinate*) line {
    Box* box = [self getBoxWithRow:boxCoordinate.row andColumn:boxCoordinate.column];
    
    if (box.left == 0 && (boxCoordinate.row != line.row || boxCoordinate.column != line.column)) {
        return [[Coordinate alloc] initWithRow:boxCoordinate.row Column:boxCoordinate.column AndObjectType:kVerticalLine];
    }
    
    if (box.right == 0 && (boxCoordinate.row != line.row || (boxCoordinate.column + 1 != line.column))) {
        return [[Coordinate alloc] initWithRow:boxCoordinate.row Column:boxCoordinate.column + 1 AndObjectType:kVerticalLine];
    }
    
    if (box.up == 0 && (boxCoordinate.row != line.row || boxCoordinate.column != line.column)) {
        return [[Coordinate alloc] initWithRow:boxCoordinate.row Column:boxCoordinate.column AndObjectType:kHorizontalLine];
    }
    
    if (box.down == 0 && ((boxCoordinate.row + 1 != line.row) || boxCoordinate.column != line.column)) {
        return [[Coordinate alloc] initWithRow:boxCoordinate.row + 1 Column:boxCoordinate.column AndObjectType:kHorizontalLine];
    }
    
    return nil;
}
-(Coordinate*)getBestMove:(NSArray*)boxMoves {
    FieldService *fieldService = [[FieldService alloc] initWithVerticalLines:game.verticalLines HorizontalLines:game.horizontalLines AndDotsCount:game.dotsCount];
     
    Coordinate *lastMove = nil;
    BOOL shortChainMove = YES;
    
    for (Coordinate *coord in boxMoves) {
        NSArray *boxes = [fieldService checkForBoxes:coord];
        if ([boxes count] == 2) {
            return coord;
        } else {
            Coordinate *currBox = [boxes objectAtIndex:0];
            if ([self isSingleBox:currBox]) {
                return coord;
            }
            
            if ([self isInLongChain:currBox]) {
                return coord;
            }

            if (([shortChains count] % 2) == 0 || ([longChains count] == 0 || [boxMoves count] > 1 )) {
                lastMove = coord;
                shortChainMove = NO;
            } else if(shortChainMove){
                NSArray *lastBoxes = [fieldService getBoxesAroundLine:coord];
                
                Box *box;
                for (Coordinate *lastBoxCoordinate in lastBoxes) {
                    box = [self getBoxWithRow:lastBoxCoordinate.row andColumn:lastBoxCoordinate.column]; 
                    if ([box getSidesCount] < 3 ) {
                        lastMove = [self getLastMove:lastBoxCoordinate andLine:coord];
                                            
                        break;
                    }
                }
            }
        }
       
    }
    
    return lastMove;
}

-(BOOL)containsOneSegmentChain {
    for (NSArray *chain in shortChains) {
        if ([chain count] == 1) {
            return true;
        }
    }
    
    return false;
}

-(Coordinate*)getCommonSideOFBoxes:(NSArray*) boxes {
    Coordinate *box1 = [boxes objectAtIndex:0];
    Coordinate *box2 = [boxes objectAtIndex:1];
    
    int row = box1.row - box2.row;
    int column = box1.column - box2.column;
    
    if (column == -1) {
        return [[Coordinate alloc] initWithRow:box2.row Column:box2.column AndObjectType:kVerticalLine];
    }
    if (row == -1) {
        return [[Coordinate alloc] initWithRow:box2.row Column:box2.column AndObjectType:kHorizontalLine];
    }
    
    return nil;
}

-(Coordinate*)makeShortChainMove {
    if ([self containsOneSegmentChain]) {
        for (NSArray *chain in shortChains) {
            if ([chain count] == 1) {
                Coordinate *box = [chain objectAtIndex:0];
                Coordinate *fakeCoordinate = [[Coordinate alloc] initWithRow:box.row+2 Column:box.row + 2 AndObjectType:kVerticalLine];
                return [self getLastMove:box andLine:fakeCoordinate];
            }
        }
    }  
    
    NSArray *twoBoxes = [shortChains objectAtIndex:0];
    Coordinate *commonSide = [self getCommonSideOFBoxes:twoBoxes];
    
        
    if (([shortChains count] % 2) == 0) {
        return [self getLastMove:[twoBoxes objectAtIndex:0] andLine:commonSide];
    } else {
        return commonSide; 
    }
    return nil;
}

-(Coordinate*)makeMove {
    FieldService *fieldService = [[FieldService alloc] initWithVerticalLines:game.verticalLines HorizontalLines:game.horizontalLines AndDotsCount:game.dotsCount];
    
    [self getAllChains];
    
    NSArray *posibleMoves = [self getPosibleMoves];
    //[self print:posibleMoves];
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
    
    if ([boxMoves count] > 0) {
        if ([noBoxMoves count] > 0) {
            int randomBox = arc4random() % ([boxMoves count]);
            return [boxMoves objectAtIndex:randomBox];
        } else {
            
            Coordinate *coord = [self getBestMove:boxMoves];
            if (coord != nil) {
                return coord;
            }
 
        }
    } else if ([noBoxMoves count] > 0) {
        int randomNoBox = arc4random() % ([noBoxMoves count]);
        return [noBoxMoves objectAtIndex:randomNoBox];
    }
    
    if ([noBoxMoves count] == 0) {
        if ([shortChains count] > 0) {
            Coordinate* lastMove = [self makeShortChainMove];
            if (lastMove != nil) {
                return lastMove;
            } 
        }
    }
    
    int random = arc4random() % ([posibleMoves count]);
    
    
    [fieldService release];
    return [posibleMoves objectAtIndex:random];
    
}


                

@end
