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
    MovementQueue = [[MovementQuards alloc]init];
    MovementQuards *movementQueue2 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue3 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue4 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue5 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue6 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue7 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue8 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue9 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue10 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue11 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue12 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue13 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue14 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue15 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue16 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue17 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue18 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue19 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue20 = [[MovementQuards alloc]init];
    
    MovementQuards *movementQueue21 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue22 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue23 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue24 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue25 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue26 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue27 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue28 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue29 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue30 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue31 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue32 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue33 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue34 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue35 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue36 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue37 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue38 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue39 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue40 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue41 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue42 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue43 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue44 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue45 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue46 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue47 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue48 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue49 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue50 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue51 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue52 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue53 = [[MovementQuards alloc]init];
    MovementQuards *movementQueue54 = [[MovementQuards alloc]init];
    
    
    //this is where you add the movemetns of the various limbs
    [MovementQueue addPosition:90.0: 90.0: 90.0: 3.0];
    [MovementQueue addPosition:85.0: 45.0: 20.0: 4.0];
    
    [movementQueue2 addPosition:90.0: 45.0: 20.0: 12.0];
    [movementQueue2 addPosition:90.0: 90.0: 90.0: 13.0];
    [movementQueue2 addPosition:85.0: 45.0: 20.0: 14.0];
    
    [movementQueue3 addPosition:90.0: 45.0: 20.0: 17.0];
    [movementQueue3 addPosition:90.0: 90.0: 90.0: 18.0];
    [movementQueue3 addPosition:90.0: 90.0: 90.0: 19.0];
    
    [movementQueue54 addPosition:90.0: 45.0: 20.0: 2.0];
    
    /*[movementQueue5 addPosition:90.0: 45.0: 20.0: 21.0];
    
    [movementQueue6 addPosition:90.0: 45.0: 20.0: 22.0];
    
    [movementQueue7 addPosition:90.0: 45.0: 20.0: 23.0];
    
    [movementQueue8 addPosition:90.0: 45.0: 20.0: 24.0];
    
    [movementQueue9 addPosition:90.0: 45.0: 20.0: 25.0];
    
    [movementQueue10 addPosition:90.0: 45.0: 20.0: 26.0];
    
    [movementQueue11 addPosition:90.0: 45.0: 20.0: 27.0];
    
    [movementQueue12 addPosition:90.0: 45.0: 20.0: 28.0];
    
    [movementQueue13 addPosition:90.0: 45.0: 20.0: 29.0];
    
    [movementQueue14 addPosition:90.0: 45.0: 20.0: 30.0];
    
    [movementQueue15 addPosition:90.0: 45.0: 20.0: 31.0];
    
    [movementQueue16 addPosition:90.0: 45.0: 20.0: 32.0];
    
    [movementQueue17 addPosition:90.0: 45.0: 20.0: 33.0];
    
    [movementQueue18 addPosition:90.0: 45.0: 20.0: 35.0];
    
    [movementQueue19 addPosition:90.0: 45.0: 20.0: 35.0];
    
    [movementQueue20 addPosition:90.0: 45.0: 20.0: 36.0];*/
    
    
    
    [anim setQueue: (MovementQueue): (movementQueue2): (movementQueue3): (movementQueue4): (movementQueue5): (movementQueue6): (movementQueue7): (movementQueue8): (movementQueue9): (movementQueue10): (movementQueue11): (movementQueue12): (movementQueue13): (movementQueue14): (movementQueue15): (movementQueue16): (movementQueue17): (movementQueue18): (movementQueue19): (movementQueue20): (movementQueue21): (movementQueue22): (movementQueue23): (movementQueue24): (movementQueue25): (movementQueue26): (movementQueue27): (movementQueue28): (movementQueue29): (movementQueue30): (movementQueue31): (movementQueue32): (movementQueue33): (movementQueue34): (movementQueue35): (movementQueue36): (movementQueue37): (movementQueue38): (movementQueue39): (movementQueue40): (movementQueue41): (movementQueue42): (movementQueue43): (movementQueue44): (movementQueue45): (movementQueue46): (movementQueue47): (movementQueue48): (movementQueue49): (movementQueue50): (movementQueue51): (movementQueue52): (movementQueue53): (movementQueue54)];
    
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
