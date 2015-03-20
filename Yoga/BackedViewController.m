//
//  BackedViewController.m
//  YogaApp
//
//  Created by Gabe Aron on 2/22/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "BackedViewController.h"

@interface BackedViewController ()

@end

@implementation BackedViewController

bool backTimerOn = false;
int backNumberClicks = 0;
int backFlag = 0;

int backSecElapsed = 0;
int backMinElapsed = 0;

int backSecRem = 0;
int backMinRem = 2;

NSTimer *backTimer;

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
    
    
    
    
    if (backMinRem != 0 || backSecRem != 0) {
        
        
        if (backSecElapsed != 60){
            //if (flag != 0){
            backSecElapsed += 1;
            //}
        }
        
        if (backSecRem != -1){
            backSecRem -= 1;
        }
        
        if (backSecElapsed == 60){
            backSecElapsed = 0;
            backMinElapsed += 1;
        }
        
        if (backSecRem == -1){
            backSecRem = 59;
            backMinRem -= 1;
            
            /*if (flag == 0){
             secElapsed += 1;
             }*/
        }
        
        backFlag++;
    }
    _backTimeElapsed.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",backMinElapsed,backSecElapsed];  //how to write to label
    _backTimeRem.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",backMinRem,backSecRem];
}


- (IBAction)backStart:(id)sender {
    backNumberClicks += 1;
    if (backNumberClicks % 2 != 0){
        backTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector:@selector(onTick)
                                               userInfo: nil
                                                repeats: YES];
    }
    else{
        [backTimer invalidate];
        backTimer = nil;
    }

}
@end
