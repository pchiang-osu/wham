//
//  RVFGradientView.m
//  WearWare
//
//  Created by Rutger Farry on 12/14/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import <pop/POP.h>
#import "RVFGradientView.h"


@interface RVFGradientView ()

@property (nonatomic, strong) NSArray *originalColor;
@property (nonatomic, strong) NSArray *pulseColor;

@end

@implementation RVFGradientView



#pragma mark - Class Methods

+ (Class) layerClass {
    return [CAGradientLayer class];
}



#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.delegate = self;
        [self setGradientColors];
        [self.layer setNeedsDisplay];
        self.pulseDuration = 0.5;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.delegate = self;
        [self setGradientColors];
        [self.layer setNeedsDisplay];
        self.pulseDuration = 0.5;
    }
    return self;
}



#pragma mark - Gradient / Animations

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}
*/

- (void)displayLayer:(CAGradientLayer *)layer
{
    layer.colors = self.originalColor;
    layer.startPoint = CGPointMake(0.0, 0.0);
    layer.endPoint = CGPointMake(1.0, 1.0);
    //layer.anchorPoint = CGPointMake(0.5, 0.5);
}

/*
 * This method is called to begin the pulse animation, but it is important to know
 * that it only defines the first half of the animation. After pulseInAnimation
 * completes, it calls the delegate method, animationDidStop:. This begins the 
 * second half of the animation - the fade-out.
 */
- (void)pulse
{
    // Create fade-in animation
    CABasicAnimation *pulseInAnimation = [CABasicAnimation animationWithKeyPath:@"colors"];
    pulseInAnimation.fromValue = self.originalColor;
    pulseInAnimation.toValue = self.pulseColor;
    pulseInAnimation.duration = self.pulseDuration / 2.0;
    pulseInAnimation.delegate = self;
    pulseInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [self.layer addAnimation:pulseInAnimation forKey:@"pulseInAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (((CABasicAnimation *)anim).toValue == self.pulseColor) {
        // Create fade-out animation
        CABasicAnimation *pulseOutAnimation = [CABasicAnimation animationWithKeyPath:@"colors"];
        pulseOutAnimation.fromValue = self.pulseColor;
        pulseOutAnimation.toValue = self.originalColor;
        pulseOutAnimation.duration = self.pulseDuration / 2.0;
        pulseOutAnimation.delegate = self;
        pulseOutAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        [self.layer addAnimation:pulseOutAnimation forKey:@"pulseOutAnimation"];
    }
}



#pragma mark - Colors

- (void)setGradientColors
{
    UIColor* gradientColor;
    UIColor* gradientColor2;
    
    // Set up original colors
    gradientColor = [UIColor colorWithHue:270.0 / 360.0 saturation:25.0 / 100.0 brightness:57.0 / 100.0 alpha:1.0];
    gradientColor2 = [UIColor colorWithHue:274.0 / 360.0 saturation:60.0 / 100.0 brightness:25.0 / 100.0 alpha:1.0];
    self.originalColor = @[(id)gradientColor.CGColor, (id)gradientColor2.CGColor];
    
    // Set up pulse colors
    gradientColor = [UIColor colorWithHue:270.0 / 360.0 saturation:25.0 / 100.0 brightness:75.0 / 100.0 alpha:1.0];
    gradientColor2 = [UIColor colorWithHue:274.0 / 360.0 saturation:60.0 / 100.0 brightness:25.0 / 100.0 alpha:1.0];
    self.pulseColor = @[(id)gradientColor.CGColor, (id)gradientColor2.CGColor];
}
@end







