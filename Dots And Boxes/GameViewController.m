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

-(void)touchUpInside:(id)sender {
    LineButton *currentButton = (LineButton*) sender;
    currentButton.enabled = false;
    if (currentButton.lineType == kVerticalLine) {
        game.verticalLines[currentButton.row][currentButton.column] = 1;
    } else {
        game.horizontalLines[currentButton.row][currentButton.column] = 1;
    } 
    
    NSLog(@"Row:%d  Column:%d", [currentButton row], [currentButton column]);
    NSLog(@"TouchUpInside :%@", [[sender titleLabel] text]);
}

-(void)touchUpOutside:(id)sender {
    NSLog(@"TouchUpOutside :%@", [[sender titleLabel] text]);
}



-(void)touchDown:(id)sender {
    UIButton *currentButton = (UIButton*) sender;
    [currentButton setBackgroundImage:[UIImage imageNamed:@"HorizontLine.png"]forState:UIControlStateNormal];
    NSLog(@"TouchDown :%@", [[sender titleLabel] text]);
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

-(void)addLineButtonWithFrame:(CGRect) rect coordinate:(Coordinate*) coordinate andType:(Lines) type {
    int row = coordinate.row;
    int column = coordinate.column;
    
    LineButton *button= [LineButton buttonWithType:UIButtonTypeCustom];
    button.row = row;
    button.column = column;
    button.lineType = type;
    
    if (button.lineType == kHorizontalLine) {
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

-(void)createDotsAndLines:(int) dotsCount {
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2;
    
    UIImage *dotImage = [UIImage imageNamed:@"Dot.png"];
    
//    double lineImageSizeRatio = lineImage.size.width/lineImage.size.height;
    
    int dotSize = 15 - dotsCount;
    
    CGFloat lineLength = (fieldSize - dotsCount*dotSize)/(dotsCount - 1);
    
    for (int i = 0; i < dotsCount; i++) {
        for (int j = 0; j < dotsCount; j++) {
            Coordinate *coordinate = [[Coordinate alloc] init];
            coordinate.row = j;
            coordinate.column = i;
            if (i < (dotsCount - 1)) {
                CGRect horizontalButtonRect = CGRectMake(startPointX + i*lineLength + (i+1)*dotSize, 
                                               startPointY + j*lineLength + j*dotSize, 
                                               lineLength, dotSize);
                [self addLineButtonWithFrame:horizontalButtonRect coordinate:coordinate andType:kHorizontalLine];
            }
            
            if (j < (dotsCount - 1)) {
                CGRect verticalButtonRect = CGRectMake(startPointX + i*lineLength + i*dotSize, 
                                                startPointY + j*lineLength + (j+1)*dotSize, 
                                                dotSize, lineLength);
                [self addLineButtonWithFrame:verticalButtonRect coordinate:coordinate andType:kVerticalLine];
            }
            
            UIImageView *dotView = [[UIImageView alloc] initWithImage:dotImage];
            dotView.frame = CGRectMake(startPointX + i*lineLength + i*dotSize, 
                                       startPointY + j*lineLength + j*dotSize, 
                                       dotSize, dotSize);
            [self.view addSubview:dotView];
            
            [coordinate release];
            [dotView release];
        }
        
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
    //    [self createButton];
    game = [[Game alloc] init];
    [self createDotsAndLines:6];
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
