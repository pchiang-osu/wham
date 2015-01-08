//
//  WWAppDelegate.m
//  ECGTest
//
//  Created by VLSI Lab on 10/11/14.
//  Copyright (c) 2014 Taj Morton. All rights reserved.
//


#import "WWAppDelegate.h"

@interface ECGLogEntry : NSObject
- (id) initWithData:(NSArray*)dat time:(NSDate*)time;
- (id) initWithData:(NSArray*)data;
@end

@implementation ECGLogEntry : NSObject 
    NSDate * timestamp;
    NSArray * data;

- (id) initWithData:(NSArray*)dat time:(NSDate*)time {
    self = [super init];
    
    if (self) {
        timestamp = time;
        data = dat;
    }
    
    return self;
}

- (id) initWithData:(NSArray*)data {
    return [self initWithData:data time:[NSDate date]];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%.4f,%@", [timestamp timeIntervalSince1970], [data componentsJoinedByString:@","]];
}
@end

@implementation WWAppDelegate

bool isLogging = NO;
NSMutableArray * loggedData;

NSDateFormatter * debugTimeStamper;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //[self setupTextView];
    
    debugTimeStamper = [[NSDateFormatter alloc] init];
    [debugTimeStamper setDateFormat:@"HH:mm:ss"];
    
    loggedData = [[NSMutableArray alloc] init];
    
    WWDeviceManager * centralManager = [[WWDeviceManager alloc] init];
    //[centralManager scanForPeripheralsWithServices:nil options:nil];
    self.centralManager = centralManager;
    self.centralManager.delegate = self;
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    if (self.device) {
        [self.centralManager disconnectDevice:self.device];
    }
}
/*
- (void)printInfoString:(NSString*)str
{
    NSString * dateString = [debugTimeStamper stringFromDate:[NSDate date] ];
    

    [self.textView setString:[NSString stringWithFormat:@"%@: %@\n%@", dateString, str, self.textView.string]];
}*/

- (void) device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value {
    //NSLog(@"WWAppDelegate: new data update %d - %@", dataId, value);
    //[self printInfoString:[NSString stringWithFormat:@"New data (type 0x%x): %@", dataId, value]];
    
    //[self updateDataDisplay];
    
    if (dataId == WWCommandIdADCSample) {
        if (isLogging) {
            ECGLogEntry * log = [[ECGLogEntry alloc] initWithData:(NSArray*)value];
            [loggedData addObject:log];
            
            [self.logField setStringValue:[NSString stringWithFormat:@"%@\n%@", log, self.logField.stringValue]];
        }
    }
    
    [self.lastUpdateField setStringValue:[debugTimeStamper stringFromDate:[NSDate date]]];
}

- (void) onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    NSString * errorMessage;
    if (error) {
        errorMessage = [error localizedDescription];
    }
    else {
        errorMessage = [NSString stringWithFormat:@"No error."];
    }
    
    [self.statusField setStringValue:@"Disconnected"];
}

- (void) manager:(WWDeviceManager *)manager onBluetoothStateChange: (CBCentralManagerState)state {
    if (state == CBCentralManagerStatePoweredOn) {
        [self.scanConnectButton setEnabled:TRUE];
    }
}

- (void) manager:(WWDeviceManager *)manager onDeviceFound: (WWDevice *)device {
    self.device = device;
    self.device.delegate = self;
    
    NSLog(@"Found device - %@", device);
    [manager connectToDevice:device];
}


- (void) manager:(WWDeviceManager *)manager onDeviceConnected: (WWDevice *)device {
    NSLog(@"WWAppDelegate: connected!");
    [self.statusField setStringValue:@"Connected"];
    
    // set default rate in text field
    [self updateRateClicked:self];
}


- (IBAction)scanConnectClicked:(id)sender {
    [self.centralManager scanForDevices:nil];
}

- (IBAction)updateRateClicked:(id)sender {
    if (self.device) {
        if (self.updateRateField.integerValue > 0) {
            [self.device changeUpdatePeriod:self.updateRateField.integerValue];
        }
    }
}

- (IBAction)startLoggingClicked:(id)sender {
    isLogging = YES;
}

- (IBAction)stopLoggingClicked:(id)sender {
    isLogging = NO;
}

- (IBAction)clearLogClicked:(id)sender {
    [loggedData removeAllObjects];
    [self.logField setStringValue:@""];
}

- (IBAction)saveLogClicked:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:@[@"csv"]];

    [savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            [savePanel orderOut:self];
            
            NSString * data = self.logField.stringValue;
            NSError * error;
            BOOL ok = [data writeToURL:[savePanel URL] atomically:NO encoding:NSStringEncodingConversionAllowLossy error:&error];
            
            if (!ok) {
                NSLog(@"Error saving file: %@", [error localizedFailureReason]);
            }
        }
    }];
}


@end
