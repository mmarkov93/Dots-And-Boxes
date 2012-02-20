//
//  GameViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Game.h"

#define fieldSizeIPhone 280
#define fieldSizeIPad   688
#define dotSizeIPhone  15
#define dotSizeIPad    30
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface GameViewController : UIViewController<ADBannerViewDelegate> {
    Game *game;
    int lineLength;
    int dotSize;
    int fieldSize;
    
    ADBannerView *adView;
    BOOL banerIsVisible;
    
    UIButton *backButton;
      
    UIImageView *player2Image;
    UIImageView *p1Units;
    UIImageView *p1Tens;
    UIImageView *p2Units;
    UIImageView *p2Tens;
    
    UIImageView *p1Arrow;
    UIImageView *p2Arrow;
}

@property (nonatomic, assign) BOOL bannerIsVisible;

@property (nonatomic, retain) Game *game;
@property int lineLength;
@property int dotSize;
@property int fieldSize;

@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property (nonatomic, retain) IBOutlet UIImageView *player2Image;
@property (nonatomic, retain) IBOutlet UIImageView *p1Units;
@property (nonatomic, retain) IBOutlet UIImageView *p1Tens;
@property (nonatomic, retain) IBOutlet UIImageView *p2Units;
@property (nonatomic, retain) IBOutlet UIImageView *p2Tens;

@property (nonatomic, retain) IBOutlet UIImageView *p1Arrow;
@property (nonatomic, retain) IBOutlet UIImageView *p2Arrow;

-(IBAction)backButtonPressed;

@end
