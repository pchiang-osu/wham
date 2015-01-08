//
//  RVFCircularProgressIndicator.m
//  WearWare
//
//  Created by Rutger Farry on 12/16/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "RVFCircularProgressIndicator.h"

const CGFloat NINETY_DEGREES = (90.0 * M_PI) / 180.0;
const CGFloat TWO_SEVENTY_DEGREES = (270.0 * M_PI) / 180.0;

@interface RVFCircularProgressIndicator ()

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat progressRadians;

@end

@implementation RVFCircularProgressIndicator



#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (self.frame.size.width >= self.frame.size.height)
            _radius = self.frame.size.height;
        else
            _radius = self.frame.size.width;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        if (self.frame.size.width >= self.frame.size.height)
            _radius = self.frame.size.height / 2.0f;
        else
            _radius = self.frame.size.width / 2.0f;
    }
    return self;
}



#pragma mark - Drawing Code

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, <#const CGFloat *components#>, NULL, 2);
    [self setDefaultValues];
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    


    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:self.radius - (self.lineThickness / 2.0)
                                                              startAngle:TWO_SEVENTY_DEGREES
                                                                endAngle:self.progressRadians
                                                               clockwise:YES];
    [[UIColor whiteColor] setStroke];
    [progressCircle stroke];
    
    
}

- (void)setDefaultValues
{
    self.startColor = (!self.startColor) ? [UIColor grayColor] : self.startColor;
    self.endColor = (!self.endColor) ? [UIColor grayColor] : self.endColor;
    self.lineThickness = (self.lineThickness == 0) ? 5.0 : self.lineThickness;
}

#pragma mark - Setters and Getters

- (void)setProgressDegrees:(CGFloat)progressDegrees
{
    // Check to make sure degrees is not too high
    _progressDegrees = (progressDegrees >= 359.9999) ? 359.9999 : progressDegrees;
    self.progressRadians = ((self.progressDegrees - 90) * M_PI) / 180.0;
    [self setNeedsDisplay];
}
@end
