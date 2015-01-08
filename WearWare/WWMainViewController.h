//
//  WWMainViewController.h
//  WearWare
//
//  Created by Rutger Farry on 12/14/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWDeviceDelegate.h"
#import "WWDeviceManagerDelegate.h"

@interface WWMainViewController : UIViewController <WWDeviceDelegate, WWDeviceManagerDelegate>

@property WWDeviceManager *deviceManager;
@property WWDevice *device;

@end

