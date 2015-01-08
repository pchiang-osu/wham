//
//  WWCentralDeviceManager.h
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/19/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWDeviceDelegate.h"
#import "WWDeviceManager.h"

@interface WWCentralDeviceManager : NSObject

@property (weak, nonatomic) id delegate;
@property (nonatomic) float testSliderValue;

@property (nonatomic) NSNumber *ADCData;
@property (nonatomic) NSNumber *temperatureData;
@property (nonatomic) NSNumber *pedometerData;
@property (nonatomic) NSNumber *batteryData;
@property (nonatomic) NSArray *accelerometerData;

@property (nonatomic) WWCommandId enabledData;


// Returns the shared central device manager or initializes a new one if it doesn't exist
+ (instancetype)sharedCentralDeviceManager;

- (void)connect;
- (BOOL)isConnectedToDevice;
- (void)disableAllData;


// Abstracted method that disables all data output from device except for one
// @param commandId The WWCommandId you wish for the device to transmit
// @param period The frequency (in 10s of milliseconds) at which you wish the device to transmit

- (void)requestData:(WWCommandId)commandId andUpdatePeriod:(uint16_t)period;

@end
