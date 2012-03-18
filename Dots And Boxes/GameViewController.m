//
//  GameViewController.m
//  Dots And Boxes
//
//  Created by Martin Markov on 10/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "LineImageView.h"
#import "Game.h"
#import "Coordinate.h"
#import "ComputerEasy.h"
#import "ComputerMedium.h"
#import "WinnerAlertView.h"
#import "RemoveAdsAlertView.h"
#import "Player.h"
#import "InAppPurchaseManager.h"


@implementation GameViewController

@synthesize bannerIsVisible;
@synthesize game;
@synthesize lineLength, dotSize;
@synthesize backButton;
@synthesize player2Image, p1Units, p1Tens, p2Units, p2Tens;

@synthesize p1Arrow, p2Arrow;

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
    int p1UnitsInt = game.player1.boxesCount % 10;
    int p1TensInt = game.player1.boxesCount / 10;
    int p2UnitsInt = game.player2.boxesCount % 10;
    int p2TensInt = game.player2.boxesCount / 10;
    
    
    NSString *p1UnitsString = [NSString stringWithFormat:@"blue%d%@.png", p1UnitsInt, iPadString];
    NSString *p1TensString = [NSString stringWithFormat:@"blue%d%@.png",p1TensInt, iPadString];
    NSString *p2UnitsString = [NSString stringWithFormat:@"red%d%@.png", p2UnitsInt, iPadString];
    NSString *p2TensString = [NSString stringWithFormat:@"red%d%@.png",p2TensInt, iPadString];
    
    p1Units.image = [UIImage imageNamed:p1UnitsString];
    p1Tens.image = [UIImage imageNamed:p1TensString];
    p2Units.image = [UIImage imageNamed:p2UnitsString];
    p2Tens.image = [UIImage imageNamed:p2TensString];    
}

-(void)drawLine:(Coordinate*) coordinate {
    
    int tag = coordinate.row*100 + coordinate.column*10 + 1;
    if (coordinate.objectType == kVerticalLine) {
        tag += 1;
    }
    
    LineImageView *button = (LineImageView*)[self.view viewWithTag:tag];
    button.enabled = NO;
    if (button.coordinate.objectType ==  kHorizontalLine) {
        button.image = [game.currentPlayer getPlayerHorizontalLineImage];
    } else {
        button.image = [game.currentPlayer getPlayerVerticalLineImage] ;
    }
    
    
}

-(void)addImageToCurrentButton {
    LineImageView *currentButton = (LineImageView*)toMove;
    
    if (currentButton.tag > 0) {
        if (currentButton.coordinate.objectType == kHorizontalLine) {
            currentButton.image = [game.currentPlayer getPlayerHorizontalLineImage];
        } else {
            currentButton.image = [game.currentPlayer getPlayerVerticalLineImage];
        }
    }
}

-(void)removeImageFromCurrentButton {
    LineImageView *currentButton = (LineImageView*)toMove;
    
    if (currentButton.tag > 0) {
        currentButton.image = nil;
    }

}

-(void)changePlayers {
    [game changeCurrentPlayer];
    if (p1Arrow.image == nil) {
        
        p2Arrow.image = nil;
        p1Arrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"leftArrow%@.png", iPadString]]; 
    } else {
        p1Arrow.image = nil;
        p2Arrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"rightArrow%@.png", iPadString]]; 
    }
}

-(void)showEndGameView {
    WinnerAlertView *winAlert; 
    
    NSString *message;
    if (game.player1.boxesCount == game.player2.boxesCount) {
        message = kGameIsTie;
    } else if (game.player1.boxesCount > game.player2.boxesCount) {        
        message = kPlayer1Wins;
    } else if ([game.player2 isKindOfClass:[ComputerEasy class]]){
        message = kComputerWins;
    } else {
        message = kPlayer2Wins;
    }
    
    winAlert = [[WinnerAlertView alloc] initWithText:message];
    [winAlert show];
    [winAlert release];
    
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
        [self changePlayers];        
    }
    
    [self updateView];
    if ((game.player1.boxesCount + game.player2.boxesCount) == pow((game.dotsCount-1), 2)) {
        [self showEndGameView];
        return false;
    }
    return true;
}

-(void)computerMakeMove {
    ComputerEasy *player2 = (ComputerEasy*) game.currentPlayer;
    Coordinate* cord = [player2 makeMove];
    [self drawLine:cord];
    
    BOOL isNotLastMove = [self playedMove:cord];
    if (![game.currentPlayer isKindOfClass:[ComputerEasy class]] || !isNotLastMove) {
        [computerTimer invalidate];
        computerTimer = nil;
        
        isUser = YES;
    }

}

-(void)addLineButtonWithFrame:(CGRect) rect coordinate:(Coordinate*) coordinate {
    
    LineImageView *button = [[LineImageView alloc] init];
    button.coordinate = coordinate;
    
    if (coordinate.objectType == kHorizontalLine) {
        button.tag = coordinate.row * 100 + coordinate.column*10 + 1;
    } else {
        button.tag = coordinate.row * 100 + coordinate.column*10 + 2;
    }
    
    button.frame = rect;
    [self.view addSubview:button];
    [lineButtonsArray addObject:button];
    
    [button release];
}

-(void)createDotsAndLines { 
    
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2;
    
    UIImage *dotImage = [UIImage imageNamed:[NSString stringWithFormat: @"dot%@.png", iPadString]];
    
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

-(void)putImageToTheClosestTouch:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint firstTouch = [touch locationInView:self.view];
    
    int nearestVerticalLineTag = 0;
    int nearestHorizontalLineTag = 0;
    
    CGFloat startPointX = (CGRectGetWidth(self.view.bounds) - fieldSize)/2 - 5;
    CGFloat startPointY = (CGRectGetHeight(self.view.bounds) - fieldSize)/2 - 5;
    CGRect gameFieldFrame = CGRectMake(startPointX, startPointY, fieldSize + 10, fieldSize + 10);
    
    int minX = lineLength/2;
    int minY = lineLength/2;
    for (UIView *view in lineButtonsArray) {
        LineImageView *currentButton = (LineImageView*) view;
        if (currentButton.enabled && isUser) {
            if (CGRectContainsPoint(view.frame, firstTouch)) {
                
                NSLog(@"tag:%d",view.tag);
                toMove = view;
                [self addImageToCurrentButton];
                return;
            } else if(CGRectContainsPoint(gameFieldFrame, firstTouch)){
                
                int x = view.frame.origin.x - firstTouch.x;
                int y = view.frame.origin.y - firstTouch.y;
                
                x = abs(x);
                y = abs(y);
                
                if (currentButton.coordinate.objectType == kVerticalLine && x<minX && y<lineLength) {
                    nearestVerticalLineTag = currentButton.tag;
                    minX = x;
                    NSLog(@"NearestVerticalLineTag:%d", nearestVerticalLineTag);
                } else if (currentButton.coordinate.objectType == kHorizontalLine && y<minY && x<lineLength) {
                    nearestHorizontalLineTag = currentButton.tag;
                    minY = y;
                    NSLog(@"NearestHorizontalLineTag:%d",nearestHorizontalLineTag);
                }
                
            }
        }
    }
    
    if (minX < minY) {
        toMove = [self.view viewWithTag:nearestVerticalLineTag];
    } else {
        toMove = [self.view viewWithTag:nearestHorizontalLineTag];
    }
    
    [self addImageToCurrentButton];
}

-(BOOL)isAdsRemovePurchased {
    BOOL isAdsRemovePrchased = [[NSUserDefaults standardUserDefaults] boolForKey:@"isAdsRemovePurchased"];
    if (isAdsRemovePrchased ==  NO) {
        NSLog(@"NO");
    } else {
        NSLog(@"YES");
    }
    
    return isAdsRemovePrchased;
}

-(IBAction)backButtonPressed {
    [computerTimer invalidate];
    InAppPurchaseManager *purchaseManager = [[InAppPurchaseManager alloc] init];
    [purchaseManager loadStore];
    if ([purchaseManager canMakePurchases] && adIsShown && ![self isAdsRemovePurchased]) {
        RemoveAdsAlertView *removeAds;
        
        removeAds = [[RemoveAdsAlertView alloc] initWithTitle:@"Remove Ads?" message:@"Do you want to remove the ads?" delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        removeAds.delegate = removeAds;
        [removeAds show];
        [removeAds release];
    }
    
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
    adView.delegate = nil;
    [adView release];
    [game release];
    [computerTimer release];
    [lineButtonsArray release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];    
    int dotsCount = [game dotsCount];
    
    if ([game.player2 isKindOfClass:[ComputerEasy class]] || [game.player2 isKindOfClass:[ComputerMedium class]]) {
        
        player2Image.image = [UIImage imageNamed:[NSString stringWithFormat: @"computerImage%@.png", iPadString]];
        
    } else {
        
        player2Image.image = [UIImage imageNamed:[NSString stringWithFormat: @"player2Image%@.png", iPadString]];
        
    }
    NSLog(@"dotSizeGame:%d", dotSizeGame);
    
    dotSize = (dotSizeGame/dotsCount) * 4;
    lineLength = (fieldSize - dotsCount*dotSize)/(dotsCount - 1);
    
    [self createDotsAndLines];
}

- (void)viewDidLoad
{
    adIsShown = NO;
    isUser = YES;
    lineButtonsArray = [[NSMutableArray alloc] init];
    if (![self isAdsRemovePurchased]) {
        adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        if (UI_USER_INTERFACE_IDIOM()) {
            adView.frame = CGRectOffset(adView.frame, 0, -66);
        } else {
            adView.frame = CGRectOffset(adView.frame, 0, -50);
        }
        adView.requiredContentSizeIdentifiers = [NSSet  setWithObject:ADBannerContentSizeIdentifierPortrait];
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        [self.view addSubview:adView];
        adView.delegate = self;
        self.bannerIsVisible = NO;
    }
    
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

#pragma mark Touch Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"began");
    [self putImageToTheClosestTouch:touches];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeImageFromCurrentButton];
    NSLog(@"moved");
    [self putImageToTheClosestTouch:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (toMove.tag != 0) {
        
        
        LineImageView *currentButton = (LineImageView*) toMove;
        
        if (currentButton.coordinate.objectType == kHorizontalLine) {
            currentButton.image = [game.currentPlayer getPlayerHorizontalLineImage];
        } else {
            currentButton.image = [game.currentPlayer getPlayerVerticalLineImage];
        }
        currentButton.enabled = NO;
        
        Coordinate *currentCord = [currentButton coordinate];
        [self playedMove:currentCord];
        
        if ([game.currentPlayer isKindOfClass:[ComputerEasy class]]) {
            isUser = NO;
            
            computerTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(computerMakeMove) userInfo:nil repeats:YES];
        }
    }
    toMove = nil;

}

#pragma mark AdBanerViewDelegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    adIsShown = YES;
    if (!self.bannerIsVisible) {
        [UIView beginAnimations:@"animatedAdBannerOn" context:NULL];

        if (UI_USER_INTERFACE_IDIOM()) {
            banner.frame = CGRectOffset(adView.frame, 0, 66);
            backButton.frame = CGRectOffset(backButton.frame, 0, 66);
        } else {
            banner.frame = CGRectOffset(adView.frame, 0, 50);
            backButton.frame = CGRectOffset(backButton.frame, 0, 50);
        }
        
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (self.bannerIsVisible) {
        [UIView beginAnimations:@"animatedAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(adView.frame, 0, -50);
        backButton.frame = CGRectOffset(backButton.frame, 0, 0);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

@end
