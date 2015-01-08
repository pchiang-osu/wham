//
//  RVFCircularProgressIndicator.h
//  WearWare
//
//  Created by Rutger Farry on 12/16/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVFCircularProgressIndicator : UIView

// The indicator is filled with a gradient that
// begins with startColor and ends with endColor
@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;

@property (nonatomic) CGFloat lineThickness;

@property (nonatomic) CGFloat progressDegrees;

@end
