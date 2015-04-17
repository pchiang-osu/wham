//
//  WWKnownDeviceScanner.h
//  WWFramework
//
//  Created by Taj Morton on 8/23/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

@import Foundation;

#include "TargetConditionals.h"
#if TARGET_OS_IPHONE
    @import CoreBluetooth;
    @import QuartzCore;
#else
    #import <IOBluetooth/IOBluetooth.h>
#endif


@protocol WWKnownDeviceScannerDelegate <NSObject>

- (void) onKnownDeviceFound:(CBPeripheral*)device;

@end

@interface WWKnownDeviceScanner : NSObject <CBCentralManagerDelegate>

@property (weak, nonatomic) id<WWKnownDeviceScannerDelegate> delegate;

@end
