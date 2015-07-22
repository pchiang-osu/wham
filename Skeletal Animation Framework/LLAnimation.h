//
//  LLAnimation.h
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "AppDelegate.h"
#import <SceneKit/SceneKit.h>

@interface LLAnimation : AppDelegate{
    CABasicAnimation* animation[3];
    CAAnimationGroup *group;
    double part;
    LLAnimation* next;
}

-(void)setAnimation:(CABasicAnimation*)x:(CABasicAnimation*)y:(CABasicAnimation*)z:(double)p:(SCNNode*)node:(int)startTime;
-(CABasicAnimation*)getXAnimation;
-(CABasicAnimation*)getYAnimation;
-(CABasicAnimation*)getZAnimation;
-(CAAnimationGroup*)getGroup;
-(double)getPart;
-(void)setNext:(LLAnimation*)n;
-(LLAnimation*)getNext;

@end
