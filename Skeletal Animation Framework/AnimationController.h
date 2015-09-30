//
//  AnimationController.h
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "AppDelegate.h"
#import "MovementQuards.h"

@interface AnimationController : AppDelegate{
    SCNScene* scene;
    SCNNode* nodes[55];
    MovementQuards* queues[55];
    int tempTotalDur;
    int tempArrayInd;
}

-(SCNScene*)createScene:(NSString*)sceneName;
-(void)createNodes;
-(void)animate:(int) iteration;
-(void)setQueue:(MovementQuards**) q;

@end

