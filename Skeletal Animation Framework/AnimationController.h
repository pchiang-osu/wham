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
    MovementQuards* queues[54];
}

-(SCNScene*)createScene:(NSString*)sceneName;
-(void)createNodes;
-(void)animate;
-(void)setQueue:(MovementQuards*) q1:(MovementQuards*) q2:(MovementQuards*) q3:(MovementQuards*) q4:(MovementQuards*) q5:(MovementQuards*) q6:(MovementQuards*) q7:(MovementQuards*) q8:(MovementQuards*) q9:(MovementQuards*) q10:(MovementQuards*) q11:(MovementQuards*) q12:(MovementQuards*) q13:(MovementQuards*) q14:(MovementQuards*) q15:(MovementQuards*) q16:(MovementQuards*) q17:(MovementQuards*) q18:(MovementQuards*) q19:(MovementQuards*) q20:(MovementQuards*) q21:(MovementQuards*) q22:(MovementQuards*) q23:(MovementQuards*) q24:(MovementQuards*) q25:(MovementQuards*) q26:(MovementQuards*) q27:(MovementQuards*) q28:(MovementQuards*) q29:(MovementQuards*) q30:(MovementQuards*) q31:(MovementQuards*) q32:(MovementQuards*) q33:(MovementQuards*) q34:(MovementQuards*) q35:(MovementQuards*) q36:(MovementQuards*) q37:(MovementQuards*) q38:(MovementQuards*) q39:(MovementQuards*) q40:(MovementQuards*) q41:(MovementQuards*) q42:(MovementQuards*) q43:(MovementQuards*) q44:(MovementQuards*) q45:(MovementQuards*) q46:(MovementQuards*) q47:(MovementQuards*) q48:(MovementQuards*) q49:(MovementQuards*) q50:(MovementQuards*) q51:(MovementQuards*) q52:(MovementQuards*) q53:(MovementQuards*) q54;
/*-(MovementQuards*)getQueue;*/

@end

