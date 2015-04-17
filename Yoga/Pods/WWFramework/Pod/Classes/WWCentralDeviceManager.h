//
//  WWCentralDeviceManager.h
//  WWFramework
//
//  Created by Rutger Farry on 12/19/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

@import Foundation;

#import "WWDevice.h"
#import "WWDeviceData.h"
#import "WWDeviceDelegate.h"
#import "WWDeviceManager.h"

extern NSString * const WWDeviceDidConnect;
extern NSString * const WWDeviceDidDisconnect;
extern NSString * const WWDeviceDidUpdate;

@interface NSNotificationCenter (WWExtensions)

- (id<NSObject>)addObserverForWWDeviceUpdates:(NSArray *)updates usingBlock:(void (^)(NSNotification * notification))block;

@end


@interface WWCentralDeviceManager : NSObject

#pragma mark - Properties

@property (weak, nonatomic) id delegate;

// The array of WWDevices maintained by the CentralDeviceManager

@property (nonatomic) NSMutableArray * devices;



#pragma mark - Methods

/**
 * Returns the shared central device manager or initializes a new one if it doesn't exist
 */

+ (instancetype)sharedCentralDeviceManager;

/**
 * Connects the central manager to the nearest WWDevice
 */

- (void)connect;

@end
