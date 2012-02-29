//
//  WinnerAlertView.m
//  Dots And Boxes
//
//  Created by Martin Markov on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WinnerAlertView.h"

@implementation WinnerAlertView

@synthesize backgroundImage, playerImage, statusImage;

-(void)exit {
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)addExitButton {
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.backgroundColor = [UIColor clearColor];
    exitButton.frame = CGRectMake(0, 0, self.backgroundImage.size.width, backgroundImage.size.height);
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exitButton];
}

-(id)initWithText:(NSString *)text {
    if (self = [super init]) {
        self.backgroundImage = [UIImage imageNamed:[NSString stringWithFormat: @"backgroundAlert%@.png", iPadString]];
        self.statusImage = [UIImage imageNamed:[NSString stringWithFormat: @"winsTheGameImage%@.png", iPadString]];
        
        if (text == kPlayer1Wins) {
            self.playerImage = [UIImage imageNamed:[NSString stringWithFormat: @"player1ImageCenter%@.png",iPadString]];
        } else if (text == kPlayer2Wins) {
            self.playerImage = [UIImage imageNamed:[NSString stringWithFormat: @"player2ImageCenter%@.png",iPadString]];
        } else if (text == kComputerWins) {
            self.playerImage = [UIImage imageNamed:[NSString stringWithFormat: @"computerImageCenter%@.png",iPadString]];
        } else if (text == kGameIsTie) {
            self.playerImage = nil;
            self.statusImage = [UIImage imageNamed:[NSString stringWithFormat:@"tieImage%@.png", iPadString]];
        }
    
        [self addExitButton];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGSize backgroundSize = self.backgroundImage.size;
    CGSize playerSize = self.playerImage.size;
    CGSize statusSize = self.statusImage.size;
    
    [self.backgroundImage drawInRect:CGRectMake(0, 0, backgroundSize.width, backgroundSize.height)];
    [self.playerImage drawInRect:CGRectMake((backgroundSize.width - playerSize.width) / 2, 20, playerSize.width, playerSize.height)];
    [self.statusImage drawInRect:CGRectMake((backgroundSize.width-statusSize.width)/2, playerSize.height + 30, statusSize.width, statusSize.height)];
}

-(void)layoutSubviews { 
    for (UIView *sub in self.subviews) {
        if ([sub class] == [UIImageView class] && sub.tag == 0) {
            [sub removeFromSuperview];
            break;
        }
    }
}

-(void)show {
    [super show];
    
    CGSize backgroundSize = self.backgroundImage.size;
    
    self.bounds = CGRectMake(0, 0, backgroundSize.width, backgroundSize.height);
}

@end
