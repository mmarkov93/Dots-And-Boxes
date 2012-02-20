//
//  RootViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "OnePlayerViewController.h"
#import "TwoPlayersViewController.h"



@implementation RootViewController

-(IBAction)onePlayerButtonPressed {
    OnePlayerViewController *onePlayerController = nil;
    if (UI_USER_INTERFACE_IDIOM()) {
        onePlayerController = [[OnePlayerViewController alloc] initWithNibName:@"OnePlayerViewController-iPad" bundle:nil];
    } else {
        onePlayerController = [[OnePlayerViewController alloc] initWithNibName:@"OnePlayerViewController" bundle:nil];
    }
    [self.navigationController pushViewController:onePlayerController animated:YES];    
    [onePlayerController release];
}

-(IBAction)twoPlayerButtonPressed {
    TwoPlayersViewController *twoPlayersController = nil;
    if (UI_USER_INTERFACE_IDIOM()) {
        twoPlayersController = [[TwoPlayersViewController alloc] initWithNibName:@"TwoPlayersViewController-iPad" bundle:nil];
    } else {
        twoPlayersController = [[TwoPlayersViewController alloc] initWithNibName:@"TwoPlayersViewController" bundle:nil];
    }
    [self.navigationController pushViewController:twoPlayersController animated:YES];[twoPlayersController release];    
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
    // Do any additional setup after loading the view from its nib.
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
