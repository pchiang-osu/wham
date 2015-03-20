//
//  FrontViewController.m
//  YogaApp
//
//  Created by Gabe Aron on 2/21/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "FrontViewController.h"

@interface FrontViewController ()

@end

@implementation FrontViewController


bool frontTimerOn = false;
int frontNumberClicks = 0;
int frontFlag = 0;

int frontSecElapsed = 0;
int frontMinElapsed = 0;

int frontSecRem = 0;
int frontMinRem = 2;

NSTimer *frontTimer;

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
    
    
    
    
    if (frontMinRem != 0 || frontSecRem != 0) {
        
        
        if (frontSecElapsed != 60){
            //if (flag != 0){
            frontSecElapsed += 1;
            //}
        }
        
        if (frontSecRem != -1){
            frontSecRem -= 1;
        }
        
        if (frontSecElapsed == 60){
            frontSecElapsed = 0;
            frontMinElapsed += 1;
        }
        
        if (frontSecRem == -1){
            frontSecRem = 59;
            frontMinRem -= 1;
            
            /*if (flag == 0){
             secElapsed += 1;
             }*/
        }
        
        frontFlag++;
    }
    _frontTimeElapsed.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",frontMinElapsed,frontSecElapsed];  //how to write to label
    _frontTimeRem.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",frontMinRem,frontSecRem];
}



- (IBAction)frontStart:(id)sender {
    frontNumberClicks += 1;
    if (frontNumberClicks % 2 != 0){
        frontTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector:@selector(onTick)
                                               userInfo: nil
                                                repeats: YES];
    }
    else{
        [frontTimer invalidate];
        frontTimer = nil;
    }

}
@end
