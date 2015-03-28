//
//  RightGLKViewController.h
//  YogaApp
//
//  Created by Gabe Aron on 3/19/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import <UIkit/UIKit.h>
#import <GLKit/GLKit.h>
#import "WWCentralDeviceManager.h"

@interface RightGLKViewController : GLKViewController
@property (weak, nonatomic) IBOutlet UILabel *glkRTimeRem;
@property (weak, nonatomic) IBOutlet UILabel *glkRTimeEla;
- (IBAction)glkRstartStop:(id)sender;

@end
