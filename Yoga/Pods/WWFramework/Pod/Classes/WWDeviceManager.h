//
//  WWDeviceManager.h
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
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

#import "WWDevice.h"
#import "WWDeviceManagerDelegate.h"

@interface WWDeviceManager: NSObject <CBCentralManagerDelegate>

@property (weak, nonatomic) id<WWDeviceManagerDelegate> delegate;
@property (nonatomic, strong) NSString   *connected;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *device;

@property (nonatomic, strong) NSString   *manufacturer;

/**
 * Begins scanning for WearWare devices which are in advertising mode
 * and available to be connected to. The delegate's
 * onDeviceFound() function is called when a device is found.
 *
 * @param tagUUIDs An optional array of UUIDs of tags to scan for
 * (pass nil for all tags).
 */
- (void)scanForDevices;

/**
 * Stops scanning for devices.
 */
- (void)stopScan;

/**
 * Attempts to establish a connection to a WWDevice discovered
 * during scanning. If connection is successful, the delegate's
 * onDeviceConnected() function is called.
 *
 * @param device Device to connect to
 */
- (void)connectToDevice:(WWDevice *)device;

- (void)disconnectDevice:(WWDevice *)device;

@end

