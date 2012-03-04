//
//  LineButton.h
//  Dots And Boxes
//
//  Created by Martin Markov on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"


@interface LineImageView : UIImageView {
    Coordinate *coordinate;
    BOOL enabled;
}

@property (nonatomic, retain) Coordinate *coordinate;
@property BOOL enabled;

-(id)init;

@end
