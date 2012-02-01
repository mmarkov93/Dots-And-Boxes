//
//  OnePlayerViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnePlayerViewController.h"
#import "GameViewController.h"
#import "ComputerEasy.h"
#import "ComputerMedium.h"

@implementation OnePlayerViewController

@synthesize chooseComputerController;
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
    ComputerEasy *player2;
    
    int chosenComputer = chooseComputerController.chosenIndex;
    switch (chosenComputer) {
        case 1:
            player2 = [[ComputerEasy alloc] initWithColor:@"red" Name:@"Computer"];    
            break;
        case 2:
            player2 = [[ComputerMedium alloc] initWithColor:@"red" Name:@"Computer"];
            //TODO alloc ComputerHard
        default:
            break;
    }
    
    player2.game = gameController.game;
    gameController.game.player1 = player1;
    gameController.game.player2 = player2;
    gameController.game.currentPlayer = player1;
    [player1 release];
    [player2 release];
    
    [self.navigationController pushViewController:gameController animated:YES];
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
    chooseComputerController = [[ChooseComputerController alloc] initWithNibName:@"ChooseComputerController" bundle:nil];
    int width = chooseComputerController.view.frame.size.width;
    int height = chooseComputerController.view.frame.size.height;
    int marginTop = 50;
    
    chooseComputerController.view.frame = CGRectMake(0, marginTop, width, height);

    chooseFieldController = [[ChooseFieldController alloc] initWithNibName:@"ChooseFieldController" bundle:nil];
    chooseFieldController.view.frame = CGRectMake(0, 50 + height + 20, chooseFieldController.view.frame.size.width, chooseFieldController.view.frame.size.height);
    
    [self.view addSubview:chooseFieldController.view];    
    [self.view addSubview:chooseComputerController.view];
    
    
    
    [super viewDidLoad];
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
