//
//  WWDeviceSim.h
//  BTLE2
//
//  Created by Taj Morton on 8/13/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDevice.h"

// TODO: This class should really be a WWPedometerDeviceSim
@interface WWDeviceSim : WWDevice

- (id) initWithInitialValue:(NSInteger)initialValue;

- (void) startSimulation;
- (void) stopSimulation;

/**
 * A human-readable description of the WearWare device.
 */
@property NSString * modelName;

/**
 * Model number of the WearWare device.
 */
@property NSNumber * modelNumber;

/**
 * Serial number of the WearWare device.
 */
@property NSNumber * serialNumber;

/**
 * TRUE if device is active and connected and data can
 * be exchanged.
 * FALSE if device has not yet been connected to.
 */
@property BOOL connected;

/**
 * Contains last RSSI of device. This value is available
 * regardless of if there is an active connection.
 */
@property NSNumber * RSSI;


@end
