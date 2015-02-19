//
//  ViewController.m
//  firstIteration
//
//  Created by CS Team on 2/3/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

bool timerOn = false;
int numberClicks = 0;
int flag = 0;

int secElapsed = 0;
int minElapsed = 0;

int secRem = 0;
int minRem = 2;

NSTimer *timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    _LabelTimeElapsed.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minElapsed,secElapsed];  //how to write to label
    _LabelTimeRemaining.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minRem,secRem];
}


- (IBAction)ClickHereButton:(id)sender {
    
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