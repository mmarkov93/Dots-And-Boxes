//
//  Game.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"


@interface Game : NSObject {
    Player *player1;
    Player *player2;
}

@property (nonatomic, retain) Player *player1;
@property (nonatomic, retain) Player *player2;


@end
