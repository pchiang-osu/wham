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
-(void)setQueue:(MovementQuards**) q;

@end

