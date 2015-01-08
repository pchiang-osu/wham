//
//  WWCentralDeviceManager.m
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/19/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//


#import "WWDeviceManagerDelegate.h"
#import "WWDevice.h"
#import "WWCentralDeviceManager.h"


@interface WWCentralDeviceManager () <WWDeviceDelegate, WWDeviceManagerDelegate>

@property (strong, nonatomic) WWDeviceManager *deviceManager;
@property (strong, nonatomic) WWDevice *device;
@property (nonatomic) BOOL isConnectedToDevice;

@end

@implementation WWCentralDeviceManager

+ (instancetype)sharedCentralDeviceManager
{
    static WWCentralDeviceManager *sharedCentralDeviceManager;
    
    if (!sharedCentralDeviceManager)
        sharedCentralDeviceManager = [[self alloc] initPrivate];
    
    return sharedCentralDeviceManager;
}

#pragma mark - Initializers

// Raise an exception if user tries to init using the standard method
- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[WWCentralDeviceManager sharedCentralDeviceManager"];
    return nil;
}

// Actual secret initializer
- (instancetype)initPrivate
{
    if (self = [super init])
    {
        // Alloc and init properties
        self.deviceManager = [WWDeviceManager new];
        self.deviceManager.delegate = self;
    }
    return self;
}



#pragma mark - Public Methods

- (void)connect
{
    NSLog(@"Scanning...");
    [self.deviceManager scanForDevices:nil];
}

- (void)requestData:(WWCommandId)commandId andUpdatePeriod:(uint16_t)period
{
    [self.device changeUpdatePeriod:1000];
    [self disableAllData];
    NSLog(@"Changing update period to: 1000");
    NSLog(@"Enabling: %d", commandId);

    // Set enabledData property to let other classes know what
    // data the centralDeviceManager is currently recieving
    if (commandId) {
        [self.device enableData:@[[NSValue valueWithWWCommandId:commandId]]];
        switch (commandId) {
            case WWCommandIdADCSample:
                self.enabledData = WWCommandIdADCSample;
                break;
            case WWCommandIdTemperature:
                self.enabledData = WWCommandIdTemperature;
                break;
            case WWCommandIdPedometer:
                self.enabledData = WWCommandIdPedometer;
                break;
            case WWCommandIdBattery:
                self.enabledData = WWCommandIdBattery;
                break;
            case WWCommandIdAccelerometer:
                self.enabledData = WWCommandIdAccelerometer;
            default:
                break;
        }
    }
    [self.device changeUpdatePeriod:period];
    NSLog(@"Changing update period to: %d", period);

}

- (void)disableAllData
{
    if (self.enabledData != WWCommandIdReserved) {
        NSLog(@"Disabling: %d", self.enabledData);
        [self.device disableData:@[[NSValue valueWithWWCommandId:self.enabledData]]];
        self.enabledData = 0;
    }
    else
        NSLog(@"Wont disable 0");
}


#pragma mark - Internal Device Management

/*
 * This delegate function is called when a new WearWare device is found during scanning.
 * At this point, the WearWare and iOS devices have NOT performed the "connection"
 * step of the process, so no information is being exchanged. This would be
 * a good place to decide if the app wants to connect to the WearWare device or not. To
 * determine if a WearWare device has been connected to previously, check the
 * device.peripheralIdentifier field. This is a unique UUID associated with single WearWare
 * device (like a MAC address).
 *
 * As is, this function begins the connection process automatically. When the connection is
 * established, the onDeviceConnected() function (below) is called. A real application would
 * probably want to show a list of devices to the user or decide to connect automatically
 * based off of the peripheralIdentifier property.
 */
- (void)manager:(WWDeviceManager *)manager onDeviceFound:(WWDevice *)device {
    self.device = device;
    self.device.delegate = self;
    [self.deviceManager connectToDevice:device];
}

/*
 * This delegate function is called when the connection process between the iOS device and
 * WearWare device has been completed. After this function is called, the delegate will automatically
 * begin receiving updates from the WearWare device as it sends out new updates.
 *
 * As it stands, this function sets the WWDevice's delegate to the ViewController and
 * requests that the WearWare device include battery voltage, temperature, and pedometer (total steps)
 * in its periodic updates. When an update is received, the onDataValueUpdate() function (below) is called.
 */
- (void)manager:(WWDeviceManager *)manager onDeviceConnected:(WWDevice *)device {
    NSLog(@"WWAppDelegate: connected!");
    
    self.device = device;
    
    // Request updates from the WearWare device every 10 milliseconds
    [device changeUpdatePeriod:1];
    NSLog(@"Changing update period to: 1");
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [device enableData:[NSArray arrayWithObjects:
                        [NSValue valueWithWWCommandId:WWCommandIdADCSample],
                        nil]];
}

/**
 * This delegate function is called when a connected WWDevice sends an update
 * to a data field.
 * This function simply displays the newly received data into labels in the view.
 */
- (void) device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value {
    if      (dataId == WWCommandIdADCSample) {
        self.ADCData = [(NSArray *)value objectAtIndex:0];
    }
    else if (dataId == WWCommandIdTemperature) {
        self.temperatureData = (NSNumber *)value;
    }
    else if (dataId == WWCommandIdPedometer) {
        self.pedometerData = (NSNumber *)value;
    }
    else if (dataId == WWCommandIdBattery) {
        self.batteryData = (NSNumber *)value;
    }
    else if (dataId == WWCommandIdAccelerometer) {
        self.accelerometerData = (NSArray *)value;
    }
}

- (void)manager:(WWDeviceManager *)manager onBluetoothStateChange:(CBCentralManagerState)state
{
    
}

- (void)onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    self.isConnectedToDevice = NO;
    NSLog(@"Disconnected");
}



@end
