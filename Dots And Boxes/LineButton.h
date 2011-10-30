//
//  LineButton.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"


@interface LineButton : UIButton {
    Coordinate *coordinate;
}

@property (nonatomic, retain) Coordinate *coordinate;
@end
