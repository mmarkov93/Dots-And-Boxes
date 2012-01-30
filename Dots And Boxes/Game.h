//
//  Game.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Coordinate.h"


@interface Game : NSObject {
    Player *player1;
    Player *player2;
    Player *currentPlayer;
    int **horizontalLines;
    int **verticalLines;
    int **boxes;
    int dotsCount;
}

@property int **horizontalLines;
@property int **verticalLines;
@property int **boxes;
@property (nonatomic, retain) Player *player1;
@property (nonatomic, retain) Player *player2;
@property (nonatomic, retain) Player *currentPlayer;
@property int dotsCount;

-(id) initWithBoxCount:(int) boxCount;-(void)putBoxes:(NSArray*) boxes;
-(void)changeCurrentPlayer;
-(NSArray*)checkForBoxes:(Coordinate*) coordinate;

@end
