//
//  WWViewController.m
//  WearWareiOSTest
//
//  Created by Taj Morton on 9/5/14.
//  Copyright (c) 2014 WearWare. All rights reserved.
//

#import "WWViewController.h"

@interface WWViewController ()

@end

@implementation WWViewController

/* The WWDeviceManager is used to interface with the iOS Bluetooth interface,
 * and is used to scan for and discover WearWare BLE devices within range.
 * Only a single WWDeviceManager needs to be created within an app.
 * This variable is initialized in the viewDidLoad() function.
 */
WWDeviceManager * deviceManager;

/*
 * The WWDevice class is used to communicate with a WearWare BLE device.
 * A single WWDevice instance is used to communicate with one WearWare BLE device.
 * If multiple simultanious connections (to multiple devices) are needed, a WWDevice
 * instance for each one should be maintained.
 * This variable is set after a connection is established with a device.
 */
WWDevice * connectedDevice;

NSDateFormatter * updateTimeStamper;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create a NSDateFormatter to print time of last packet received:
    updateTimeStamper = [[NSDateFormatter alloc] init];
    [updateTimeStamper setDateFormat:@"HH:mm:ss"];
    
    // Create a WWDeviceManager object and set this view controller
    // as the delegate. The WWDeviceManager's delegate is called when
    // new devices are discovered or connected to.
    deviceManager = [[WWDeviceManager alloc] init];
    deviceManager.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * This delegate function is called when the iOS Bluetooth Hardware changes state.
 * See CBCentralManagerState for a full list of possible states. The hardware
 * should be in CBCentralManagerStatePoweredOn before scanning is started, otherwise
 * it will fail.
 *
 * This function simply enables the "Scan For Devices" button, but it could be used to
 * start scanning automatically.
 */
- (void) manager:(WWDeviceManager *)manager onBluetoothStateChange: (CBCentralManagerState)state {
    if (state == CBCentralManagerStatePoweredOn) {
        self.scanForDevicesButton.enabled = YES;
    }
}

/*
 * This delegate function is called when a new WearWare device is found during scanning.
 * At this point, the WearWare and iOS devices have NOT performed the "connection"
 * step of the process, so no information is being exchanged. This would be
 * a good place to decide if the app wants to connect to the WearWare device or not. To
 * determine if a WearWare device has been connected to previously, check the
 * device.peripheralIdentifier field. This is a unique UUID associated with single WearWare
 * device (like a MAC address).
 *
 * As is, this function begins the connection process automatically. When the connection is
 * established, the onDeviceConnected() function (below) is called. A real application would
 * probably want to show a list of devices to the user or decide to connect automatically
 * based off of the peripheralIdentifier property.
 */
- (void) manager:(WWDeviceManager *)manager onDeviceFound: (WWDevice *)device {
    self.deviceStatusLabel.text = @"Device Status: Device Found";
    
    // Automatically connect to this device:
    [manager connectToDevice:device];
}

/*
 * This delegate function is called when the connection process between the iOS device and
 * WearWare device has been completed. After this function is called, the delegate will automatically
 * begin receiving updates from the WearWare device as it sends out new updates.
 *
 * As it stands, this function sets the WWDevice's delegate to the ViewController and
 * requests that the WearWare device include battery voltage, temperature, and pedometer (total steps)
 * in its periodic updates. When an update is received, the onDataValueUpdate() function (below) is called.
 */
- (void) manager:(WWDeviceManager *)manager onDeviceConnected: (WWDevice *)device {
    NSLog(@"WWAppDelegate: connected!");
    
    connectedDevice = device;
    connectedDevice.delegate = self; // Very important: Set WWDevice's delegate to this ViewController.
    self.deviceStatusLabel.text = @"Device Status: Connected";
    
    // Request updates from the WearWare device every 1 second:
    [device changeUpdatePeriod:1];
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [device enableData:[NSArray arrayWithObjects:[NSValue valueWithWWCommandId:WWCommandIdTemperature],
                        [NSValue valueWithWWCommandId:WWCommandIdBattery],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometer],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometerDistance],
                        [NSValue valueWithWWCommandId:WWCommandIdAccelerometer],
                        nil]];
}

/*
 * This delegate function is called when iOS detects that the WearWare BLE device
 * has become disconnected from the iOS device.
 * Sometimes it seems that the connection is re-established automatically when
 * we move back in range. However, this could be an opportunity to restart
 * scanning for new devices.
 */
- (void) onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    NSString * errorMessage;
    if (error) {
        errorMessage = [error localizedDescription];
    }
    else {
        errorMessage = [NSString stringWithFormat:@"No error."];
    }
    
    self.deviceStatusLabel.text = @"Device Status: Disconnected";
}

/**
 * This delegate function is called when a connected WWDevice sends an update
 * to a data field.
 * This function simply displays the newly received data into labels in the view.
 */
- (void) device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value {
    NSLog(@"WWViewController: new data update %d - %@", dataId, value);
    
    NSString * dateString = [updateTimeStamper stringFromDate:[NSDate date] ];
    self.lastUpdateTimestampLabel.text = [NSString stringWithFormat:@"Last Device Update: %@", dateString];
    
    switch (dataId) {
        case WWCommandIdBattery: // Received an update to the device's battery level
            self.batteryLevelLabel.text = [(NSNumber*)value stringValue];
            break;
        case WWCommandIdTemperature: // Received an update to the device's temperature (Units???)
            self.temperatureLabel.text = [(NSNumber*)value stringValue];
            break;
        case WWCommandIdPedometer: // Received an updated total number of steps walked
            self.totalStepsLabel.text = [(NSNumber*)value stringValue];
            break;
        case WWCommandIdPedometerDistance: // Received an update total distance walked
            self.distanceLabel.text = [(NSNumber*)value stringValue];
            break;
        case WWCommandIdAccelerometer:
            self.accelLabel.text = [self accelDataToString:(NSArray*)value];
            break;
        default:
            // Unknown data, ignore
            break;
    }
}

/*
 * This function is called when the "Scan For Devices" button is clicked. This
 * begins scanning for WearWare devices. When a device is found, the onDeviceFound()
 * delegate function is called.
 */
- (IBAction)onScanForDevicesClick:(id)sender {
    self.deviceStatusLabel.text = @"Device Status: Scanning";
    
    [deviceManager scanForDevices:nil]; // Begin scanning, onDeviceFound() is called when a device is discovered
}

- (NSString*)accelDataToString:(NSArray*)accelerometerData {
    NSString * accelString = [NSString stringWithFormat:@"X=%@, Y=%@, Z=%@",
                                      [accelerometerData objectAtIndex:0],
                                      [accelerometerData objectAtIndex:1],
                                      [accelerometerData objectAtIndex:2]];
    return accelString;
}


@end
