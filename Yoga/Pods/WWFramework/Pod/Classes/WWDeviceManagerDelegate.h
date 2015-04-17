//
//  WWDeviceManagerDelegate.h
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

@import Foundation;

#import "WWDevice.h"

@class WWDeviceManager;

@protocol WWDeviceManagerDelegate <NSObject>

/**
 * Called when the underlying bluetooth subsystem changes state.
 * @param manager The device manager providing the update.
 * @param state The new state of the Bluetooth subsystem.
 */
- (void)manager:(WWDeviceManager *)manager onBluetoothStateChange:(CBCentralManagerState)state;

/**
 * Called when a new WearWare device is detected during scanning.
 * @param manager The device manager providing the update.
 * @param device The newly discovered WearWare device.
 */
- (void)manager:(WWDeviceManager *)manager onDeviceFound:(WWDevice *)device;

/**
 * Called when a successful connection is established with a WearWare device.
 * @param manager The device manager providing the update.
 * @param device The successfully connected WearWare device.
 */

- (void)manager:(WWDeviceManager *)manager onDeviceConnected:(WWDevice *)device;
@end
