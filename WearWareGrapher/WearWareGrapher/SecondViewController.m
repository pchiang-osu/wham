//
//  SecondViewController.m
//  WearWareGrapher
//
//  Created by Rutger Farry on 12/17/14.
//  Copyright (c) 2014 Wear Ware. All rights reserved.
//

#import <WearWareFrameworkiOS/WearWareFrameworkiOS.h>
#import "SecondViewController.h"

#define PEDOMETER_DATA_SELECTOR @"pedometerData"

@interface SecondViewController ()

@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self
                                                          forKeyPath:PEDOMETER_DATA_SELECTOR
                                                             options:0
                                                             context:NULL];
    //[[WWCentralDeviceManager sharedCentralDeviceManager] requestData:WWCommandIdPedometer andUpdatePeriod:4000];
    NSLog(@"Loaded SecondViewController");
}

- (void)viewDidAppear:(BOOL)animated
{
    [[WWCentralDeviceManager sharedCentralDeviceManager] requestData:WWCommandIdPedometer andUpdatePeriod:4000];
}


- (void)viewWillDisappear:(BOOL)animated
{
    //[[WWCentralDeviceManager sharedCentralDeviceManager] disableAllData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:PEDOMETER_DATA_SELECTOR]) {
        self.stepsLabel.text = [[WWCentralDeviceManager sharedCentralDeviceManager].pedometerData stringValue];
    }
}

- (IBAction)connectButtonPressed:(UIBarButtonItem *)sender {
    [[WWCentralDeviceManager sharedCentralDeviceManager] connect];
}

@end
