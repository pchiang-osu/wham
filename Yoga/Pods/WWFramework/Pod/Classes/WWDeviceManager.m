//
//  WWDeviceManager.m
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDeviceManager.h"
#import "WWProtocol.h"

@interface WWKnownDeviceDiscoverDelegate: NSObject <CBCentralManagerDelegate>

@end


@implementation WWDeviceManager

NSMutableDictionary * maintainedDevices;

- (instancetype) init
{
    self = [super init];
    
    maintainedDevices = [[NSMutableDictionary alloc] init];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    NSLog(@"Created a WWDeviceManager...");
    return self;
}

- (void)scanForDevices
{
    NSArray * services = @[[CBUUID UUIDWithString:WEARWARE_SERVICE_UUID]];
    
    NSLog(@"Starting scan...");
    [self.centralManager scanForPeripheralsWithServices:services options:nil];
}

- (void)stopScan
{
    [self.centralManager stopScan];
}

- (void)connectToDevice:(WWDevice *)device
{
    [self.centralManager connectPeripheral:device.cbPeripheral options:nil];
}

- (void)disconnectDevice:(WWDevice *)device {
    [device disconnect];
    [self.centralManager cancelPeripheralConnection:device.cbPeripheral];
}

#pragma mark - CBCentralManagerDelegate

// Method called when BLE peripheral successfully connects
- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral
{
    if ([maintainedDevices objectForKey:peripheral.identifier] == nil) {
        NSLog(@"Error - received didConnectPeripheral() for an unknown device: %@", peripheral);
        return;
    }
        
    [peripheral discoverServices:nil];
    [self.delegate manager:self
         onDeviceConnected:[maintainedDevices objectForKey:peripheral.identifier]];
}

// This is called with the CBPeripheral class as its main input parameter.
// This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    WWDevice * device = [[WWDevice alloc] initWithPeripheral:peripheral];
    maintainedDevices[peripheral.identifier] = device;
    [self.delegate manager:self onDeviceFound:device];
}

// Method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@"Bluetooth Central Manager state changed to unknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"Bluetooth Central Manager state changed to resetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"Bluetooth Central Manager state changed to unsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"Bluetooth Central Manager state changed to unauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"Bluetooth Central Manager state changed to powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"Bluetooth Central Manager state changed to powered on");
            break;
    }
    
    [self.delegate manager:self onBluetoothStateChange:[central state]];
}

- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error
{
    if (error) {
        NSLog(@"Peripheral disconnected with error: %@",
              [error localizedDescription]);
    }
    else {
        NSLog(@"Peripheral disconnected cleanly.");
    }
    
    WWDevice * dev = [maintainedDevices objectForKey:peripheral.identifier];
    if (dev != nil) {
        // TODO: Don't reach inside WWDevice's delegate like that:
        [dev.delegate onDeviceDisconnected:dev error:error];
    }
}

@end
