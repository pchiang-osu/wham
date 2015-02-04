//
//  ActivityViewController.m
//  wham.Run
//
//  Created by Rutger Farry on 2/3/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "ActivityViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>
#import <CoreLocation/CoreLocation.h>

@interface ActivityViewController () <CLLocationManagerDelegate>

@property (nonatomic) RMMapboxSource *mapboxSource;
@property (nonatomic) RMMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Tabbar depth: %@", [self.view subviews]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Setup

- (void)startLocationUpdates
{
    CLLocationManager *locationManager = self.locationManager;
    
    // Authorization checks
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        [locationManager requestAlwaysAuthorization];
    
    // Alert user if they disabled location services
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Services Disabled"
                                                                                 message:@"Location Services are necessary for recording your workout. Please enable permission for wham.Run in Settings > Privacy > Location Services" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Okay"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:^{
            [self performSegueWithIdentifier:@"HomeViewController" sender:self];
        }];
    }
    
    // Enable appropriately accurate location services
    if (!locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    locationManager.distanceFilter = 20.0;
}

- (void)setupMap
{
    [RMConfiguration sharedInstance].accessToken = @"pk.eyJ1IjoicnV0Z2VyZmFycnkiLCJhIjoic3duRWdCRSJ9.18LzIGX1vQO-GTjgUYQt7A";
    self.mapboxSource = [[RMMapboxSource alloc] initWithMapID:@"rutgerfarry.kpo3d7oo"];
    self.mapView = [[RMMapView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                      andTilesource:self.mapboxSource];
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(44.565, -123.282);
    [self.mapView setZoom:15.0 atCoordinate:coordinate animated:YES];
}

@end
