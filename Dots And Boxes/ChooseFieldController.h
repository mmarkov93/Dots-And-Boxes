//
//  ChooseFieldController.h
//  Dots And Boxes
//
//  Created by Martin Markov on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseFieldController : UIViewController 
{
    int chosenIndex;
}

@property int chosenIndex;

-(IBAction)buttonPressed:(id)sender;

@end
