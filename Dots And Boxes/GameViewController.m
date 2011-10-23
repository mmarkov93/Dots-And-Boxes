//
//  GameViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"


@implementation GameViewController

-(void)touchUpInside:(id)sender {
    NSLog(@"TouchUpInside :%@", [[sender titleLabel] text]);
}

-(void)touchUpOutside:(id)sender {
    NSLog(@"TouchUpOutside :%@", [[sender titleLabel] text]);
}

-(void)touchCancel:(id)sender {
    NSLog(@"TouchCancel :%@",[[sender titleLabel] text]);
}

-(void)touchDown:(id)sender {
    NSLog(@"TouchDown :%@", [[sender titleLabel] text]);
}

-(void)dragInside:(id)sender {
    NSLog(@"DragInside :%@", [[sender titleLabel] text]);
}

-(void)dragOutside:(id)sender {
    NSLog(@"DragOutside :%@", [[sender titleLabel] text]);
}

-(void)dragExit:(id)sender {
    NSLog(@"DragExit :%@", [[sender titleLabel] text]);
}

-(void)dragEnter:(id)sender {
    NSLog(@"DragEnter :%@", [[sender titleLabel] text]);
}


-(void)createButton {
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.text = [NSString stringWithFormat:@"button%d", i];
        
        [button setBackgroundImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(touchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
        [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
        [button addTarget:self action:@selector(dragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        [button addTarget:self action:@selector(dragExit:) forControlEvents:UIControlEventTouchDragExit];
        [button addTarget:self action:@selector(dragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        
        button.frame = CGRectMake(100, 100 + i*10, 40, 5);
        
        
        [self.view addSubview:button];
    }
    
}

-(IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
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
    [self createButton];
    [super viewDidLoad];
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
