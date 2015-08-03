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
    
    MovementQuards* queue21;
    MovementQuards* queue22;
    MovementQuards* queue23;
    MovementQuards* queue24;
    MovementQuards* queue25;
    MovementQuards* queue26;
    MovementQuards* queue27;
    MovementQuards* queue28;
    MovementQuards* queue29;
    MovementQuards* queue30;
    MovementQuards* queue31;
    MovementQuards* queue32;
    MovementQuards* queue33;
    MovementQuards* queue34;
    MovementQuards* queue35;
    MovementQuards* queue36;
    MovementQuards* queue37;
    MovementQuards* queue38;
    MovementQuards* queue39;
    MovementQuards* queue40;
    MovementQuards* queue41;
    MovementQuards* queue42;
    MovementQuards* queue43;
    MovementQuards* queue44;
    MovementQuards* queue45;
    MovementQuards* queue46;
    MovementQuards* queue47;
    MovementQuards* queue48;
    MovementQuards* queue49;
    MovementQuards* queue50;
    MovementQuards* queue51;
    MovementQuards* queue52;
    MovementQuards* queue53;
    MovementQuards* queue54;
}

-(SCNScene*)createScene:(NSString*)sceneName;
-(void)createNodes;
-(void)animate;
-(void)setQueue:(MovementQuards*) q1:(MovementQuards*) q2:(MovementQuards*) q3:(MovementQuards*) q4:(MovementQuards*) q5:(MovementQuards*) q6:(MovementQuards*) q7:(MovementQuards*) q8:(MovementQuards*) q9:(MovementQuards*) q10:(MovementQuards*) q11:(MovementQuards*) q12:(MovementQuards*) q13:(MovementQuards*) q14:(MovementQuards*) q15:(MovementQuards*) q16:(MovementQuards*) q17:(MovementQuards*) q18:(MovementQuards*) q19:(MovementQuards*) q20:(MovementQuards*) q21:(MovementQuards*) q22:(MovementQuards*) q23:(MovementQuards*) q24:(MovementQuards*) q25:(MovementQuards*) q26:(MovementQuards*) q27:(MovementQuards*) q28:(MovementQuards*) q29:(MovementQuards*) q30:(MovementQuards*) q31:(MovementQuards*) q32:(MovementQuards*) q33:(MovementQuards*) q34:(MovementQuards*) q35:(MovementQuards*) q36:(MovementQuards*) q37:(MovementQuards*) q38:(MovementQuards*) q39:(MovementQuards*) q40:(MovementQuards*) q41:(MovementQuards*) q42:(MovementQuards*) q43:(MovementQuards*) q44:(MovementQuards*) q45:(MovementQuards*) q46:(MovementQuards*) q47:(MovementQuards*) q48:(MovementQuards*) q49:(MovementQuards*) q50:(MovementQuards*) q51:(MovementQuards*) q52:(MovementQuards*) q53:(MovementQuards*) q54;
-(MovementQuards*)getQueue;

@end

