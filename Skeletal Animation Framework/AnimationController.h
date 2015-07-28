//
//  AnimationController.h
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "AppDelegate.h"
#import "LLAnimation.h"
#import "MovementQuards.h"

@interface AnimationController : AppDelegate{
    LLAnimation* start;
    SCNScene* scene;
    SCNNode* nodes[55];
    MovementQuards* queue1;
    MovementQuards* queue2;
    MovementQuards* queue3;
    MovementQuards* queue4;
    MovementQuards* queue5;
    MovementQuards* queue6;
    MovementQuards* queue7;
    MovementQuards* queue8;
    MovementQuards* queue9;
    MovementQuards* queue10;
    MovementQuards* queue11;
    MovementQuards* queue12;
    MovementQuards* queue13;
    MovementQuards* queue14;
    MovementQuards* queue15;
    MovementQuards* queue16;
    MovementQuards* queue17;
    MovementQuards* queue18;
    MovementQuards* queue19;
    MovementQuards* queue20;
}

-(SCNScene*)createScene:(NSString*)sceneName;
-(void)createNodes;
-(void)animate;
-(void)setQueue:(MovementQuards*) q1:(MovementQuards*) q2:(MovementQuards*) q3:(MovementQuards*) q4:(MovementQuards*) q5:(MovementQuards*) q6:(MovementQuards*) q7:(MovementQuards*) q8:(MovementQuards*) q9:(MovementQuards*) q10:(MovementQuards*) q11:(MovementQuards*) q12:(MovementQuards*) q13:(MovementQuards*) q14:(MovementQuards*) q15:(MovementQuards*) q16:(MovementQuards*) q17:(MovementQuards*) q18:(MovementQuards*) q19:(MovementQuards*) q20;
-(MovementQuards*)getQueue;

@end

