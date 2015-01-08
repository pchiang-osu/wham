//
//  WWDevice.m
//  BTLE2
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDevice.h"
#import "WWProtocol.h"

@implementation WWDevice

typedef NS_ENUM(NSInteger, WWDeviceTransmitState) {
    WWDevice_WaitingToTransmit,
    WWDevice_WaitingForReply
};


NSMutableDictionary * deviceValues;
CBCharacteristic * dataChar;
CBCharacteristic * controlChar;

NSMutableData * queuedForTransmit;
NSMutableData * currentlyTransmitting;

WWDeviceTransmitState currentTransmitState = WWDevice_WaitingToTransmit;

- (id) init
{
    self = [super init];
    
    deviceValues = [[NSMutableDictionary alloc] init];
    
    queuedForTransmit = [[NSMutableData alloc] init];
    currentlyTransmitting = nil;
    
    return self;
}

- (id) initWithPeripheral:(CBPeripheral*) peripheral
{
    self = [self init];
    
    self.cbPeripheral = peripheral;
    self.cbPeripheral.delegate = self;
    
    return self;
}


- (void)disconnect {
    if (dataChar && [dataChar isNotifying]) {
        [self.cbPeripheral setNotifyValue:NO forCharacteristic:dataChar];
    }
}

- (NSUUID *)peripheralIdentifier {
    if (self.cbPeripheral) {
        return self.cbPeripheral.identifier;
    }
    else {
        return nil;
    }
}

- (NSObject *)lastData:(WWCommandId) dataId {
    return [deviceValues objectForKey:[NSValue valueWithWWCommandId:dataId]];
}

- (NSArray *)availableData {
    return nil;
}

- (NSDictionary*) getAllDeviceData {
    return deviceValues;
}

- (void)enableData:(NSArray *)dataIds {
    for (NSValue* dataId in dataIds) {
        WWCommandId enabledId = [dataId valueOfWWCommandId];
        [queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdEnable commandValue:enabledId]];
    }
}

- (void)disableData:(NSArray *)dataIds {
    for (NSValue* dataId in dataIds) {
        WWCommandId enabledId = [dataId valueOfWWCommandId];
        [queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdDisable commandValue:enabledId]];
    }
}

- (void)changeUpdatePeriod:(NSUInteger)period {
    [queuedForTransmit appendData:[WWProtocol encodeCommandPacket:WWCommandIdUpdateRate commandValue:period]];
}

- (void)sendCommand:(WWCommandId)commandId value:(NSNumber*) value {
    //[queuedForTransmit setObject:value forKey:[NSValue valueWithWWCommandId:commandId]];
    [queuedForTransmit appendData:[WWProtocol encodeCommandPacket:commandId value:value]];
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
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if ([service.UUID isEqual:[CBUUID UUIDWithString:QUINTIC_DEVICE_INFO_SERVICE]])  {
        for (CBCharacteristic *aChar in service.characteristics) {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:QUINTIC_MANUFACTURER_NAME_CHARACTERISTIC_UUID]]) {
                [self.cbPeripheral readValueForCharacteristic:aChar];
                NSLog(@"Found a device manufacturer name characteristic");
            }
            else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:QUINTIC_MODEL_NAME_CHARACTERISTIC_UUID]]) {
                [self.cbPeripheral readValueForCharacteristic:aChar];
                NSLog(@"Found a device model name characteristic");
            }
        }
    }
    else if ([service.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_SERVICE_UUID]]) {
        NSLog(@"Got chars for QPP.");
        for (CBCharacteristic *aChar in service.characteristics) {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_DATA_CHAR_UUID]]) {
                NSLog(@"Found a data update characteristic!");
                
                dataChar = aChar;
                [peripheral setNotifyValue:YES forCharacteristic:aChar];
            }
            else if ([aChar.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_CONTROL_CHAR_UUID]]) {
                NSLog(@"Found a control characteristic.");
                controlChar = aChar;
            }
        }
    }
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:QUINTIC_MANUFACTURER_NAME_CHARACTERISTIC_UUID]]) {
        [self getManufacturerName:characteristic];
    }
    else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:QUINTIC_MODEL_NAME_CHARACTERISTIC_UUID]]) {
        [self getModelName:characteristic];
    }
    else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:WEARWARE_DATA_CHAR_UUID]]) {
        [self handleDataCharUpdate:characteristic];
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", [error localizedDescription]);
    }
    else {
        NSLog(@"Current Notifying State: %d", characteristic.isNotifying);
    }
}

// Instance method to get the manufacturer name of the device
- (void) getManufacturerName:(CBCharacteristic *)characteristic
{
    NSString *manfName = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    _manufacturerName = manfName;
    
    NSLog(@"Manf: %@", manfName);
    return;
}

// Instance method to get the model name of the device
- (void) getModelName:(CBCharacteristic *)characteristic
{
    NSString *modelName = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    _modelName = modelName;
    
    NSLog(@"Model: %@", modelName);
    return;
}

- (void)handleDataCharUpdate:(CBCharacteristic *)characteristic
{
    // first, transmit any command updates before the device goes to sleep
    [self handleSendingCommandUpdate];
    
    NSData * data = [characteristic value];
    NSDictionary * results = [WWProtocol parseDataPacket:data];
    [deviceValues addEntriesFromDictionary:results];
    
    NSLog(@"New length of _deviceValues: %lu", [deviceValues count]);
    
    for (NSValue* key in results) {
        [self.delegate device:self onDataValueUpdate:[key valueOfWWCommandId] value:[results objectForKey:key]];
    }
}

// Handles sending a new device update
- (void)handleSendingCommandUpdate
{
    // 1. Do we have an outstanding transmissing which we're waiting to hear if it was succesful?
    // 2. Is there actually any data to transmit?
    
    if (currentTransmitState != WWDevice_WaitingToTransmit) {
        NSLog(@"handleSendingCommandUpdate: Cannot transmit command update when in state %ld", currentTransmitState);
        return;
    }
    
    if ([queuedForTransmit length] == 0) {
        return; // no data to transmit
    }
    
    // Okay, let's transmit some data (if we have a connection)
    if (!self.cbPeripheral || !controlChar) {
        return;
    }

    // TODO: Race condition?
    currentlyTransmitting = queuedForTransmit;
    queuedForTransmit = [[NSMutableData alloc] init];
    
    NSLog(@"handleSendingCommandUpdate: Transmitting: %@, length %lu", currentlyTransmitting, (unsigned long)[currentlyTransmitting length]);
    
    currentTransmitState = WWDevice_WaitingForReply;
    [self.cbPeripheral writeValue:currentlyTransmitting forCharacteristic:controlChar type:CBCharacteristicWriteWithResponse];
}

- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
error:(NSError *)error
{
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error localizedDescription]);
        
        // TODO: Attempt to re-transmit data
        currentTransmitState = WWDevice_WaitingToTransmit;
        currentlyTransmitting = nil;
    }
    else {
        currentTransmitState = WWDevice_WaitingToTransmit;
        currentlyTransmitting = nil; // free
    }
}

@end
