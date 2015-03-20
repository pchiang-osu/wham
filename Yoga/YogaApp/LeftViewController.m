//
//  LeftViewController.m
//  YogaApp
//
//  Created by CS Team on 2/20/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController


bool leftTimerOn = false;
int leftNumberClicks = 0;
int leftFlag = 0;

int leftSecElapsed = 0;
int leftMinElapsed = 0;

int leftSecRem = 0;
int leftMinRem = 2;

NSTimer *leftTimer;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onTick {
    
    
    
    
    if (leftMinRem != 0 || leftSecRem != 0) {
        
        
        if (leftSecElapsed != 60){
            //if (flag != 0){
            leftSecElapsed += 1;
            //}
        }
        
        if (leftSecRem != -1){
            leftSecRem -= 1;
        }
        
        if (leftSecElapsed == 60){
            leftSecElapsed = 0;
            leftMinElapsed += 1;
        }
        
        if (leftSecRem == -1){
            leftSecRem = 59;
            leftMinRem -= 1;
            
            /*if (flag == 0){
             secElapsed += 1;
             }*/
        }
        
        leftFlag++;
    }
    _leftTimeElapsed.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",leftMinElapsed,leftSecElapsed];  //how to write to label
    _leftTimeRem.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",leftMinRem,leftSecRem];
}


- (IBAction)leftStartStopButton:(id)sender {
    leftNumberClicks += 1;
    if (leftNumberClicks % 2 != 0){
        leftTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector:@selector(onTick)
                                               userInfo: nil
                                                repeats: YES];
    }
    else{
        [leftTimer invalidate];
        leftTimer = nil;
    }
}
@end
