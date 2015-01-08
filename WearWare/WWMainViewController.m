//
//  WWMainViewController.m
//  WearWare
//
//  Created by Rutger Farry on 12/14/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "WWMainViewController.h"
#import "RVFGradientView.h"
#import "RVFCircularProgressIndicator.h"
#import "WWDeviceManager.h"

@interface WWMainViewController ()

@property (strong, nonatomic) IBOutlet RVFGradientView *gradientView;
@property (strong, nonatomic) IBOutlet RVFCircularProgressIndicator *progressIndicator;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;

@end

@implementation WWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.superclass class];
    
    self.progressIndicator.progressDegrees = 270;
    self.progressIndicator.lineThickness = 1.0;
    
    self.deviceManager = [WWDeviceManager new];
    self.deviceManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pulse:(UIButton *)sender {
    [self.gradientView pulse];
}

- (IBAction)setDegrees:(UISlider *)sender {
    NSNumber *progressNumber = [NSNumber numberWithFloat:sender.value];
    
    self.progressIndicator.progressDegrees = sender.value;
    self.stepsLabel.text = [NSString stringWithFormat:@"%d%%", progressNumber.intValue];
}



#pragma mark - Device Management

- (void)manager:(WWDeviceManager *)manager
onBluetoothStateChange:(CBCentralManagerState)state {
    [self.deviceManager scanForDevices:nil];
}

- (void)manager:(WWDeviceManager *)manager
  onDeviceFound:(WWDevice *)device {
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
- (void)manager:(WWDeviceManager *)manager
onDeviceConnected:(WWDevice *)device {
    NSLog(@"WWAppDelegate: connected!");
    
    self.device = device;
    
    // Request updates from the WearWare device every 1 second: (was 1, now must be 100 since R has changed)
    [device changeUpdatePeriod:1];
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [device enableData:[NSArray arrayWithObjects:
                        [NSValue valueWithWWCommandId:WWCommandIdADCSample],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometer],
                        nil]];
    
}

- (void)device:(WWDevice *)device onDataValueUpdate:(WWCommandId)dataId value:(NSObject *)value {
    NSNumber *number = [(NSArray *)value objectAtIndex:0];
    // Prevents -inf
    if (number.floatValue > 10)
        number = [NSNumber numberWithFloat:number.floatValue / 4.0];
}

- (void)onDeviceDisconnected:(WWDevice *)device error:(NSError *)error
{
    NSLog(@"Device disconnected");
    [self.deviceManager scanForDevices:nil];
}

@end
