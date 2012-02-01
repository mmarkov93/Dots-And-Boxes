//
//  GameViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

#define fieldSizeIPhone 280
#define fieldSizeIPad   688
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface GameViewController : UIViewController {
    Game *game;
    int lineLength;
    int dotSize;
    int fieldSize;
    
    UILabel *player1ScoreLabel;
    UILabel *player2ScoreLabel;
    UILabel *currentPlayerLabel;
    NSMutableArray *horizontalButtons;
    NSMutableArray *verticalButtons;
}

@property (nonatomic, retain) Game *game;
@property int lineLength;
@property int dotSize;
@property int fieldSize;

@property (nonatomic, retain) IBOutlet UILabel *player1ScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *player2ScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentPlayerLabel;
@property (nonatomic, retain) NSMutableArray *horizontalButtons;
@property (nonatomic, retain) NSMutableArray *verticalButtons;

-(IBAction)backButtonPressed;

@end
