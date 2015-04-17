//
//  WWDevice.h
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


#import "WWProtocol.h"
#import "WWDeviceData.h"
#import "WWDeviceDelegate.h"

@interface WWDevice : NSObject<CBPeripheralDelegate> {
    @protected NSString * _manufacturerName;
    @protected NSString * _modelName;
    @protected NSNumber * _modelNumber;
    @protected NSNumber * _serialNumber;
    @protected BOOL _connected;
    @protected NSNumber * _RSSI;
    @protected CBPeripheral * _cbPeripheral;
}

- (instancetype)initWithPeripheral:(CBPeripheral*) peripheral;

// TODO: This needs to become protected somehow
@property CBPeripheral * cbPeripheral;

@property (weak, nonatomic) id<WWDeviceDelegate> delegate;

/**
 * The manufacturer name of the WearWare device.
 */
@property (readonly, nonatomic) NSString * manufacturerName;

/**
 * A human-readable description of the WearWare device.
 */
@property (readonly, nonatomic) NSString * modelName;

/**
 * Model number of the WearWare device.
 */
@property (readonly, nonatomic) NSNumber * modelNumber;

/**
 * Serial number of the WearWare device.
 */
@property (readonly, nonatomic) NSNumber * serialNumber;

/**
 * YES if device is active and connected and data can
 * be exchanged.
 * NO if device has not yet been connected to.
 */
@property (readonly) BOOL connected;

/**
 * Contains last RSSI of device. This value is available
 * regardless of whether there is an active connection.
 */
@property (readonly) NSNumber * RSSI;

/**
 * Returns the peripheral identifier assigned by iOS
 * to the device. See CBPeripheral.identifier for more information
 * on this property. Note that this value is stable across
 * reconnections on a SINGLE DEVICE, but not across multiple devices.
 *
 * @return Unique peripheral identifier UUID assigned by iOS.
 */
@property (readonly) NSUUID * peripheralIdentifier;

/**
 * The WWDevice's current values
 */
@property (nonatomic, readonly) NSDictionary * deviceValues;

/**
 * Sends an update to enable the requested WWCommandId.
 *
 * @param A WWCommandID you wish to enable on the device.
 */
- (void)enableData:(WWCommandId)dataId;

/**
 * Sends an update to disable the requested WWCommandId.
 *
 * @param A WWCommandID you wish to disable on the device.
 */
- (void)disableData:(WWCommandId)dataId;

/**
 * Changes the rate (in seconds) at which the WearWare device sends updates to
 * the iOS device.
 *
 * @param period Set how frequently (in seconds) the WearWare device should wake up and
 * broadcast updated data.
 */
- (void)changeUpdatePeriod:(NSUInteger)period;

/**
 * Sends a low-level command to the device.
 */
- (void)sendCommand:(WWCommandId)commandId value:(NSNumber*) value;

/**
 * Disconnects the device.
 */
- (void)disconnect;

@end
