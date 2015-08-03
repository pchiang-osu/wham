//
//  GameViewController.h
//  practiceGame
//

//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import "MovementQuards.h"
#import "AnimationController.h"

@interface GameViewController : UIViewController{
    MovementQuards* movementQueues[52];
    bool animate;
}


@end

