//
//  WWDevice.h
//  BTLE2
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "TargetConditionals.h"
#if TARGET_OS_IPHONE
    @import CoreBluetooth;
    @import QuartzCore;
#else
    #import <IOBluetooth/IOBluetooth.h>
#endif


#include "WWProtocol.h"
#include "WWDeviceDelegate.h"

@interface WWDevice : NSObject<CBPeripheralDelegate> {
    @protected NSString * _manufacturerName;
    @protected NSString * _modelName;
    @protected NSNumber * _modelNumber;
    @protected NSNumber * _serialNumber;
    @protected BOOL _connected;
    @protected NSNumber * _RSSI;
    @protected CBPeripheral * _cbPeripheral;
}

- (id) initWithPeripheral:(CBPeripheral*) peripheral;

// TODO: This needs to become protected somehow
@property CBPeripheral * cbPeripheral;

@property (weak, nonatomic) id<WWDeviceDelegate> delegate;

/**
 * A human-readable description of the WearWare device.
 */
@property (readonly) NSString * modelName;

/**
 * Model number of the WearWare device.
 */
@property (readonly) NSNumber * modelNumber;

/**
 * Serial number of the WearWare device.
 */
@property (readonly) NSNumber * serialNumber;

/**
 * TRUE if device is active and connected and data can
 * be exchanged.
 * FALSE if device has not yet been connected to.
 */
@property (readonly) BOOL connected;

/**
 * Contains last RSSI of device. This value is available
 * regardless of if there is an active connection.
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
- (NSUUID *)peripheralIdentifier;

/**
 * Retrieves the the last received data value for the specified
 * data ID, or nil if there is no data available. Data can be unavailable
 * for multiple reasons, including the device being unconnected, the device
 * not providing the requested data type, or an invalid data ID being specified.
 *
 * TODO: Likely should return a timestamp as well so we can detect old data
 * (or discourage use of this function and encourage use of onDataReceived()
 * in the delegate instead.
 *
 * @param dataId ID of the data to get.
 * @return The last received data of the specified ID, or nil if unavailable.
 */
- (NSObject *)lastData:(WWCommandId) dataId;

/**
 * A dictionary containing the last data value of each type received
 * from the device.
 */
- (NSDictionary *)getAllDeviceData;

/**
 * Sends an update to enable the requested data IDs (each
 * element of dataIds should be a ::WWCommandId instance).
 *
 * @param An array of ::WWCommandId items to enable on the device.
 */
- (void)enableData:(NSArray *)dataIds;

/**
 * Sends an update to disable the requested data IDs (each
 * element of dataIds should be a ::WWCommandId instance).
 *
 * @param An array of ::WWCommandId items to disable on the device.
 */
- (void)disableData:(NSArray *)dataIds;

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

- (void)disconnect;

@end
