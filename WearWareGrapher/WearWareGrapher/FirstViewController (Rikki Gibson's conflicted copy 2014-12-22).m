//
//  FirstViewController.m
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/17/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import "FirstViewController.h"
#import "WWDeviceManager.h"
#import "WWGrapher.h"

@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet WWGrapher *graphView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deviceManager = [WWDeviceManager new];
    self.deviceManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calibrationSliderValueChanged:(UISlider *)sender {
    [self.graphView calibrateGraphToNumber:sender.value];
}

- (void)manager:(WWDeviceManager *)manager onBluetoothStateChange:(CBCentralManagerState)state {
//    [self.deviceManager scanForDevices:nil];
}

- (void)manager:(WWDeviceManager *)manager onDeviceFound:(WWDevice *)device {
    self.device = device;
    self.device.delegate = self;
    [self.deviceManager connectToDevice:device];
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
- (void)manager:(WWDeviceManager *)manager onDeviceConnected:(WWDevice *)device {
    NSLog(@"WWAppDelegate: connected!");
    
    self.device = device;
    //connectedDevice.delegate = self; // Very important: Set WWDevice's delegate to this ViewController.
    //self.deviceStatusLabel.text = @"Device Status: Connected";
    
    // Request updates from the WearWare device every 1 second: (was 1, now must be 100 since R has changed)
    [device changeUpdatePeriod:1];
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [device enableData:[NSArray arrayWithObjects:
                        [NSValue valueWithWWCommandId:WWCommandIdADCSample],
                        nil]];
}

/**
 * This delegate function is called when a connected WWDevice sends an update
 * to a data field.
 * This function simply displays the newly received data into labels in the view.
 */
- (void) device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value {
    //NSLog(@"WWViewController: new data update %d - %@", dataId, value);
    if (dataId == WWCommandIdADCSample) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSNumber *number = [(NSArray *)value objectAtIndex:0];
            if (number.floatValue > 10) {
                number = [NSNumber numberWithFloat:number.floatValue / 4.0];
            }
            [self.graphView addPointToGraph:number.floatValue];
            [self.graphView graph];
        }
    }
}

- (IBAction)connectButtonPressed:(UIBarButtonItem *)sender {
    [self.deviceManager scanForDevices:nil];
}

- (void)onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    NSLog(@"Device disconnected");
    [self.deviceManager scanForDevices:nil];
}

@end
