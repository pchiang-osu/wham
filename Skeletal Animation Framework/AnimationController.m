//
//  AnimationController.m
//  practiceGame
//
//  Created by CS Team on 7/6/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "AnimationController.h"
@import QuartzCore;


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
    int index = 0;
    
    while (index < 54){
        totalDuration = 0;
        int arrayIndex = 0;
        CABasicAnimation* animations[20];
        float layers[20];
        for (int i = 0; i < 20; i++){
            animations[i] = [CABasicAnimation animationWithKeyPath:@"position"];
        }
        
        
        while (queues[index].morePositions){
            lastPosition = [queues[index] getLastPosition];
            
            CABasicAnimation* animx = [CABasicAnimation animationWithKeyPath:@"position"];
            animx.fillMode = kCAFillModeForwards;
            animx.removedOnCompletion = NO;
            animx.beginTime = totalDuration;
            animx.duration = 1;
            [animx setToValue:[NSValue valueWithSCNVector3:SCNVector3Make(lastPosition[0], lastPosition[1], lastPosition[2])]];
            animx.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            layers[arrayIndex] = lastPosition[3];
            animations[arrayIndex] = animx;
            arrayIndex++;
            
            totalDuration += 1;
        }
        
        /*set animation in motion*/

        CABasicAnimation* layerAnimations[52][arrayIndex];
        int animationSize[52];
        
        for (int i = 0; i < 52; i++){
            animationSize[i] = 0;
        }
        
        for (int i = 0; i < 52; i++){
            for (int j = 0; j < arrayIndex; j++){
                layerAnimations[i][j] = [CABasicAnimation animationWithKeyPath:@"position"];
            }
        }
        
        totalDuration = 0;
        
        CAAnimationGroup *group[52][arrayIndex];        //create the animation group array
        for (int i = 0; i < 52; i++){
            for (int j = 0; j < arrayIndex; j++){
                group[i][j] = [CAAnimationGroup animation];
            }
        }
        
        for (int i = 0; i < arrayIndex; i++){       //number of animations i per layer. Should go all the way to 52
            for (int j = 0; j < 52; j++){
                if ((int)layers[i] == j){
                    layerAnimations[j][animationSize[j]] = animations[i];
                    animationSize[j]++;
                }
            }
            
            
            if (i == (arrayIndex - 1)){
                for (int ind = 0; ind < 52; ind++){             //number of animations per layer ind. All the way to 52
                    if (animationSize[ind] == 1){
                        //group[ind][0] = [CAAnimationGroup animation];
                        group[ind][0].animations = @[layerAnimations[ind][0]];
                        group[ind][0].beginTime = 0;
                        group[ind][0].duration = arrayIndex;
                        group[ind][0].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][0] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 1");
                        NSLog(@"%s""%i", "ind:",ind);
                        
                        totalDuration += 1;
                    }
                    if (animationSize[ind] == 2){
                        group[ind][1] = [CAAnimationGroup animation];
                        group[ind][1].animations = @[layerAnimations[ind][0], layerAnimations[ind][1]];
                        group[ind][1].beginTime = 0;
                        group[ind][1].duration = arrayIndex;
                        group[ind][1].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][1] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 2");
                        
                        totalDuration += 2;
                    }
                    if (animationSize[ind] == 3){
                        group[ind][2] = [CAAnimationGroup animation];
                        group[ind][2].animations = @[layerAnimations[ind][0], layerAnimations[ind][1], layerAnimations[ind][2]];
                        group[ind][2].beginTime = 0;
                        group[ind][2].duration = arrayIndex;
                        group[ind][2].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][2] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 3");
                        
                        totalDuration += 3;
                    }
                    
                    if (animationSize[ind] == 4){
                        group[ind][3] = [CAAnimationGroup animation];
                        group[ind][3].animations = @[layerAnimations[ind][0], layerAnimations[ind][1], layerAnimations[ind][2], layerAnimations[ind][3]];
                        group[ind][3].beginTime = 0;
                        group[ind][3].duration = arrayIndex;
                        group[ind][3].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][3] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 4");
                        
                        totalDuration += 4;
                    }
                    if (animationSize[ind] == 5){
                        group[ind][4] = [CAAnimationGroup animation];
                        group[ind][4].animations = @[layerAnimations[ind][0], layerAnimations[ind][1], layerAnimations[ind][2], layerAnimations[ind][3], layerAnimations[ind][4]];
                        group[ind][4].beginTime = 0;
                        group[ind][4].duration = arrayIndex;
                        group[ind][4].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][4] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 5");
                        
                        totalDuration += 5;
                    }
                    
                    if (animationSize[ind] == 6){
                        group[ind][5] = [CAAnimationGroup animation];
                        group[ind][5].animations = @[layerAnimations[ind][0], layerAnimations[ind][1], layerAnimations[ind][2], layerAnimations[ind][3], layerAnimations[ind][4], layerAnimations[ind][5]];
                        group[ind][5].beginTime = 0;
                        group[ind][5].duration = arrayIndex;
                        group[ind][5].removedOnCompletion = NO;
                        [nodes[ind] addAnimation:group[ind][5] forKey:@"allMyAnimations"];
                        NSLog(@"%s", "animationSize = 5");
                        
                        totalDuration += 5;
                    }
                }
                
                
               
                /*[nodes[0] addAnimation:group[0][0] forKey:@"allMyAnimations"];
                [nodes[4] addAnimation:group[4][0] forKey:@"allMyAnimations"];
                NSLog(@"%@", group[0][0]);
                NSLog(@"%@", group[4][0]);*/
            }

        }
    
        index++;
    }
}

-(void)setQueue:(MovementQuards**)q{
    for (int i = 0; i < 54; i++){
        queues[i] = q[i];
    }
}

/*-(MovementQuards*)getQueue{
    return queue1;
}*/

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
 //[PelvisRight addAnimation:startAnim2 forKey:@"rotate"];*/
 


@end
