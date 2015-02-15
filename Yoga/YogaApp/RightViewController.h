//
//  RightViewController.h
//  YogaApp
//
//  Created by CS Team on 2/14/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewController : UIViewController
- (IBAction)Start:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *TimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *TimeRemaining;

@end
