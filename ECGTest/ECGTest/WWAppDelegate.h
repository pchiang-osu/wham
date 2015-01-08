//
//  WWAppDelegate.h
//  ECGTest
//
//  Created by VLSI Lab on 10/11/14.
//  Copyright (c) 2014 Taj Morton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WearWareFrameworkOSX/WearWareFrameworkOSX.h>

@interface WWAppDelegate : NSObject <NSApplicationDelegate, WWDeviceDelegate, WWDeviceManagerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *statusField;
@property (weak) IBOutlet NSTextField *lastUpdateField;
@property (weak) IBOutlet NSTextField *updateRateField;
@property (weak) IBOutlet NSTextField *logField;
@property (weak) IBOutlet NSButton *startLoggingButton;
@property (weak) IBOutlet NSButton *stopLoggingButton;
@property (weak) IBOutlet NSButton *scanConnectButton;



@property (nonatomic, strong) WWDeviceManager *centralManager;
@property (nonatomic, strong) WWDevice *device;

@end
