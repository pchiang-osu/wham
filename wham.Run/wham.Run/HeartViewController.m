//
//  HeartViewController.m
//  
//
//  Created by Rutger Farry on 2/12/15.
//
//

#import "HeartViewController.h"
#import "WWGrapherView.h"

#define ADC_DATA_SELECTOR @"ADCData"

@interface HeartViewController ()

@property (strong, nonatomic) IBOutlet WWGrapherView *graphView;
@property (strong, nonatomic) WWHeartRateDetector *heartRateDetector;

@end

@implementation HeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup HR detector
    self.heartRateDetector = [[WWHeartRateDetector alloc] initWithDelegate:self];
    
    // Register for KVO
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self
                                                          forKeyPath:ADC_DATA_SELECTOR
                                                             options:0
                                                             context:NULL];
    
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self.heartRateDetector
                                                          forKeyPath:ADC_DATA_SELECTOR
                                                             options:0
                                                             context:NULL];
    
    
    // Calibrate graph view. Eventually this will be done automatically by WWGrapher
    self.graphView.calibrationScalar = 2.25;
    self.graphView.calibrationOffset = 0.0;
    self.graphView.strokeColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[WWCentralDeviceManager sharedCentralDeviceManager]
     requestData:WWCommandIdADCSample andUpdatePeriod:1];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:ADC_DATA_SELECTOR]) {
        NSNumber *number = [WWCentralDeviceManager sharedCentralDeviceManager].ADCData;
        //        [self.heartRateDetector device:nil onDataValueUpdate:WWCommandIdADCSample value:@[number]];
        if (number.floatValue > 10) {
            number = [NSNumber numberWithFloat:number.floatValue / 4.0];
        }
        [self.graphView addPointToGraph:number.floatValue];
        [self.graphView graph];
    }
}

- (IBAction)connectButtonPressed:(UIBarButtonItem *)sender
{
//    NSArray *data = [HeartRateSampleGetter getSample:@"Heart_Rate"];
//    
//    WWECGDeviceSim *deviceSim = [[WWECGDeviceSim alloc] initWithData:data
//                                                            delegate:[WWCentralDeviceManager sharedCentralDeviceManager]
//                                                       callbackDelay:.01];
//    [deviceSim start];
    
    [[WWCentralDeviceManager sharedCentralDeviceManager] connect];
}



#pragma mark - WWHeartRateDetectorDelegate

- (void)didDetectHeartbeat:(WWHeartRateDetector *)detector
                    atTime:(NSDate *)time
{
    
}

- (void)detector:(WWHeartRateDetector *)detector
didReachEndOfData:(NSArray *)data
{
    
}

@end
