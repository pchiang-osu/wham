//
//  WWDeviceData.h
//  WWFramework
//
//  Created by Rutger Farry on 4/2/15.
//
//

@import Foundation;

@class WWDevice;

#import "WWProtocol.h"

@interface WWDeviceData : NSObject

@property (nonatomic, readonly) id              data;
@property (nonatomic, readonly) WWDevice      * sender;
@property (nonatomic, readonly) NSUUID        * senderUUID;
@property (nonatomic) WWCommandId               dataId;
@property (nonatomic, readonly) NSString      * dataIdString;

+ (instancetype)deviceDataWithData:(id)data sender:(WWDevice *)sender andDataId:(WWCommandId)dataId;

@end
