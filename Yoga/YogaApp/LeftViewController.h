//
//  LeftViewController.hRightViewController
//  YogaApp
//
//  Created by Gabe Aron on 2/20/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *leftTimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeRem;
- (IBAction)leftStartStopButton:(id)sender;


@end
