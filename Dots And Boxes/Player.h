//
//  Player.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Player : NSObject {
    NSString *color;
    NSString *name;
    int boxesCount;
}

@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *name;
@property int boxesCount;

-(UIImage*)getPlayerHorizontalLineImage;
-(UIImage*)getPlayerVerticalLineImage;
-(UIImage*)getPlayerBoxImage;

-(id)initWithColor:(NSString*) inColor Name:(NSString*) inName;

@end
