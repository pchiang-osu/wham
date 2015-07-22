//
//  AnimationController.m
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "AnimationController.h"

@implementation AnimationController
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

-(SCNScene*)createScene:(NSString*)sceneName{
    scene = [SCNScene sceneNamed:sceneName];
    return scene;
}

-(void)createNodes{
    // create and add a camera to the scene
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // place the camera
    
    cameraNode.position = SCNVector3Make(0, -10, 3);
    cameraNode.rotation = SCNVector4Make(1.0, 0.0, 0.0, degreesToRadians(90.0));
    
    
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    // retrieve the nodes
    SCNNode *Armature = [scene.rootNode childNodeWithName:@"Armature" recursively:NO];
    SCNNode *Pelvis = [Armature childNodeWithName:@"ROOT" recursively:NO];
    SCNNode *PelvisRight = [Pelvis childNodeWithName:@"PelvRight" recursively:NO];
    SCNNode *PelvisLeft = [Pelvis childNodeWithName:@"PelvLeft" recursively:NO];
    SCNNode *HipRight = [PelvisRight childNodeWithName:@"RIGHTHIP" recursively:NO];
    SCNNode *HipLeft = [PelvisLeft childNodeWithName:@"LEFTHIP" recursively:NO];
    SCNNode *KneeRight = [HipRight childNodeWithName:@"RIGHTKNEE" recursively:NO];
    SCNNode *KneeLeft = [HipLeft childNodeWithName:@"LEFTKNEE" recursively:NO];
    SCNNode *AnkleRight = [KneeRight childNodeWithName:@"RIGHTANKLE" recursively:NO];
    SCNNode *AnkleLeft = [KneeLeft childNodeWithName:@"LEFTANKLE" recursively:NO];
    SCNNode *FootRight = [AnkleRight childNodeWithName:@"RIGHTFOOT" recursively:NO];
    SCNNode *FootLeft = [AnkleLeft childNodeWithName:@"LEFTFOOT" recursively:NO];
    
    
    SCNNode *Spine1 = [Pelvis childNodeWithName:@"SPINE1" recursively:NO];
    SCNNode *Spine2 = [Spine1 childNodeWithName:@"SPINE2" recursively:NO];
    SCNNode *Spine3 = [Spine2 childNodeWithName:@"SPINE3" recursively:NO];
    SCNNode *Neck = [Spine3 childNodeWithName:@"NECK" recursively:NO];
    SCNNode *Head = [Neck childNodeWithName:@"Head" recursively:NO];
    
    SCNNode *ClavicleLeft = [Spine3 childNodeWithName:@"LEFTCLAVICLE" recursively:NO];
    SCNNode *ClavicleRight = [Spine3 childNodeWithName:@"RIGHTCLAVICLE" recursively:NO];
    
    nodes[0] = Armature;
    nodes[1] = Pelvis;
    nodes[2] = PelvisRight;
    nodes[3] = PelvisLeft;
    nodes[4] = HipRight;
    nodes[5] = HipLeft;
    nodes[6] = KneeRight;
    nodes[7] = KneeLeft;
    nodes[8] = AnkleRight;
    nodes[9] = AnkleLeft;
    nodes[10] = FootRight;
    nodes[11] = FootLeft;
    nodes[12] = Spine1;
    nodes[13] = Spine2;
    nodes[14] = Spine3;
    nodes[15] = Neck;
    nodes[16] = Head;
    nodes[17] = ClavicleLeft;
    nodes[18] = ClavicleRight;
    
    if (Armature){
        NSLog(@"%s", "found");
    }
    else{
        NSLog(@"%s", "not found");
    }
    
    bool animate = 1;
    if (animate){
        [self animate];
    }
    
}

-(void)animate{
    CGFloat totalDuration = 0;
    double* lastPosition;
    
    while (queue.morePositions){
        lastPosition = [queue getLastPosition];
        
        CABasicAnimation* animx = [CABasicAnimation animationWithKeyPath:@"rotation"];
        animx.fillMode = kCAFillModeForwards;
        animx.removedOnCompletion = NO;
        animx.beginTime = totalDuration;
        animx.duration = 5;
        //startAnim.repeatCount = MAXFLOAT;
        animx.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(1.0, 0.0, 0.0, degreesToRadians(lastPosition[0]))];
        animx.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation* animy = [CABasicAnimation animationWithKeyPath:@"rotation"];
        animy.fillMode = kCAFillModeForwards;
        animy.removedOnCompletion = NO;
        animy.beginTime = totalDuration;
        animy.duration = 5;
        //startAnim.repeatCount = MAXFLOAT;
        animy.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0.0, 1.0, 0.0, degreesToRadians(lastPosition[1]))];
        animy.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        
        CABasicAnimation* animz = [CABasicAnimation animationWithKeyPath:@"rotation"];
        animz.fillMode = kCAFillModeForwards;
        animz.removedOnCompletion = NO;
        animz.beginTime = totalDuration;
        animz.duration = 5;
        //startAnim.repeatCount = MAXFLOAT;
        animz.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0.0, 0.0, 1.0, degreesToRadians(lastPosition[2]))];
        animz.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        totalDuration += 5;
        
        LLAnimation* newAnimation = [[LLAnimation alloc]init];
        [newAnimation setAnimation:(animx):(animy):(animz):lastPosition[3]:(nodes[(int)lastPosition[3]]):(totalDuration)];
        if (start == nil){
            start = newAnimation;
        }
        else{
            LLAnimation* search = start;
            
            while ([search getNext] != nil){
                search = [search getNext];
                NSLog(@"%s", "not null");
            }
            
            [newAnimation setAnimation:(animx):(animy):(animz):lastPosition[3]:(nodes[(int)lastPosition[3]]):(totalDuration)];
            [search setNext:(newAnimation)];
            
            NSLog(@"%s", "Hello");
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    LLAnimation* temp = start;
    int groupFlag = 0;
    CAAnimationGroup *groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while ([temp getNext] != nil){
        if (nodes[(int)[temp getPart]] == nodes[(int)[temp.getNext getPart]]){
            groupOfGroups.animations = @[[temp getGroup], [temp.getNext getGroup]];
            //groupOfGroups.
            //group.beginTime = startTime;
            groupOfGroups.duration = [temp.getGroup duration];
            groupOfGroups.removedOnCompletion = NO;
            [nodes[(int)[temp getPart]] addAnimation:groupOfGroups forKey:@"allMyAnimations"];
            groupFlag = 1;
        }
        else{
            CAAnimationGroup *group = [temp getGroup];
            [nodes[(int)[temp getPart]] addAnimation:group forKey:@"allMyAnimations"];
            groupFlag = 0;
        }
        temp = [temp getNext];
    }
    if (!groupFlag){
        CAAnimationGroup *group = [temp getGroup];
        [nodes[(int)[temp getPart]] addAnimation:group forKey:@"allMyAnimations"];
    }
    NSLog(@"%s", "test");
    /*will all go into a while loop*/
    /*CAAnimationGroup *group = [start getGroup];
     //[nodes[(int)[start getPart]] addAnimation:group forKey:@"allMyAnimations"];
     
     CAAnimationGroup *group2 = [start.getNext getGroup];
     //[nodes[(int)[start.getNext getPart]] addAnimation:group2 forKey:@"allMyAnimations"];
     
     CAAnimationGroup *group3 = [start.getNext.getNext getGroup];
     //[nodes[(int)[start.getNext.getNext getPart]] addAnimation:group3 forKey:@"allMyAnimations"];
     
     
     
     if (nodes[(int)[start getPart]] == nodes[(int)[start.getNext getPart]]){
     CAAnimationGroup *group4 = [CAAnimationGroup animation];
     group4.animations = @[group,group2,group3];
     //group.beginTime = startTime;
     group4.duration = totalDuration;
     group4.removedOnCompletion = NO;
     [nodes[(int)[start getPart]] addAnimation:group4 forKey:@"allMyAnimations"];
     }
     else{
     [nodes[(int)[start getPart]] addAnimation:group forKey:@"allMyAnimations"];
     [nodes[(int)[start.getNext getPart]] addAnimation:group2 forKey:@"allMyAnimations"];
     [nodes[(int)[start.getNext.getNext getPart]] addAnimation:group3 forKey:@"allMyAnimations"];
     }*/
}

-(void)setQueue:(MovementQuards*) q{
    queue = q;
}

-(MovementQuards*)getQueue{
    return queue;
}

//PelvisRight.rotation = SCNVector4Make(1.0, 0.0, 0.0, degreesToRadians(180.0));
/*CGFloat totalDuration = 0;
 CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath:@"rotation"];
 startAnim.fillMode = kCAFillModeForwards;
 startAnim.removedOnCompletion = NO;
 startAnim.beginTime = 0;
 startAnim.duration = 5;
 //startAnim.repeatCount = MAXFLOAT;
 startAnim.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0.0, 1.0, 1.0, degreesToRadians([queue getLastPosition]))];
 startAnim.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 //[PelvisRight addAnimation:startAnim forKey:@"rotate"];
 
 totalDuration += 5;
 
 CABasicAnimation *startAnim2 = [CABasicAnimation animationWithKeyPath:@"rotation"];
 startAnim2.fillMode = kCAFillModeForwards;
 startAnim2.removedOnCompletion = NO;
 startAnim2.beginTime = totalDuration;
 startAnim2.duration = 5;
 //startAnim.repeatCount = MAXFLOAT;
 startAnim2.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0.0, 0.0, 1.0, degreesToRadians([queue getLastPosition]))];
 startAnim2.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 //[PelvisRight addAnimation:startAnim2 forKey:@"rotate"];
 
 CAAnimationGroup *group = [CAAnimationGroup animation];
 group.animations = @[startAnim, startAnim2];
 group.duration = 20;
 //group.repeatCount = 3;
 group.autoreverses = YES;
 [HipRight addAnimation:group forKey:@"allMyAnimations"];*/

@end
