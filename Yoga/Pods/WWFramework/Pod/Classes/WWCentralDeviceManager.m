//
//  WWCentralDeviceManager.m
//  WWFramework
//
//  Created by Rutger Farry on 12/19/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import "WWDeviceManagerDelegate.h"
#import "WWCentralDeviceManager.h"

NSString * const WWDeviceDidConnect = @"WWDeviceDidConnect";
NSString * const WWDeviceDidDisconnect = @"WWDeviceDidDisconnect";
NSString * const WWDeviceDidUpdate = @"WWDeviceDidUpdate";


@implementation NSNotificationCenter (WWExtensions)

- (id<NSObject>)addObserverForWWDeviceUpdates:(NSArray *)updates
                                   usingBlock:(void (^)(NSNotification * notification))block
{
    updates = updates ? updates : @[WWDeviceDidConnect, WWDeviceDidDisconnect, WWDeviceDidUpdate];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    NSMutableArray *anonObjects = [NSMutableArray array];
    
    for (NSString * update in updates) {
        [anonObjects addObject:[center addObserverForName:update
                                                   object:nil
                                                    queue:nil
                                               usingBlock:block]];
    }
    return anonObjects;
}

@end

@interface WWCentralDeviceManager () <WWDeviceDelegate, WWDeviceManagerDelegate>

@property (strong, nonatomic) WWDeviceManager *deviceManager;
@property (nonatomic) BOOL waitingToConnect;    

@end

@implementation WWCentralDeviceManager

#pragma mark - Class methods

// Singleton pattern
+ (instancetype)sharedCentralDeviceManager
{
    static WWCentralDeviceManager *sharedDeviceManager;
    
    if (!sharedDeviceManager)
        sharedDeviceManager = [[self alloc] initPrivate];
    
    return sharedDeviceManager;
}



#pragma mark - Initializers

// Raise exception if user tries to init using the standard method
- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[WWCentralDeviceManager sharedCentralDeviceManager"];
    return nil;
}

// Secret initializer for singleton pattern
- (instancetype)initPrivate
{
    if (self = [super init])
    {
        // Alloc and init properties
        self.deviceManager = [WWDeviceManager new];
        self.deviceManager.delegate = self;
        self.devices = [NSMutableArray array];
        self.waitingToConnect = NO;
    }
    return self;
}



#pragma mark - Public Methods

- (void)connect
{
    CBCentralManagerState managerState = self.deviceManager.centralManager.state;
    if (managerState == CBCentralManagerStatePoweredOn) {
        [self.deviceManager scanForDevices];
        self.waitingToConnect = NO;
    }
    else {
        self.waitingToConnect = YES;
    }
}



#pragma mark - Internal Device Management

/*
 * This delegate function is called when a new WearWare device is found during scanning.
 * At this point, the WearWare and iOS devices have NOT performed the "connection"
 * step of the process, so no information is being exchanged. The device UUID is compared
 * with previously connected device UUIDs to ensure that a device is not connected twice.
 *
 * As is, this function begins the connection process automatically. When the connection is
 * established, the onDeviceConnected() function (below) is called. A real application would
 * probably want to show a list of devices to the user or decide to connect automatically
 * based off of the peripheralIdentifier property.
 */
- (void)manager:(WWDeviceManager *)manager onDeviceFound:(WWDevice *)device
{
    NSArray * connectedDeviceUUIDs = [self.devices valueForKeyPath:@"peripheralIdentifier"];
    if (![connectedDeviceUUIDs containsObject:device.peripheralIdentifier]) {
        device.delegate = self;
        [self.deviceManager connectToDevice:device];
    }
}

/*
 * This delegate function is called when the connection process between the iOS device and
 * WearWare device has been completed. This method sends a notification on the default
 * center. After this method is called, the delegate will automatically receive updates from 
 * the WearWare device as it sends out new updates.
 *
 * After connection is established, the developer should request a data type and update period
 * from the device. Otherwise the device will be connected but send no data. 
 */
- (void)manager:(WWDeviceManager *)manager onDeviceConnected:(WWDevice *)device
{
    NSLog(@"Connected to device with UUID: %@", device.peripheralIdentifier);
    [self.devices addObject:device];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:WWDeviceDidConnect object:device];
}

/**
 * This delegate method is called when a connected WWDevice sends an update.
 * Currently it broadcasts a notification using NSNotificationCenter
 */
- (void)device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value
{
    WWDeviceData *update = [WWDeviceData deviceDataWithData:value sender:device andDataId:dataId];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:WWDeviceDidUpdate object:update];
}

- (void)manager:(WWDeviceManager *)manager onBluetoothStateChange:(CBCentralManagerState)state
{
    if (state == CBCentralManagerStatePoweredOn && self.waitingToConnect) {
        [self connect];
    }
}

- (void)onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    [self.devices removeObject:device];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:WWDeviceDidDisconnect object:device];
    if (error) {
        NSLog(@"Disconnected from %@ with error: %@", device, error);
    }
    else {
        NSLog(@"Disconnected from %@", device);
    }
}



#pragma mark - Debugging

- (void)printAllDevices
{
    NSLog(@"CONNECTED DEVICES:");
    for (WWDevice * device in self.devices) {
        NSLog(@"    Device: %@, ID: %@", device, device.peripheralIdentifier);
    }
}


@end
