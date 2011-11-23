//
//  GameViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "LineButton.h"
#import "Game.h"
#import "Coordinate.h"


@implementation GameViewController

@synthesize game;
@synthesize lineLength, dotSize;
@synthesize verticalButtons, horizontalButtons;

@synthesize player1ScoreLabel, player2ScoreLabel, currentPlayerLabel;

-(void)drawSqaresWithCoordinates:(NSArray*) coordinates {
    //UIImage *sqareImage = [UIImage imageNamed:@"BlueSquare.png"];
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2;
    
    for (Coordinate *coordinate in coordinates) {
        int row = coordinate.row;
        int column = coordinate. column;
        
        UIImageView *sqareImageView1 = [[UIImageView alloc] initWithImage:[game.currentPlayer getPlayerBoxImage]];
        sqareImageView1.frame = CGRectMake(startPointX + column*lineLength + (column+1)*dotSize, 
                                           startPointY + row*lineLength + (row+1)*dotSize, 
                                           lineLength, lineLength);
        [self.view addSubview:sqareImageView1];
        [sqareImageView1 release];
    }
    
}

-(void)updateView {
    player1ScoreLabel.text = [NSString stringWithFormat:@"%d",game.player1.boxesCount];
    player2ScoreLabel.text = [NSString stringWithFormat:@"%d",game.player2.boxesCount];
    currentPlayerLabel.text = game.currentPlayer.name;
}

-(void)touchUpInside:(id)sender {
    LineButton *currentButton = (LineButton*) sender;
    [currentButton setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage] forState:UIControlStateDisabled];
    currentButton.enabled = false;
    Coordinate *coordinate = [currentButton coordinate];
    if (coordinate.objectType == kVerticalLine) {
        game.verticalLines[coordinate.row][coordinate.column] = 1;
    } else {
        game.horizontalLines[coordinate.row][coordinate.column] = 1;
    }
    
    
    
    
    
    if (currentButton.coordinate.row == 0) {
        UIButton *button = (UIButton*)[self.view viewWithTag:22];
        [button setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage] forState:UIControlStateDisabled];
        button.enabled = false;
    }
    
    
    
    
    
    NSArray *boxes  = [game checkForBoxes:coordinate];
    [game putBoxes:boxes];
    if ([boxes count] > 0) {
        game.currentPlayer.boxesCount +=[boxes count];
        [self drawSqaresWithCoordinates:boxes];
    } else {
        [game changeCurrentPlayer];
    }
    
    if ((game.player1.boxesCount + game.player2.boxesCount) == pow((game.dotsCount-1), 2)) {
        UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"WIN" message:[NSString stringWithFormat:@"%@ wins the game", game.currentPlayer.name]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [winAlert show];
        [winAlert release];
    }
    
    [self updateView];
}

-(void)touchUpOutside:(id)sender {
    NSLog(@"TouchUpOutside :%@", [[sender titleLabel] text]);
}



-(void)touchDown:(id)sender {
    
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage]forState:UIControlStateNormal];
//    NSLog(@"TouchDown :%@", [[sender titleLabel] text]);
}

-(void)dragInside:(id)sender {
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage] forState:UIControlStateNormal];
    NSLog(@"DragInside :%@", [[sender titleLabel] text]);
}

-(void)dragOutside:(id)sender {
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:nil forState:UIControlStateNormal];
    NSLog(@"DragOutside :%@", [[sender titleLabel] text]);
}

-(void)addLineButtonWithFrame:(CGRect) rect coordinate:(Coordinate*) coordinate {
    
    LineButton *button= [LineButton buttonWithType:UIButtonTypeCustom];
    button.coordinate = coordinate;
    
    if (coordinate.objectType == kHorizontalLine) {
        [button setBackgroundImage:[UIImage imageNamed:@"blueHorizontLine.png"] forState:UIControlStateDisabled];
    } else {
        //add image for Vertical Line
        [button setBackgroundImage:[UIImage imageNamed:@"blueHorizontLine.png"] forState:UIControlStateDisabled];
    }
    
    
    [button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(dragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    
    button.frame = rect;
    button.tag = coordinate.row * 10 + coordinate.column;
    [self.view addSubview:button];
}

-(void)createDotsAndLines {    
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2;
    
    UIImage *dotImage = [UIImage imageNamed:@"Dot.png"];
    
    //    double lineImageSizeRatio = lineImage.size.width/lineImage.size.height;
    
    int dotsCount = [game dotsCount];
    
    for (int i = 0; i < dotsCount; i++) {
        for (int j = 0; j < dotsCount; j++) {
            
            if (i < (dotsCount - 1)) {
                Coordinate *horizontalCoordinate = [[Coordinate alloc] initWithRow:j Column:i AndObjectType:kHorizontalLine];
                CGRect horizontalButtonRect = CGRectMake(startPointX + i*lineLength + (i+1)*dotSize, 
                                                         startPointY + j*lineLength + j*dotSize, 
                                                         lineLength, dotSize);
                [self addLineButtonWithFrame:horizontalButtonRect coordinate:horizontalCoordinate];
                [horizontalCoordinate release];
            }
            
            if (j < (dotsCount - 1)) {
                Coordinate *verticalCoordinate = [[Coordinate alloc] initWithRow:j Column:i AndObjectType:kVerticalLine];
                CGRect verticalButtonRect = CGRectMake(startPointX + i*lineLength + i*dotSize, 
                                                       startPointY + j*lineLength + (j+1)*dotSize, 
                                                       dotSize, lineLength);
                [self addLineButtonWithFrame:verticalButtonRect coordinate:verticalCoordinate];
                [verticalCoordinate release];
            }
            
            UIImageView *dotView = [[UIImageView alloc] initWithImage:dotImage];
            dotView.frame = CGRectMake(startPointX + i*lineLength + i*dotSize, 
                                       startPointY + j*lineLength + j*dotSize, 
                                       dotSize, dotSize);
            if (i == 0 & j == 0) {
                NSLog(@"Point x:%f y:%f", dotView.frame.origin.x, dotView.frame.origin.y);
            }
            
            [self.view addSubview:dotView];
            
            [dotView release];
        }
        
    }
}

-(IBAction)backButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    int dotsCount = [game dotsCount];
    NSLog(@"%d", dotsCount);
    dotSize = 15 - dotsCount;
    lineLength = (fieldSize - dotsCount*dotSize)/(dotsCount - 1);
    [self createDotsAndLines];
    
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
