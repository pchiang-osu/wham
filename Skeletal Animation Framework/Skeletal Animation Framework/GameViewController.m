//
//  GameViewController.m
//  practiceGame
//
//  Created by CS Team on 6/11/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /*NSLog(@"%f", [MovementQueue getLastPosition]);
     NSLog(@"%f", [MovementQueue getLastPosition]);*/
    
    //[MovementQueue clear];
    
    
    // create a new scene
    AnimationController* anim = [[AnimationController alloc]init];
    
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // set the scene to the view
    scnView.scene = [anim createScene:@"Bullock-2.dae"];
    
    // retrieve the nodes
    [anim createNodes];
    
    //set up queue
    for (int i = 0; i < 55; i++){
         movementQueues[i] = [[MovementQuards alloc]init];
    }
    
    //this is where you add the movemetns of the various limb
    [movementQueues[0] addPosition:0.00: 0.40: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.42: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.44: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.46: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.48: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.50: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.52: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.54: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.56: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.58: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.60: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.62: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.64: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.66: 0.00: 5.0]; //14
    [movementQueues[0] addPosition:0.00: 0.68: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.70: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.72: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.74: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.76: 0.00: 5.0];
    [movementQueues[0] addPosition:0.00: 0.78: 0.00: 5.0];
    
    /*[movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];
    [movementQueues[1] addPosition:1.05: 0.15: 0.05: 4.0];
    [movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];
    [movementQueues[1] addPosition:1.05: 0.15: 0.05: 4.0];
    [movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];*/

    
    [anim setQueue: &(movementQueues)];
    [anim animate: 0];
    
    /*[movementQueues[0] addPosition:1.05: 1.05: 1.05: 25.0];
    [movementQueues[0] addPosition:1.05: 1.05: 1.05: 20.0];
    
    [anim setQueue: &(movementQueues)];
    [anim animate: 1];*/

    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = YES;
    
    // show statistics such as fps and timing information
    scnView.showsStatistics = YES;
    
    // configure the view
    scnView.backgroundColor = [UIColor blackColor];
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
