//
//  LLAnimation.m
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "LLAnimation.h"

@implementation LLAnimation

-(void)setAnimation:(CABasicAnimation*)x:(CABasicAnimation*)y:(CABasicAnimation*)z:(double)p:(SCNNode*)node:(int)startTime{
    animation[0] = x;
    animation[1] = y;
    animation[2] = z;
    
    group = [CAAnimationGroup animation];
    
    group.animations = @[x, y, z];
    //group.beginTime = startTime;
    group.duration = startTime;
    group.removedOnCompletion = NO;
    //[node addAnimation:group forKey:@"allMyAnimations"];
    
    part = p;
}

-(CABasicAnimation*)getXAnimation{
    return animation[0];
}
-(CABasicAnimation*)getYAnimation{
    return animation[1];
}
-(CABasicAnimation*)getZAnimation{
    return animation[2];
}

-(CAAnimationGroup*)getGroup{
    return group;
}

-(double)getPart{
    return part;
}

-(void)setNext:(LLAnimation*)n{
    next = n;
}

-(LLAnimation*)getNext{
    return next;
}

@end
