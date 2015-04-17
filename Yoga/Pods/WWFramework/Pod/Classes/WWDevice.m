//
//  WWDevice.m
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDevice.h"
#import "WWProtocol.h"

typedef NS_ENUM(NSInteger, WWDeviceTransmitState) {
    WWDeviceWaitingToTransmit,
    WWDeviceWaitingForReply
};

@interface WWDevice () {
    NSMutableDictionary *_deviceValues;
}

@property (strong, nonatomic) CBCharacteristic * dataChar;
@property (strong, nonatomic) CBCharacteristic * controlChar;

@property (strong, nonatomic) NSMutableData * queuedForTransmit;
@property (strong, nonatomic) NSMutableData * currentlyTransmitting;

@property (nonatomic) WWDeviceTransmitState currentTransmitState;

@end



@implementation WWDevice

- (instancetype)init
{
    self = [super init];
    
    _deviceValues = [NSMutableDictionary dictionary];
    _queuedForTransmit = [[NSMutableData alloc] init];
    _currentlyTransmitting = nil;
    _currentTransmitState = WWDeviceWaitingToTransmit;
    
    return self;
}

- (instancetype)initWithPeripheral:(CBPeripheral*) peripheral
{
    self = [self init];
    
    self.cbPeripheral = peripheral;
    self.cbPeripheral.delegate = self;
    
    return self;
}


- (void)disconnect {
    if (self.dataChar && [self.dataChar isNotifying]) {
        [self.cbPeripheral setNotifyValue:NO forCharacteristic:self.dataChar];
    }
}

- (void)enableData:(WWCommandId)dataId {
    [self.queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdEnable
                                                          commandValue:dataId]];
}

- (void)disableData:(WWCommandId)dataId {
    [self.queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdDisable
                                                          commandValue:dataId]];
}

- (void)changeUpdatePeriod:(NSUInteger)period {
    [self.queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdUpdateRate
                                                          commandValue:period]];
}

- (void)sendCommand:(WWCommandId)commandId value:(NSNumber*) value {
    [self.queuedForTransmit appendData:[WWProtocol encodeCommandPacket:commandId
                                                                 value:value]];
}

#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service: %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error
{
    if ([service.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_SERVICE_UUID]]) {
        NSLog(@"Got chars for QPP.");
        for (CBCharacteristic *aChar in service.characteristics) {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_DATA_CHAR_UUID]]) {
                NSLog(@"Found a data update characteristic!");
                
                self.dataChar = aChar;
                [peripheral setNotifyValue:YES forCharacteristic:aChar];
            }
            else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_CONTROL_CHAR_UUID]]) {
                NSLog(@"Found a control characteristic.");
                self.controlChar = aChar;
            }
        }
    }
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device
// notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_DATA_CHAR_UUID]]) {
        [self handleDataCharUpdate:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Current Notifying State: %d", characteristic.isNotifying);
    }
}

// Instance method to get the manufacturer name of the device
- (void)getManufacturerName:(CBCharacteristic *)characteristic
{
    NSString *manfName = [[NSString alloc] initWithData:characteristic.value
                                               encoding:NSUTF8StringEncoding];
    self.manufacturerName = manfName;
    
    NSLog(@"Manf: %@", manfName);
    return;
}

// Instance method to get the model name of the device
- (void)getModelName:(CBCharacteristic *)characteristic
{
    NSString *modelName = [[NSString alloc] initWithData:characteristic.value
                                                encoding:NSUTF8StringEncoding];
    [self setModelName:modelName];
    
    NSLog(@"Model: %@", modelName);
    return;
}

- (void)handleDataCharUpdate:(CBCharacteristic *)characteristic
{
    // first, transmit any command updates before the device goes to sleep
    [self handleSendingCommandUpdate];
    
    NSData * data = [characteristic value];
    NSDictionary * results = [WWProtocol parseDataPacket:data];
    [self addDeviceValues:results];
    
    for (NSValue* key in results) {
        [self.delegate device:self
            onDataValueUpdate:[key valueOfWWCommandId]
                        value:results[key]];
    }
}

// Handles sending a new device update
- (void)handleSendingCommandUpdate
{
    // 1. Do we have an outstanding transmissing which we're waiting to hear if it was succesful?
    // 2. Is there actually any data to transmit?
    
    if (self.currentTransmitState != WWDeviceWaitingToTransmit) {
        NSLog(@"handleSendingCommandUpdate: Cannot transmit command update when in state %ld",
              (long)self.currentTransmitState);
        return;
    }
    
    if ([self.queuedForTransmit length] == 0) {
        return; // no data to transmit
    }
    
    // Okay, let's transmit some data (if we have a connection)
    if (!self.cbPeripheral || !self.controlChar) {
        return;
    }

    // TODO: Race condition?
    self.currentlyTransmitting = self.queuedForTransmit;
    self.queuedForTransmit = [[NSMutableData alloc] init];
    
    NSLog(@"handleSendingCommandUpdate: Transmitting: %@, length %lu",
          self.currentlyTransmitting,
          (unsigned long)[self.currentlyTransmitting length]);
    
    self.currentTransmitState = WWDeviceWaitingForReply;
    [self.cbPeripheral writeValue:self.currentlyTransmitting
                forCharacteristic:self.controlChar
                             type:CBCharacteristicWriteWithResponse];
}

- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if (error) {
        NSLog(@"Error writing characteristic value: %@", [error localizedDescription]);
        
        // TODO: Attempt to re-transmit data
        self.currentTransmitState = WWDeviceWaitingToTransmit;
        self.currentlyTransmitting = nil;
    }
    else {
        self.currentTransmitState = WWDeviceWaitingToTransmit;
        self.currentlyTransmitting = nil;
    }
}



#pragma mark - Setters and Getters

- (NSString *)manufacturerName {
    return _manufacturerName;
}

- (void)setManufacturerName:(NSString *)manufacturerName {
    _manufacturerName = manufacturerName;
}

- (void)setModelName:(NSString *)modelName {
    _modelName = modelName;
}

- (NSDictionary *)deviceValues {
    return [_deviceValues copy];
}

- (void)setDeviceValues:(NSDictionary *)deviceValues
{
    _deviceValues = [deviceValues mutableCopy];
}

- (void)addDeviceValues:(NSDictionary *)dictionary
{
    [_deviceValues addEntriesFromDictionary:dictionary];
}

- (NSUUID *)peripheralIdentifier {
    return self.cbPeripheral ? self.cbPeripheral.identifier : nil;
}



@end
