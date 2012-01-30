//
//  ComputerEasy.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Game.h"
#import "Coordinate.h"

@interface ComputerEasy : Player {
    Game *game;
}

@property (nonatomic, retain) Game *game;

-(NSArray*)getPosibleMoves;
-(Coordinate*)makeMove;

@end
