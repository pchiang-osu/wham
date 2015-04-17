//
//  WWProtocol.h
//  WWFramework
//
//  Created by Taj Morton on 8/10/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

@import Foundation;

/**
 * Device and command IDs of the WearWare protocol.
 */
typedef NS_ENUM(unsigned char, WWCommandId) {
    WWCommandIdReserved = 0x00,
    WWCommandIdHardwareModel = 0x01,
    WWCommandIdSoftwareVersion = 0x02,
    WWCommandIdBattery = 0x03,
    WWCommandIdTemperature = 0x04,
    WWCommandIdAccelerometer = 0x05,
    WWCommandIdPedometer = 0x06,
    WWCommandIdEnable = 0x07,
    WWCommandIdDisable = 0x08,
    WWCommandIdUpdateRate = 0x09,
    WWCommandIdRequestData = 0x0A,
    WWCommandIdOTA = 0x0B,
    WWCommandIdPedometerDistance = 0x0C,
    WWCommandIdADCSample = 0x0D
};

@interface NSValue (valueWithWWCommandId)

+ (NSValue *)valueWithWWCommandId:(enum WWCommandId)commandId;
- (WWCommandId)valueOfWWCommandId;

@end

#define WEARWARE_SERVICE_LOCAL_NAME @"Quintic BLE"

#define WEARWARE_SERVICE_UUID @"0000FEE9-0000-1000-8000-00805F9B34FB"
#define WEARWARE_CONTROL_CHAR_UUID @"D44BC439-ABFD-45A2-B575-925416129600"
#define WEARWARE_METADATA_CHAR_UUID @"D44BC439-ABFD-45A2-B575-925416129601"
#define WEARWARE_DATA_CHAR_UUID @"D44BC439-ABFD-45A2-B575-925416129602"

#define WEARWARE_ECG_DATAGRAM_LENGTH 1

@interface WWProtocol : NSObject

+ (NSString *)dataIdToName:(WWCommandId)dataId;
+ (NSDictionary *)parseDataPacket:(NSData*)data;

+ (NSData *)encodeCommandPacket:(WWCommandId)command value:(NSNumber*)value;
+ (NSData *)encodeCommandPacket:(WWCommandId)command commandValue:(WWCommandId)commandValue;
@end
