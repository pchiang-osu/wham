//
//  MovementQuards.h
//  practiceGame
//
//  Created by CS Team on 7/2/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovementQuards : NSObject {
    double posQueue[20][4];
}

-(void)addPosition:(double)posx:(double)posy:(double)posz:(double)part;
-(double*)getLastPosition;
-(double)getPart;
-(void)clear;
-(bool)morePositions;


@property (nonatomic, readonly) int top;
@property (nonatomic, readonly) int bottom;

@end

