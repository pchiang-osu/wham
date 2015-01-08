//
//  WWViewController.h
//  WearWareiOSTest
//
//  Created by Taj Morton on 9/5/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WearWareFrameworkiOS/WearWareFrameworkiOS.h>

@interface WWViewController : UIViewController<WWDeviceDelegate, WWDeviceManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateTimestampLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanForDevicesButton;
@property (weak, nonatomic) IBOutlet UILabel *deviceStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelLabel;



@end
