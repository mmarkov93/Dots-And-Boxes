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
#import "ComputerEasy.h"


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

-(void)drawLine:(Coordinate*) coordinate {
    if (coordinate.objectType == kHorizontalLine) {
        NSLog(@"ChooseHorizontal row:%d, column:%d", coordinate.row, coordinate.column);
    } else if (coordinate.objectType == kVerticalLine) {
        NSLog(@"ChooseVertical row:%d, column:%d", coordinate.row, coordinate.column);
    }
    
    
    int tag = coordinate.row*100 + coordinate.column*10 + 1;
    if (coordinate.objectType == kVerticalLine) {
        tag += 1;
    }
    
    UIButton *button = (UIButton*)[self.view viewWithTag:tag];
    [button setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage] forState:UIControlStateDisabled];
    button.enabled = false;
}



- (BOOL)playedMove:(Coordinate *)cord {
    if (cord.objectType == kVerticalLine) {
        game.verticalLines[cord.row][cord.column] = 1;
    } else {
        game.horizontalLines[cord.row][cord.column] = 1;
    }
    
    NSArray *boxes  = [game checkForBoxes:cord];
    [game putBoxes:boxes];
    if ([boxes count] > 0) {
        game.currentPlayer.boxesCount +=[boxes count];
        [self drawSqaresWithCoordinates:boxes];
    } else {
        [game changeCurrentPlayer];
    }
    
    [self updateView];
    if ((game.player1.boxesCount + game.player2.boxesCount) == pow((game.dotsCount-1), 2)) {
        UIAlertView *winAlert; 
        NSString *message;
        NSString *title = @"WIN";
        
        if (game.player1.boxesCount == game.player2.boxesCount) {
            message = @"The game is tie";
            title = @"TIE";
        } else if (game.player1.boxesCount > game.player2.boxesCount) {        
            message = [NSString stringWithFormat:@"%@ wins the game", game.player1.name];
        } else {
            message = [NSString stringWithFormat:@"%@ wins the game", game.player2.name];
        }

        winAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];        
        [winAlert show];
        [winAlert release];
        return false;
    }
    return true;
}

-(void)touchUpInside:(id)sender {
    LineButton *currentButton = (LineButton*) sender;
    [currentButton setBackgroundImage:[game.currentPlayer getPlayerHorizontalLineImage] forState:UIControlStateDisabled];
    currentButton.enabled = false;
    Coordinate *currentCord = [currentButton coordinate];
    [self playedMove:currentCord];

    BOOL gameFinish = true;
    while([game.currentPlayer isKindOfClass:[ComputerEasy class]] && gameFinish) {
        ComputerEasy *player2 = (ComputerEasy*) game.currentPlayer;
        Coordinate* cord = [player2 makeMove];
        [self drawLine:cord];
        gameFinish = [self playedMove:cord];
        
    }
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
        button.tag = coordinate.row * 100 + coordinate.column*10 + 1;
    } else {
        [button setBackgroundImage:[UIImage imageNamed:@"blueHorizontLine.png"] forState:UIControlStateDisabled];
        button.tag = coordinate.row * 100 + coordinate.column*10 + 2;
    }
    
    
    [button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(dragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    
    button.frame = rect;
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
