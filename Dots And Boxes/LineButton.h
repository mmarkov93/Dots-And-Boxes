//
//  LineButton.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  Lines{
    kHorizontalLine,
    kVerticalLine
}Lines;

@interface LineButton : UIButton {
    int row;
    int column;
    Lines lineType;
}

@property int row;
@property int column;
@property Lines lineType;

@end
