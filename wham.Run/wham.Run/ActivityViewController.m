//
//  ActivityViewController.m
//  wham.Run
//
//  Created by Rutger Farry on 2/3/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "ActivityViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>

#define wMapID @"rutgerfarry.kpo3d7oo"

@interface ActivityViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet RMMapView *mapView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.title = @"wham";
    [self setupMap];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setupMap];
}

#pragma mark - Setup

- (void)setupMap
{
    [RMConfiguration sharedInstance].accessToken = @"pk.eyJ1IjoicnV0Z2VyZmFycnkiLCJhIjoic3duRWdCRSJ9.18LzIGX1vQO-GTjgUYQt7A";
    self.mapView.tileSource = [[RMMapboxSource alloc] initWithMapID:wMapID];
    self.mapView.userTrackingMode = RMUserTrackingModeFollow;
    self.mapView.zoom = 15.0;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
