//
//  RightViewController.m
//  YogaApp
//
//  Created by CS Team on 2/14/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController


/*bool timerOn = false;
int numberClicks = 0;
int flag = 0;

int secElapsed = 0;
int minElapsed = 0;

int secRem = 0;
int minRem = 2;
NSTimer *timer;*/

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
    
    
    
    
    if (minRem != 0 || secRem != 0) {
        
        
        if (secElapsed != 60){
            //if (flag != 0){
            secElapsed += 1;
            //}
        }
        
        if (secRem != -1){
            secRem -= 1;
        }
        
        if (secElapsed == 60){
            secElapsed = 0;
            minElapsed += 1;
        }
        
        if (secRem == -1){
            secRem = 59;
            minRem -= 1;
            
            /*if (flag == 0){
             secElapsed += 1;
             }*/
        }
        
        flag++;
    }
    _TimeElapsed.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minElapsed,secElapsed];  //how to write to label
    _TimeRemaining.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minRem,secRem];
}

- (IBAction)Start:(id)sender {
    
    numberClicks += 1;
    if (numberClicks % 2 != 0){
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector:@selector(onTick)
                                               userInfo: nil
                                                repeats: YES];
    }
    else{
        [timer invalidate];
        timer = nil;
    }
}
@end
