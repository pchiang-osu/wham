//
//  WWDeviceManagerSim.m
//  BTLE2
//
//  Created by Taj Morton on 8/13/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDeviceManagerSim.h"
#import "WWDeviceSim.h"

@implementation WWDeviceManagerSim
{
    NSArray* devices;
}

- (id) init:(NSArray*)initialDeviceValues
{
    self = [super init];
    
    devices = [self createDevices:initialDeviceValues];
    NSLog(@"Created a WWDeviceManagerSim... %@", devices);
    return self;
}

- (void)scanForDevices:(NSArray *)tagUUIDs
{
    NSLog(@"Starting scan...");
    
    for (id device in devices) {
        NSLog(@" scanned device: %@", [[device peripheralIdentifier] UUIDString]);
        [[self delegate] manager:self onDeviceFound:device];
    }
}

- (void)stopScan
{
    // can't do anything here
}

- (void)connectToDevice:(WWDevice *)device
{
    ((WWDeviceSim*)device).connected = TRUE;
    [((WWDeviceSim*)device) startSimulation];
    [[self delegate] manager:self onDeviceConnected:device];
}

- (NSArray *)createDevices:(NSArray*)initialDeviceValues
{
    NSMutableArray * devs = [[NSMutableArray alloc] init];
    for (id devVal in initialDeviceValues) {
        WWDeviceSim * sim = [[WWDeviceSim alloc] initWithInitialValue:[devVal integerValue]];
        
        sim.RSSI = @(-(arc4random() % 100));
        sim.modelName = @"WearWare Pedometer";
        sim.modelNumber = @1;
        
        [devs addObject:sim];
    }
    
    return devs;
}

@end
