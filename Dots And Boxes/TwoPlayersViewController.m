//
//  TwoPlayersViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwoPlayersViewController.h"
#import "GameViewController.h"


@implementation TwoPlayersViewController

@synthesize chooseFieldController;

-(IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)startButtonPressed {
    
    GameViewController *gameController = nil;
    if (UI_USER_INTERFACE_IDIOM()) {
        gameController = [[GameViewController alloc] initWithNibName:@"GameViewController-iPad" bundle:nil];
    } else {
        gameController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];    
    }    
    gameController.game = [[Game alloc] initWithBoxCount:chooseFieldController.chosenIndex];
    
    
    Player *player1 = [[Player alloc] initWithColor:@"blue" Name:@"Player1"];
    Player *player2 = [[Player alloc] initWithColor:@"red" Name:@"Player2"];    
    
    gameController.game.player1 = player1;
    gameController.game.player2 = player2;
    gameController.game.currentPlayer = player1;
    
    [self.navigationController pushViewController:gameController animated:YES];
    
    [player1 release];
    [player2 release];
    [gameController release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [chooseFieldController release];
    
    [super dealloc];
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
    
    chooseFieldController = [[ChooseFieldController alloc] initWithNibName:[NSString stringWithFormat: @"ChooseFieldController%@", iPadString] bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM()) {
        chooseFieldController.view.frame = CGRectMake(118, 0, chooseFieldController.view.frame.size.width, chooseFieldController.view.frame.size.height);
    } else {
        chooseFieldController.view.frame = CGRectMake(50, 11, chooseFieldController.view.frame.size.width, chooseFieldController.view.frame.size.height);
    }
    
    [self.view addSubview:chooseFieldController.view];
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