//
//  RightGLKViewController.h
//  YogaApp
//
//  Created by Gabe Aron on 3/19/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import <UIkit/UIKit.h>
#import <GLKit/GLKit.h>
//#import "WWCentralDeviceManager.h"                      //old devices
#import <WWFramework/WWCentralDeviceManager.h>          //new devices
#import "WWProtocol.h"

@interface RightGLKViewController : GLKViewController
@property (weak, nonatomic) IBOutlet UILabel *glkRTimeRem;
@property (weak, nonatomic) IBOutlet UILabel *glkRTimeEla;
@property (weak, nonatomic) IBOutlet UILabel *xyzData;
- (IBAction)glkRstartStop:(id)sender;

@end
