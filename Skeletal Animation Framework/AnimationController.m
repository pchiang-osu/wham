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
    
    SCNNode *ClavicleRight = [Spine3 childNodeWithName:@"RIGHTCLAVICLE" recursively:NO];
    SCNNode *ClavicleLeft = [Spine3 childNodeWithName:@"LEFTCLAVICLE" recursively:NO];
    SCNNode *ArmUpperRight = [ClavicleRight childNodeWithName:@"ArmUpperRight" recursively:NO];
    SCNNode *ArmUpperLeft = [ClavicleLeft childNodeWithName:@"ArmUpperLeft" recursively:NO];
    SCNNode *ArmLowerRight = [ArmUpperRight childNodeWithName:@"ArmLowerRight" recursively:NO];
    SCNNode *ArmLowerLeft = [ArmUpperLeft childNodeWithName:@"ArmLowerLeft" recursively:NO];
    
    SCNNode *WristRight = [ArmLowerRight childNodeWithName:@"RIGHTWRIST" recursively:NO];
    SCNNode *WristLeft = [ArmLowerLeft childNodeWithName:@"LEFTWRIST" recursively:NO];
    SCNNode *IndexFinger1Right = [WristRight childNodeWithName:@"RIGHTHANDINDEX1" recursively:NO];
    SCNNode *IndexFinger1Left = [WristLeft childNodeWithName:@"LEFTHANDINDEX1" recursively:NO];
    SCNNode *IndexFinger2Right = [IndexFinger1Right childNodeWithName:@"RIGHTHANDINDEX2" recursively:NO];
    SCNNode *IndexFinger2Left = [IndexFinger1Left childNodeWithName:@"LEFTHANDINDEX2" recursively:NO];
    SCNNode *IndexFinger3Right = [IndexFinger2Right childNodeWithName:@"RIGHTHANDINDEX3" recursively:NO];
    SCNNode *IndexFinger3Left = [IndexFinger2Left childNodeWithName:@"LEFTHANDINDEX3" recursively:NO];
    
    SCNNode *MiddleFinger1Right = [WristRight childNodeWithName:@"RIGHTHANDMIDDLE1" recursively:NO];
    SCNNode *MiddleFinger1Left = [WristLeft childNodeWithName:@"LEFTHANDMIDDLE1" recursively:NO];
    SCNNode *MiddleFinger2Right = [MiddleFinger1Right childNodeWithName:@"RIGHTHANDMIDDLE2" recursively:NO];
    SCNNode *MiddleFinger2Left = [MiddleFinger1Left childNodeWithName:@"LEFTHANDMIDDLE2" recursively:NO];
    SCNNode *MiddleFinger3Right = [MiddleFinger2Right childNodeWithName:@"RIGHTHANDMIDDLE3" recursively:NO];
    SCNNode *MiddleFinger3Left = [MiddleFinger2Left childNodeWithName:@"LEFTHANDMIDDLE3" recursively:NO];
    
    SCNNode *RingFinger1Right = [WristRight childNodeWithName:@"RIGHTHANDRING1" recursively:NO];
    SCNNode *RingFinger1Left = [WristLeft childNodeWithName:@"LEFTHANDRING1" recursively:NO];
    SCNNode *RingFinger2Right = [RingFinger1Right childNodeWithName:@"RIGHTHANDRING2" recursively:NO];
    SCNNode *RingFinger2Left = [RingFinger1Left childNodeWithName:@"LEFTHANDRING2" recursively:NO];
    SCNNode *RingFinger3Right = [RingFinger2Right childNodeWithName:@"RIGHTHANDRING3" recursively:NO];
    SCNNode *RingFinger3Left = [RingFinger2Left childNodeWithName:@"LEFTHANDRING3" recursively:NO];
    
    SCNNode *PinkyFinger1Right = [WristRight childNodeWithName:@"RIGHTHANDPINKY1" recursively:NO];
    SCNNode *PinkyFinger1Left = [WristLeft childNodeWithName:@"LEFTHANDPINKY1" recursively:NO];
    SCNNode *PinkyFinger2Right = [PinkyFinger1Right childNodeWithName:@"RIGHTHANDPINKY2" recursively:NO];
    SCNNode *PinkyFinger2Left = [PinkyFinger1Left childNodeWithName:@"LEFTHANDPINKY2" recursively:NO];
    SCNNode *PinkyFinger3Right = [PinkyFinger2Right childNodeWithName:@"RIGHTHANDPINKY3" recursively:NO];
    SCNNode *PinkyFinger3Left = [PinkyFinger2Left childNodeWithName:@"LEFTHANDPINKY3" recursively:NO];
    
    SCNNode *Thumb1Right = [WristRight childNodeWithName:@"RIGHTHANDTHUMB1" recursively:NO];
    SCNNode *Thumb1Left = [WristLeft childNodeWithName:@"LEFTHANDTHUMB1" recursively:NO];
    SCNNode *Thumb2Right = [Thumb1Right childNodeWithName:@"RIGHTHANDTHUMB2" recursively:NO];
    SCNNode *Thumb2Left = [Thumb1Right childNodeWithName:@"LEFTHANDTHUMB2" recursively:NO];
    SCNNode *Thumb3Right = [Thumb2Right childNodeWithName:@"RIGHTHANDTHUMB3" recursively:NO];
    SCNNode *Thumb3Left = [Thumb2Right childNodeWithName:@"LEFTHANDTHUMB3" recursively:NO];


    
    
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
    nodes[19] = ArmUpperRight;
    nodes[20] = ArmUpperLeft;
    nodes[21] = ArmLowerRight;
    nodes[22] = ArmLowerLeft;
    nodes[23] = WristRight;
    nodes[24] = WristLeft;
    nodes[25] = IndexFinger1Right;
    nodes[26] = IndexFinger1Left;
    nodes[27] = IndexFinger2Right;
    nodes[28] = IndexFinger2Left;
    nodes[29] = IndexFinger3Right;
    nodes[30] = IndexFinger3Left;
    nodes[31] = MiddleFinger1Right;
    nodes[32] = MiddleFinger1Left;
    nodes[33] = MiddleFinger2Right;
    nodes[34] = MiddleFinger2Left;
    nodes[35] = MiddleFinger3Right;
    nodes[36] = MiddleFinger3Left;
    nodes[37] = RingFinger1Right;
    nodes[38] = RingFinger1Left;
    nodes[39] = RingFinger2Right;
    nodes[40] = RingFinger2Left;
    nodes[41] = RingFinger3Right;
    nodes[42] = RingFinger3Left;
    nodes[43] = PinkyFinger1Right;
    nodes[44] = PinkyFinger1Left;
    nodes[45] = PinkyFinger2Right;
    nodes[46] = PinkyFinger2Left;
    nodes[47] = PinkyFinger3Right;
    nodes[48] = PinkyFinger3Left;
    nodes[49] = Thumb1Right;
    nodes[50] = Thumb1Left;
    nodes[51] = Thumb2Right;
    nodes[52] = Thumb2Left;
    nodes[53] = Thumb3Right;
    nodes[54] = Thumb3Left;
    
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
    
    while (queue1.morePositions){
        lastPosition = [queue1 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    LLAnimation* temp = start;
    int groupFlag = 0;
    CAAnimationGroup *groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue2.morePositions){
        lastPosition = [queue2 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue3.morePositions){
        lastPosition = [queue3 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue4.morePositions){
        lastPosition = [queue4 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue5.morePositions){
        lastPosition = [queue5 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue6.morePositions){
        lastPosition = [queue6 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue7.morePositions){
        lastPosition = [queue7 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue8.morePositions){
        lastPosition = [queue8 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue9.morePositions){
        lastPosition = [queue9 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue10.morePositions){
        lastPosition = [queue10 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue11.morePositions){
        lastPosition = [queue11 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue12.morePositions){
        lastPosition = [queue12 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue13.morePositions){
        lastPosition = [queue13 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue14.morePositions){
        lastPosition = [queue14 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue15.morePositions){
        lastPosition = [queue15 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue16.morePositions){
        lastPosition = [queue16 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue17.morePositions){
        lastPosition = [queue17 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue18.morePositions){
        lastPosition = [queue18 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue19.morePositions){
        lastPosition = [queue19 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
    
    totalDuration = 0;
    while (queue20.morePositions){
        lastPosition = [queue20 getLastPosition];
        
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
        }
        
    }
    
    /*set animation in motion*/
    
    
    //CAAnimationGroup *group = [CAAnimationGroup animation];
    temp = start;
    groupFlag = 0;
    groupOfGroups = [CAAnimationGroup animation];
    
    //figure out how to add animations from linked list into group
    while (temp != nil){
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
}

-(void)setQueue:(MovementQuards*) q1:(MovementQuards*) q2:(MovementQuards*) q3:(MovementQuards*) q4:(MovementQuards*) q5:(MovementQuards*) q6:(MovementQuards*) q7:(MovementQuards*) q8:(MovementQuards*) q9:(MovementQuards*) q10:(MovementQuards*) q11:(MovementQuards*) q12:(MovementQuards*) q13:(MovementQuards*) q14:(MovementQuards*) q15:(MovementQuards*) q16:(MovementQuards*) q17:(MovementQuards*) q18:(MovementQuards*) q19:(MovementQuards*) q20{
    queue1 = q1;
    queue2 = q2;
    queue3 = q3;
    queue4 = q4;
    queue5 = q5;
    queue6 = q6;
    queue7 = q7;
    queue8 = q8;
    queue9 = q9;
    queue10 = q10;
    queue11 = q11;
    queue12 = q12;
    queue13 = q13;
    queue14 = q14;
    queue15 = q15;
    queue16 = q16;
    queue17 = q17;
    queue18 = q18;
    queue19 = q19;
    queue20 = q20;
    
}

-(MovementQuards*)getQueue{
    return queue1;
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
