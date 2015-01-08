//
//  WWDeviceSim.m
//  BTLE2
//
//  Created by Taj Morton on 8/13/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWDeviceSim.h"

@implementation WWDeviceSim
{
    NSInteger currentStepValue;
    NSUUID * deviceUUID;
    NSArray * availData;
    NSTimer * simTimer;
}

const int maxStepsPerUpdate = 30;
const float updatePeriod = 10.0f; // 10 seconds

- (id) initWithInitialValue:(NSInteger)initialValue
{
    self = [super init];
    currentStepValue = initialValue;
    
    uuid_t uuid_bytes;
    
    memset(&uuid_bytes, 0, sizeof(uuid_bytes));
    uuid_bytes[0] = (initialValue & 0xFF);
    uuid_bytes[1] = ((initialValue >> 8) & 0xFF);
    
    deviceUUID = [[NSUUID alloc] initWithUUIDBytes:uuid_bytes];
    
    WWCommandId dataType = WWCommandIdPedometer;
    NSValue * dataTypeVal = [NSValue value:&dataType withObjCType:@encode(WWCommandId)];
    availData = @[dataTypeVal];
    
    
    
    return self;
}

- (void)setConnected:(BOOL)val {
    _connected = val;
}

- (void)setModelName:(NSString *)modelName {
    _modelName = modelName;
}

- (void)setModelNumber:(NSNumber *)modelNumber {
    _modelNumber = modelNumber;
}

- (void)setRSSI:(NSNumber *)RSSI {
    _RSSI = RSSI;
}

- (NSUUID *)peripheralIdentifier {
    return deviceUUID;
}

- (NSObject *)lastData:(WWCommandId) dataId {
    return [[ NSNumber alloc] initWithInt:currentStepValue];
}

- (NSArray *)availableData {
    return availData;
}

- (void)enableData:(NSArray *)dataIds {
    
}

- (void)disableData:(NSArray *)dataIds {
    
}

- (void)doSimDataUpdate {
    currentStepValue += arc4random() % maxStepsPerUpdate;
    [[self delegate] device:self onDataValueUpdate:WWCommandIdPedometer value:[self lastData:WWCommandIdPedometer]];
}


- (void) startSimulation {
    simTimer = [NSTimer scheduledTimerWithTimeInterval:updatePeriod
                                                target:self
                                                selector:@selector(doSimDataUpdate)
                                                userInfo:nil
                                                repeats:TRUE];
}

- (void) stopSimulation {
    if (simTimer != nil) {
        [simTimer invalidate];
        simTimer = nil;
    }
}

@end
