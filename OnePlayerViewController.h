//
//  OnePlayerViewController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseComputerController.h"
#import "ChooseFieldController.h"

@interface OnePlayerViewController : UIViewController {
    ChooseComputerController *chooseComputerController;
    ChooseFieldController *chooseFieldController;
}

@property (nonatomic, retain) ChooseComputerController *chooseComputerController;
@property (nonatomic, retain) ChooseFieldController *chooseFieldController;

-(IBAction)startButtonPressed;
-(IBAction)backButtonPressed;

@end
