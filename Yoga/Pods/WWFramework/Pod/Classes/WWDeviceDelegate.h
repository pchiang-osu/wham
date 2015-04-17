//
//  WWDeviceDelegate.h
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

@import Foundation;

#import "WWProtocol.h"

@class WWDevice;

@protocol WWDeviceDelegate <NSObject>

/**
 * Called when a data update is received from a WearWare device.
 * @param device The device generating the update.
 * @param dataId The data/command ID of the update.
 * @param value The data value of the update (processed into the appropriate data type).
 */
- (void)device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value;

- (void)onDeviceDisconnected:(WWDevice *)device error:(NSError*)error;

@end
