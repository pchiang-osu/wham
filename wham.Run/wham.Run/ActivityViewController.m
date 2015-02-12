//
//  ActivityViewController.m
//  wham.Run
//
//  Created by Rutger Farry on 2/3/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "ActivityViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>
#import <CoreMotion/CoreMotion.h>

#define wMapID @"rutgerfarry.kpo3d7oo"

@interface ActivityViewController () <CLLocationManagerDelegate, RMMapViewDelegate>

@property (strong, nonatomic) IBOutlet RMMapView *mapView;
@property (strong, nonatomic) CMPedometer *pedometer;

@property (strong, nonatomic) IBOutlet UILabel *mainLabel;
@property (strong, nonatomic) IBOutlet UILabel *mainLabelTitle;

// Array of CLLocations of where the user has been
@property (strong, nonatomic) NSMutableArray *locations;

// Map layer showing the user's path
@property (strong, nonatomic) RMAnnotation *path;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.title = @"wham";
    
    self.locations = [NSMutableArray new];
    [self setupPedometer];
    [self setupMap];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setupMap];
}



#pragma mark - RMMapViewDelegate

- (void)mapView:(RMMapView *)mapView
didUpdateUserLocation:(RMUserLocation *)userLocation
{
    NSMutableArray *locations = self.locations;
    RMAnnotation *path = self.path;
    
    [locations addObject:userLocation.location];
    
    // Setup path if one doesn't exist
    if (!path) {
        path = [RMAnnotation annotationWithMapView:self.mapView
                                        coordinate:userLocation.coordinate
                                          andTitle:@"Running Path"];
        [mapView addAnnotation:path];
    }
    
    if (locations.count > 1) {
        path.userInfo = locations;
        [path setBoundingBoxFromLocations:locations];
        NSLog(@"Annotations: %@", self.mapView.annotations);
    }
}


/**
 * Returns an RMMaplayer containing a RMShape polyline of the user's running path
 * Currently redraws the full path everytime it is called. This might need to be 
 * optimized in the future for long paths.
 */
- (RMMapLayer *)mapView:(RMMapView *)mapView
     layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation)
        return nil;
    
    RMShape *polyline = [[RMShape alloc] initWithView:self.mapView];
    polyline.lineColor = [UIColor colorWithHue:344.0 / 360.0 saturation:92.0 / 100.0 brightness:100.0 / 100.0 alpha:1.0];
    polyline.lineWidth = 5.0;
    
    for (CLLocation *location in self.locations) {
        [polyline addLineToCoordinate:location.coordinate];
    }
    
    return polyline;
}



#pragma mark - Setup

- (void)setupMap
{
    RMMapView *mapView = self.mapView;
    [RMConfiguration sharedInstance].accessToken = @"pk.eyJ1IjoicnV0Z2VyZmFycnkiLCJhIjoic3duRWdCRSJ9.18LzIGX1vQO-GTjgUYQt7A";
    mapView.tileSource = [[RMMapboxSource alloc] initWithMapID:wMapID];
    mapView.userTrackingMode = RMUserTrackingModeFollow;
    mapView.zoom = 15.0;
    mapView.delegate = self;
}

- (void)setupPedometer
{
    self.pedometer = [CMPedometer new];
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date]
                                      withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                          NSString *distanceString = [self formattedDistanceStringFromMeters:pedometerData.distance];
                                          //NSString *paceString = [self formattedPaceStringFrom];
                                          
                                          // Update the label on the main thread
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              self.mainLabel.text = distanceString;
                                          });
                                      }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark - Label Formatters

- (NSString *)formattedDistanceStringFromMeters:(NSNumber *)meters
{
    NSNumber *mileDistance = [NSNumber numberWithDouble:meters.doubleValue * 0.000621371];
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.maximumFractionDigits = 2;
    numberFormatter.minimumIntegerDigits = 1;
    NSString *distanceString = [numberFormatter stringFromNumber:mileDistance];
    
    return distanceString;
}
     
 - (NSString *)formattedPaceStringFrom {
     return nil;
 }


@end