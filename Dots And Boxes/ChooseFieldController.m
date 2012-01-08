//
//  ChooseFieldController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChooseFieldController.h"

@implementation ChooseFieldController

@synthesize chosenIndex;

-(IBAction)buttonPressed:(id)sender 
{
    UIButton *oldSelection= (UIButton*)[self.view viewWithTag:chosenIndex];
    oldSelection.enabled = TRUE;
    
    
    UIButton *newSelection = (UIButton*) sender;
    chosenIndex = newSelection.tag;
    newSelection.enabled = FALSE;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    chosenIndex = 5;
    UIButton *selection = (UIButton*)[self.view viewWithTag:chosenIndex];
    selection.enabled = FALSE;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
