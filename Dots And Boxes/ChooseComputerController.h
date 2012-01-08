//
//  ChooseFieldController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseComputerController : UIViewController {
    int choosenIndex;
}

@property (readonly) int chosenIndex;

-(IBAction)buttonPressed:(id)sender;

@end
