//
//  WWDeviceManager.m
//  BTLE2
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDeviceManager.h"
#import "WWProtocol.h"

@interface WWKnownDeviceDiscoverDelegate: NSObject <CBCentralManagerDelegate>
@end

@implementation WWKnownDeviceDiscoverDelegate
@end

@implementation WWDeviceManager

NSMutableDictionary * maintainedDevices;

- (id) init
{
    self = [super init];
    
    maintainedDevices = [[NSMutableDictionary alloc] init];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    NSLog(@"Created a WWDeviceManager...");
    return self;
}

- (void)scanForDevices:(NSArray *)tagUUIDs
{
    //NSArray * services = @[[CBUUID UUIDWithString:QUINTIC_DEVICE_INFO_SERVICE], [CBUUID UUIDWithString:QUINTIC_BATTERY_SERVICE]];
    NSArray * services = @[[CBUUID UUIDWithString:WEARWARE_SERVICE_UUID]];
    
    NSLog(@"Starting scan...");
    [self.centralManager scanForPeripheralsWithServices:services options:nil];
}


- (NSArray *)getKnownDevices:(NSArray *)identifiers {
    return nil;
}

- (NSArray *)scanForKnownDevices:(NSArray *)identifiers {
    return nil;
}

- (void)connectToKnownDevice:(NSUUID *)identifier {
    
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

// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    /*[peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    self.connected = [NSString stringWithFormat:@"Connected: %@", peripheral.state == CBPeripheralStateConnected ? @"YES" : @"NO"];
    NSLog(@"%@", self.connected);
     */
    
    if ([maintainedDevices objectForKey:peripheral.identifier] == nil) {
        NSLog(@"WWDeviceManager: Error - received didConnectPeripheral() for an unknown device: %@", peripheral);
        return;
    }
        
    [peripheral discoverServices:nil];
    [self.delegate manager:self onDeviceConnected:[maintainedDevices objectForKey:peripheral.identifier]];
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    /*
    NSLog(@"Found something!");
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    //if ([localName length] > 0) {
    NSLog(@"Found tag %@", localName);
    [self.centralManager stopScan];
    self.device = peripheral;
    peripheral.delegate = self;
    [self.centralManager connectPeripheral:peripheral options:nil];
    //}
     */
    
    //NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    //if ([localName isEqualToString:WEARWARE_SERVICE_LOCAL_NAME]) {
        WWDevice * device = [[WWDevice alloc] initWithPeripheral:peripheral];
        [maintainedDevices setObject:device forKey:peripheral.identifier];
        
        [self.delegate manager:self onDeviceFound:device];
    /*}
    else {
        NSLog(@"Found a BLE device, but was not a WearWare device: %@", localName);
    }*/
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready. Now ready to scan!");
        
        /*
        NSArray * services = @[[CBUUID UUIDWithString:QUINTIC_DEVICE_INFO_SERVICE], [CBUUID UUIDWithString:QUINTIC_BATTERY_SERVICE]];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
        
        [central scanForPeripheralsWithServices:nil options:options];
         */
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
    
    [self.delegate manager:self onBluetoothStateChange:[central state]];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
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
