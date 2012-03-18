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

#define fieldSize   (iPad ? 688 : 288)
#define dotSizeGame    (iPad ? 30 : 15)
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface GameViewController : UIViewController<ADBannerViewDelegate> {
    Game *game;
    int lineLength;
    int dotSize;
    
    NSTimer *computerTimer;
    
    BOOL isUser;
    
    NSMutableArray *lineButtonsArray;
    CGPoint currentTouch;
    UIView *toMove;
    
    ADBannerView *adView;
    BOOL banerIsVisible;
    BOOL adIsShown;
    
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

@property (nonatomic, retain) IBOutlet UIButton *backButton;


@property (nonatomic, retain) IBOutlet UIImageView *player2Image;
@property (nonatomic, retain) IBOutlet UIImageView *p1Units;
@property (nonatomic, retain) IBOutlet UIImageView *p1Tens;
@property (nonatomic, retain) IBOutlet UIImageView *p2Units;
@property (nonatomic, retain) IBOutlet UIImageView *p2Tens;

@property (nonatomic, retain) IBOutlet UIImageView *p1Arrow;
@property (nonatomic, retain) IBOutlet UIImageView *p2Arrow;

-(IBAction)backButtonPressed;

-(void)showEndGameView;
-(void)changePlayers;
-(BOOL)isAdsRemovePurchased;
-(void)addImageToCurrentButton;
-(void)removeImageFromCurrentButton;
-(void)putImageToTheClosestTouch:(NSSet*)touches;

@end
