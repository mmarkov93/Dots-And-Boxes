//
//  WinnerAlertView.h
//  Dots And Boxes
//
//  Created by Martin Markov on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPlayer1Wins    @"Player1Wins"
#define kPlayer2Wins    @"Player2Wins"
#define kComputerWins   @"ComputerWins"
#define kGameIsTie      @"GameIsTie"

@interface WinnerAlertView : UIAlertView {
    UIImage *backgroundImage;
    UIImage *playerImage;
    UIImage *statusImage;
}

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *playerImage;
@property (nonatomic, retain) UIImage *statusImage;

-(id)initWithText: (NSString*)text;

-(void)addExitButton;
-(void)exit;

@end
