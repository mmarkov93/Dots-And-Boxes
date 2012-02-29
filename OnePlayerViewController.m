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
    
    GameViewController *gameController = [[GameViewController alloc] initWithNibName:[NSString stringWithFormat:@"GameViewController%@", iPadString] bundle:nil];
    
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
        default:
            break;
    }
    
    player2.game = gameController.game;
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
    [chooseComputerController release];
    
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
    chooseComputerController = [[ChooseComputerController alloc] initWithNibName:[NSString stringWithFormat:@"ChooseComputerController%@", iPadString] bundle:nil];
    chooseFieldController = [[ChooseFieldController alloc] initWithNibName:[NSString stringWithFormat:@"ChooseFieldController%@", iPadString] bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM()) {
        int width = chooseComputerController.view.frame.size.width;
        int height = chooseComputerController.view.frame.size.height;
        chooseComputerController.view.frame = CGRectMake(118, 0, width, height);
        
        chooseFieldController.view.frame = CGRectMake(118, height + 18, chooseFieldController.view.frame.size.width, chooseFieldController.view.frame.size.height);

    } else {
        int width = chooseComputerController.view.frame.size.width;
        int height = chooseComputerController.view.frame.size.height;
        chooseComputerController.view.frame = CGRectMake(50, 0, width, height);
        
        chooseFieldController.view.frame = CGRectMake(50, height + 5, chooseFieldController.view.frame.size.width, chooseFieldController.view.frame.size.height);
        
    }
    
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
