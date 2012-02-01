//
//  TwoPlayersViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseFieldController.h"

@interface TwoPlayersViewController : UIViewController {
    ChooseFieldController *chooseFieldController;
}

@property (nonatomic, retain) ChooseFieldController* chooseFieldController;

-(IBAction)backButtonPressed;
-(IBAction)startButtonPressed;

@end