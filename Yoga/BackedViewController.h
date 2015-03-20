//
//  BackedViewController.h
//  YogaApp
//
//  Created by Gabe Aron on 2/22/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *backTimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *backTimeRem;
- (IBAction)backStart:(id)sender;

@end
