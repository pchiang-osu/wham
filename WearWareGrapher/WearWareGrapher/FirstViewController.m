//
//  FirstViewController.m
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/17/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import <WearWareFrameworkiOS/WearWareFrameworkiOS.h>
#import "WWGrapher.h"
#import "FirstViewController.h"

#define ADC_DATA_SELECTOR @"ADCData"

@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet WWGrapher *graphView;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;
@property (strong, nonatomic) WWHeartRateDetector *heartRateDetector;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.heartRateDetector = [[WWHeartRateDetector alloc] initWithDelegate:self];
    self.heartRateDetector.delegate = self;
    
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self
                                                          forKeyPath:ADC_DATA_SELECTOR
                                                             options:0
                                                             context:NULL];
    
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self.heartRateDetector
                                                          forKeyPath:ADC_DATA_SELECTOR
                                                             options:0
                                                             context:NULL];
    
    //[[WWCentralDeviceManager sharedCentralDeviceManager] requestData:WWCommandIdADCSample andUpdatePeriod:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[WWCentralDeviceManager sharedCentralDeviceManager] requestData:WWCommandIdADCSample andUpdatePeriod:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //[[WWCentralDeviceManager sharedCentralDeviceManager] disableAllData];
}

- (IBAction)calibrationSliderValueChanged:(UISlider *)sender {
    [self.graphView calibrateGraphToNumber:sender.value];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:ADC_DATA_SELECTOR]) {
        NSLog(@"Value: %@", [WWCentralDeviceManager sharedCentralDeviceManager].ADCData);
        NSNumber *number = [WWCentralDeviceManager sharedCentralDeviceManager].ADCData;
//        [self.heartRateDetector device:nil onDataValueUpdate:WWCommandIdADCSample value:@[number]];
        if (number.floatValue > 10) {
            number = [NSNumber numberWithFloat:number.floatValue / 4.0];
        }
        [self.graphView addPointToGraph:number.floatValue];
        [self.graphView graph];
    }
}

- (void)didDetectHeartbeat:(WWHeartRateDetector *)detector atTime:(NSDate *)time {
    self.bpmLabel.text = [NSString stringWithFormat:@"BPM: %0.0f", self.heartRateDetector.beatsPerMinute];
}

- (void)detector:(WWHeartRateDetector *)detector didReachEndOfData:(NSArray *)data {
    
}

- (IBAction)connectButtonPressed:(UIBarButtonItem *)sender {
    NSArray *data = [HeartRateSampleGetter getSample:@"Heart_Rate"];
    
    WWECGDeviceSim *deviceSim = [[WWECGDeviceSim alloc] initWithData:data
                                delegate:[WWCentralDeviceManager sharedCentralDeviceManager]
                           callbackDelay:.01];
    [deviceSim start];
    
//    [[WWCentralDeviceManager sharedCentralDeviceManager] connect];
}

@end
