//
//  Coordinate.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  ObjectType{
    kHorizontalLine,
    kVerticalLine,
    kBox
}ObjectType;

@interface Coordinate : NSObject {
    int row;
    int column;
    ObjectType objectType;
}

@property int row;
@property int column;
@property ObjectType objectType;

-(id)initWithRow:(int) row Column:(int) column AndObjectType:(ObjectType) type;

@end
