//
//  FieldService.m
//  Dots And Boxes
//
//  Created by Martin Markov on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FieldService.h"

@implementation FieldService 

@synthesize verticalLines;
@synthesize horizontalLines;
@synthesize dotsCount;

-(id) initWithVerticalLines:(int**) initVerticalLines HorizontalLines:(int**) initHorizontalLines AndDotsCount:(int) initDotsCount {
    self = [super init];
    
    if (self != nil) {
        verticalLines = initVerticalLines;
        horizontalLines = initHorizontalLines;
        dotsCount = initDotsCount;
    }
    
    return self;
}

-(bool)checkForBoxAboveTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return ((verticalLines[row-1][column] == 1) && (verticalLines[row-1][column+1] == 1) && (horizontalLines [row-1][column] == 1));
}

-(bool)checkForBoxUnderTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return ((verticalLines[row][column] == 1) && (verticalLines[row][column+1] == 1) && (horizontalLines [row+1][column] == 1));
}

-(bool)checkForBoxLeftOFTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return ((horizontalLines[row][column-1] == 1) && (horizontalLines[row+1][column-1] == 1) && (verticalLines [row][column-1] == 1));
}

-(bool)checkForBoxRightOFTheLine:(Coordinate*)line {
    int row = line.row;
    int column = line.column;
    
    return ((horizontalLines[row][column] == 1) && (horizontalLines[row+1][column] == 1) && (verticalLines [row][column+1] == 1));
}

-(int)checkForMaxNumberOfLines:(Coordinate*) coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    ObjectType objectType = coordinate.objectType;
    int numOfLines1 = 0;
    int numOfLines2 = 0;
    
    if (objectType == kHorizontalLine) {
        //check for box above the line
        if (row > 0) {
            numOfLines1= verticalLines[row-1][column] + verticalLines[row-1][column+1] + horizontalLines[row-1][column];
        } 
        //check for box under the line
        if((column < dotsCount -1) && (row < dotsCount-1)) {
            numOfLines2 = verticalLines[row][column] + verticalLines[row][column+1] + horizontalLines[row+1][column];
        }
        
    } else if (objectType == kVerticalLine) {
        //check for box left of the line
        if (column > 0) {
            numOfLines1 = horizontalLines[row][column-1] + horizontalLines[row+1][column-1] + verticalLines[row][column-1];
        }
        
        //check for box right of the line
        if (column < dotsCount - 1) {
            numOfLines2 = horizontalLines[row][column] + horizontalLines[row+1][column] + verticalLines[row][column+1];
            
        }
        
    }
    
    return MAX(numOfLines1, numOfLines2);
    
}

-(NSArray*)checkForBoxes:(Coordinate *)coordinate {
    int row = coordinate.row;
    int column = coordinate.column;
    ObjectType objectType = coordinate.objectType;
    NSMutableArray *boxesArray = [[NSMutableArray alloc] init];
    
    
    
    
    if (objectType == kHorizontalLine) {
        //check for box above the line
        if (row > 0) {
            if ([self checkForBoxAboveTheLine:coordinate]) {
                Coordinate *box1Coordinate = [[Coordinate alloc] initWithRow:(row-1) Column:column AndObjectType:kBox];
                [boxesArray addObject:box1Coordinate];
                
                [box1Coordinate release];
                //                NSLog(@"Box row:%d column:%d", row-1, column);
            }
        }
        //check for box under the line
        if(column < dotsCount -1 & row < dotsCount-1) {
            if ([self checkForBoxUnderTheLine:coordinate]) {
                Coordinate *box2Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:kBox];
                [boxesArray addObject:box2Coordinate];
                
                [box2Coordinate release];
                //                NSLog(@"Box row:%d column:%d", row, column);
            }
        }
        
    } else if (objectType == kVerticalLine) {
        //check for box left of the line
        if (column > 0) {
            if ([self checkForBoxLeftOFTheLine:coordinate]) {
                Coordinate *box3Coordinate = [[Coordinate alloc] initWithRow:row Column:(column-1) AndObjectType:kBox];
                [boxesArray addObject:box3Coordinate];
                
                [box3Coordinate release];
                //NSLog(@"Box row:%d column:%d", row, column-1);
            }
        }
        
        //check for box right of the line
        if (column < dotsCount - 1) {
            if ([self checkForBoxRightOFTheLine:coordinate]) {
                Coordinate *box4Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:objectType];
                [boxesArray addObject:box4Coordinate];
                
                [box4Coordinate release];
                //                NSLog(@"Box row:%d column:%d", row, column);
            }
            
        }
        
    }

    return boxesArray;
}

-(NSArray*)getBoxesAroundLine:(Coordinate *)line {
    int row = line.row;
    int column = line.column;
    ObjectType objectType = line.objectType;
    NSMutableArray *boxesArray = [[NSMutableArray alloc] init];
    
    if (objectType == kHorizontalLine) {
        //check for box above the line
        if (row > 0) {
            
            Coordinate *box1Coordinate = [[Coordinate alloc] initWithRow:(row-1) Column:column AndObjectType:kBox];
            [boxesArray addObject:box1Coordinate];
            
            [box1Coordinate release];
            
        }
        //check for box under the line
        if(column < dotsCount -1 & row < dotsCount-1) {
            
            Coordinate *box2Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:kBox];
            [boxesArray addObject:box2Coordinate];
            
            [box2Coordinate release];
        }
        
    } else if (objectType == kVerticalLine) {
        //check for box left of the line
        if (column > 0) {
            Coordinate *box3Coordinate = [[Coordinate alloc] initWithRow:row Column:(column-1) AndObjectType:kBox];
            [boxesArray addObject:box3Coordinate];
            
            [box3Coordinate release];
        }
        
        //check for box right of the line
        if (column < dotsCount - 1) {
            
            Coordinate *box4Coordinate = [[Coordinate alloc] initWithRow:row Column:column AndObjectType:objectType];
            [boxesArray addObject:box4Coordinate];
            
            [box4Coordinate release];
        }
        
    }
    
    return boxesArray;
}

@end
