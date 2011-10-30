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

-(void)drawSqaresWithCoordinates:(NSArray*) coordinates {
    UIImage *sqareImage = [UIImage imageNamed:@"BlueSquare.png"];
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2;
    
    for (Coordinate *coordinate in coordinates) {
        int row = coordinate.row;
        int column = coordinate. column;
        
        UIImageView *sqareImageView1 = [[UIImageView alloc] initWithImage:sqareImage];
        sqareImageView1.frame = CGRectMake(startPointX + column*lineLength + (column+1)*dotSize, 
                                           startPointY + row*lineLength + (row+1)*dotSize, 
                                           lineLength, lineLength);
        [self.view addSubview:sqareImageView1];
        [sqareImageView1 release];
    }
    
}

-(void)touchUpInside:(id)sender {
    LineButton *currentButton = (LineButton*) sender;
    currentButton.enabled = false;
    Coordinate *coordinate = [currentButton coordinate];
    if (coordinate.objectType == kVerticalLine) {
        game.verticalLines[coordinate.row][coordinate.column] = 1;
    } else {
        game.horizontalLines[coordinate.row][coordinate.column] = 1;
    }
    
    [self drawSqaresWithCoordinates:[game checkForBoxes:coordinate]];
    
    
    
//    NSLog(@"Row:%d  Column:%d", [coordinate row], [coordinate column]);
    //    NSLog(@"TouchUpInside :%@", [[sender titleLabel] text]);
}

-(void)touchUpOutside:(id)sender {
    NSLog(@"TouchUpOutside :%@", [[sender titleLabel] text]);
}



-(void)touchDown:(id)sender {
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:[UIImage imageNamed:@"HorizontLine.png"]forState:UIControlStateNormal];
//    NSLog(@"TouchDown :%@", [[sender titleLabel] text]);
}

-(void)dragInside:(id)sender {
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:[UIImage imageNamed:@"HorizontLine.png"]forState:UIControlStateNormal];
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
        [button setBackgroundImage:[UIImage imageNamed:@"HorizontLine.png"] forState:UIControlStateDisabled];
    } else {
        //add image for Vertical Line
        [button setBackgroundImage:[UIImage imageNamed:@"HorizontLine.png"] forState:UIControlStateDisabled];
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
                Coordinate *horizontalCoordinate = [[Coordinate alloc] init];
                horizontalCoordinate.row = j;
                horizontalCoordinate.column = i;
                horizontalCoordinate.objectType = kHorizontalLine;
                CGRect horizontalButtonRect = CGRectMake(startPointX + i*lineLength + (i+1)*dotSize, 
                                                         startPointY + j*lineLength + j*dotSize, 
                                                         lineLength, dotSize);
                [self addLineButtonWithFrame:horizontalButtonRect coordinate:horizontalCoordinate];
                [horizontalCoordinate release];
            }
            
            if (j < (dotsCount - 1)) {
                Coordinate *verticalCoordinate = [[Coordinate alloc] init];
                verticalCoordinate.row = j;
                verticalCoordinate.column = i;
                verticalCoordinate.objectType = kVerticalLine;
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
    //    [self createButton];
    game = [[Game alloc] init];
    int dotsCount = [game dotsCount];
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
