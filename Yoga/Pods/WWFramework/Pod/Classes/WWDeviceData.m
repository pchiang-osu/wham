//
//  WWDeviceData.m
//  WWFramework
//
//  Created by Rutger Farry on 4/2/15.
//
//

#import "WWDeviceData.h"
#import "WWDevice.h"

@implementation WWDeviceData

+ (instancetype)deviceDataWithData:(id)data sender:(WWDevice *)sender andDataId:(WWCommandId)dataId
{
    return [[self alloc] initWithData:data sender:sender andDataId:dataId];
}

- (instancetype)initWithData:(id)data sender:(WWDevice *)sender andDataId:(WWCommandId)dataId{
    if (self = [super init]) {
        _data = data;
        _sender = sender;
        _senderUUID = sender.peripheralIdentifier;
        self.dataId = dataId;
    }
    return self;
}


- (NSString *)dataIdString {
    return [WWProtocol dataIdToName:self.dataId];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"WWDeviceData: (%@, \ndataType: %@, \nsenderUUID: %@ \n)",
            self.data,
            self.dataIdString,
            self.senderUUID.UUIDString];
}

@end
