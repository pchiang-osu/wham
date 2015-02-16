//
//  HomeViewController.m
//  wham.Run
//
//  Created by Rutger Farry on 2/2/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "HomeViewController.h"
#import <WearWareFrameworkiOS/WearWareFrameworkiOS.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [WWCentralDeviceManager sharedCentralDeviceManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startActivityButtonPressed:(UIButton *)sender {
    [[WWCentralDeviceManager sharedCentralDeviceManager] connect];
}


@end
