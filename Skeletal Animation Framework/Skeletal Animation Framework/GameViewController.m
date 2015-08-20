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
    
    //set up queue
    for (int i = 0; i < 52; i++){
         movementQueues[i] = [[MovementQuards alloc]init];
    }
    
    //this is where you add the movemetns of the various limb
    [movementQueues[0] addPosition:1.05: 1.05: 1.05: 5.0];
    [movementQueues[0] addPosition:1.05: 0.15: 0.05: 5.0];
    [movementQueues[0] addPosition:1.05: 1.05: 1.05: 3.0];
    [movementQueues[0] addPosition:1.05: 0.15: 0.05: 5.0];
    [movementQueues[0] addPosition:1.05: 1.05: 1.05: 5.0];
    [movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];
    [movementQueues[1] addPosition:1.05: 0.15: 0.05: 4.0];
    [movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];
    [movementQueues[1] addPosition:1.05: 0.15: 0.05: 4.0];
    [movementQueues[1] addPosition:1.05: 1.05: 1.05: 4.0];
    
    
    
    
    [anim setQueue: &(movementQueues)];
    
    // retrieve the nodes
    [anim createNodes];
    
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
