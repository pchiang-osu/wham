//
//  WWProtocol.m
//  BTLE2
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWProtocol.h"

@implementation NSValue (valueWithWWCommandId)

+(NSValue*) valueWithWWCommandId:(enum WWCommandId)commandId
{
    return [NSValue value: &commandId withObjCType: @encode(enum WWCommandId)];
}

-(WWCommandId) valueOfWWCommandId {
    WWCommandId retVal;
    [self getValue:&retVal];
    return retVal;
}

@end

@implementation WWProtocol

+ (NSString*)dataIdToName:(WWCommandId)dataId
{
    switch (dataId) {
        case WWCommandIdReserved:
            return @"Reserved (0)";
            break;
        case WWCommandIdHardwareModel:
            return @"Hardware Model";
            break;
        case WWCommandIdSoftwareVersion:
            return @"Software Version";
            break;
        case WWCommandIdBattery:
            return @"Battery";
            break;
        case WWCommandIdTemperature:
            return @"Temperature";
            break;
        case WWCommandIdAccelerometer:
            return @"Accelerometer";
            break;
        case WWCommandIdPedometer:
            return @"Pedometer";
        case WWCommandIdEnable:
            return @"Enable";
            break;
        case WWCommandIdDisable:
            return @"Disable";
            break;
        case WWCommandIdUpdateRate:
            return @"Update Rate";
            break;
        case WWCommandIdRequestData:
            return @"Request Data";
            break;
        case WWCommandIdPedometerDistance:
            return @"Pedometer Distance";
            break;
        case WWCommandIdEcgDatagram:
            return @"ECG";
            break;
        case WWCommandIdOTA:
            return @"OTA";
            break;
        
        default:
            return [NSString stringWithFormat:@"Unknown (%d)", dataId];
            break;
    }
}

+ (NSNumber*)parseBatteryData:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 1;
    return [[NSNumber alloc] initWithUnsignedChar:data[0]];
}

+ (NSNumber*)parseTemperatureData:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 1;
    return [[NSNumber alloc] initWithChar:data[0]];
}

+ (NSNumber*)parsePedometer:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 4;
    
    uint32_t total_steps = 0;
    total_steps = CFSwapInt32BigToHost(*(uint32_t*)data);
    
    return [[NSNumber alloc] initWithUnsignedInt:total_steps];
}

+ (NSNumber*)parsePedometerDistance:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 4;
    
    uint32_t total_steps = 0;
    total_steps = CFSwapInt32BigToHost(*(uint32_t*)data);
    
    return [[NSNumber alloc] initWithUnsignedInt:total_steps];
}

+ (NSArray*)parseAccelerometer:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 3;
    
    return [[NSArray alloc] initWithObjects:[NSNumber numberWithUnsignedChar:data[0]],
     [NSNumber numberWithUnsignedChar:data[1]],
     [NSNumber numberWithUnsignedChar:data[2]], nil];
}

+ (NSNumber*)parseUpdateRate:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 4;
    
    uint32_t update_rate = 0;
    update_rate = CFSwapInt32BigToHost(*(uint32_t*)data);
    
    return [[NSNumber alloc] initWithUnsignedInt:update_rate];
}

+ (NSNumber*)parseEcgData:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed
{
    *bytesConsumed = 18;
    return [[NSNumber alloc] initWithUnsignedInt:0];
}

+ (NSObject*)parseDataEntity:(const uint8_t*)data bytesConsumed:(uint8_t*)bytesConsumed decodedId:(WWCommandId*)decodedId
{
    uint8_t entity_id = data[0];
    const uint8_t * reading = &data[1];
    
    NSObject * decoded = nil;
    
    switch(entity_id) {
        case WWCommandIdBattery:
            *decodedId = WWCommandIdBattery;
            decoded = [self parseBatteryData:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdTemperature:
            *decodedId = WWCommandIdTemperature;
            decoded = [self parseTemperatureData:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdPedometer:
            *decodedId = WWCommandIdPedometer;
            decoded = [self parsePedometer:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdUpdateRate:
            *decodedId = WWCommandIdUpdateRate;
            decoded = [self parseUpdateRate:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdPedometerDistance:
            *decodedId = WWCommandIdPedometerDistance;
            decoded = [self parsePedometerDistance:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdAccelerometer:
            *decodedId = WWCommandIdAccelerometer;
            decoded = [self parseAccelerometer:reading bytesConsumed:bytesConsumed];
            break;
        case WWCommandIdEcgDatagram:
            *decodedId = WWCommandIdEcgDatagram;
            decoded = [self parseEcgData:reading bytesConsumed:bytesConsumed];
            break;
        default:
            *decodedId = WWCommandIdReserved;
            *bytesConsumed = 0;
            NSLog(@"parseDataEntity: Unknown data entity %u, skipped.", entity_id);
            break;
    }
    
    *bytesConsumed = (*bytesConsumed)+1; // +1 for entity id we consumed
    return decoded;
}

+ (NSDictionary*)parseDataPacket:(NSData*)record
{
    const uint8_t * data = [record bytes];
    uint8_t bytes_consumed;
    WWCommandId decoded_id;
    NSUInteger current_position = 0;
    
    NSMutableDictionary * results = [[NSMutableDictionary alloc] init];
    
    NSLog(@"Entire record: %@", record);
    while (current_position < [record length]) {
        bytes_consumed = 0;
        decoded_id = WWCommandIdReserved;
        NSObject * decoded = [self parseDataEntity:&data[current_position] bytesConsumed:&bytes_consumed decodedId:&decoded_id];
        if (decoded_id != WWCommandIdReserved) { // successful
            [results setObject:decoded forKey:[NSValue valueWithWWCommandId:decoded_id]];
        }
        
        current_position += bytes_consumed;
        
        NSLog(@"parseDataPacket: Parsed %lu/%lu bytes, data type %d using %d bytes", (unsigned long)current_position, (unsigned long)[record length], decoded_id, bytes_consumed);
    }
    
    return results;
}

+ (NSData*) encodeCommandPacket:(WWCommandId)command commandValue:(WWCommandId)commandValue {
    return [self encodeCommandPacket:command value:[NSNumber numberWithUnsignedInt:commandValue]];
}

+ (NSData*) encodeCommandPacket:(WWCommandId)command value:(NSNumber*)value
{
    unsigned char byteVal;
    uint32_t intVal;
    
    NSMutableData * returnData = [[NSMutableData alloc] initWithBytes:&command length:1];
    
    switch (command) {
        // Single byte cases:
        case WWCommandIdEnable:
        case WWCommandIdDisable:
        case WWCommandIdRequestData:
            byteVal = [ value unsignedCharValue];
            [returnData appendBytes:&byteVal length:sizeof(byteVal)];
            return returnData;
            
            break;
        // uint32_t cases:
        case WWCommandIdUpdateRate:
            intVal = [ value unsignedIntValue ];
            intVal = CFSwapInt32HostToBig(intVal);
            [returnData appendBytes:&intVal length:sizeof(intVal)];
            
            return returnData;
            break;
        case WWCommandIdOTA:
            NSLog(@"encodeCommandValue: WWCommandIdOTA unsupported");
            return nil;
            break;
        default:
            NSLog(@"encodeCommandValue: Unsupported command id %u", command);
            return nil;
    }
    
    return nil;
}

/*
+ (NSData*) createCommandPacket:(NSDictionary*)commands
{
    NSMutableData * data = [[NSMutableData alloc] init];
    
    for (NSValue* key in commands) {
        WWCommandId command = [key valueOfWWCommandId];
        NSData * commandData = [commands objectForKey:key];
        
        unsigned char commandId = (unsigned char)command;
        [data appendBytes:&commandId length:1];
        [data appendData:commandData];
    }
    
    return data;
}*/

@end
