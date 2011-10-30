//
//  GameViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

#define fieldSize   280
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface GameViewController : UIViewController {
    Game *game;
    int lineLength;
    int dotSize;
}

@property (nonatomic, retain) Game *game;
@property int lineLength;
@property int dotSize;

-(IBAction)backButtonPressed;

@end
