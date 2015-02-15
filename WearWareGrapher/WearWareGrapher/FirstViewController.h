//
//  FirstViewController.h
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/17/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <WearWareFrameworkiOS/WearWareFrameworkiOS.h>


@interface FirstViewController : UIViewController <WWHeartRateDetectorDelegate>

@property (strong, nonatomic) IBOutlet UISlider *calibrationSlider;

@end

