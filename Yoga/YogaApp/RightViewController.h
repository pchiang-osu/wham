//
//  RightViewController.h
//  YogaApp
//
//  Created by CS Team on 2/14/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

bool timerOn = false;
int numberClicks = 0;
int flag = 0;

int secElapsed = 0;
int minElapsed = 0;

int secRem = 0;
int minRem = 2;
NSTimer *timer;

@interface RightViewController : UIViewController
- (IBAction)Start:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *TimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *TimeRemaining;

@end
