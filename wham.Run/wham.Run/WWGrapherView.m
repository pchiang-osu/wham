//
//  WWGrapher.m
//  WearWare
//
//  Created by Rutger Farry on 11/22/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "WWGrapher.h"
#import "NSMutableArray+QueueAdditions.h"

@interface WWGrapher ()

@property (nonatomic) CGFloat currentXPosition;
@property (nonatomic) CGFloat maxY;
@property (strong, nonatomic) NSMutableArray *pointArray;
@property (nonatomic) float calibrationValue;

@end

@implementation WWGrapher

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentXPosition = 0;
        _maxY = 1;
        _pointArray = [[NSMutableArray alloc] init];
        _calibrationValue = 2.0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentXPosition = 0;
        _maxY = 0;
        _pointArray = [[NSMutableArray alloc] initWithCapacity:380];
        NSLog(@"Width: %f", self.frame.size.width);
        
        for (int i = 0; i < 380; i++) {
            [_pointArray addObject:[NSNumber numberWithFloat:0.0]];
        }
    }
    return self;
}


- (void)addPointToGraph:(CGFloat)point
{
    //NSLog(@"Point: %f", point);
    NSNumber *number = [NSNumber numberWithFloat:point * self.calibrationValue];
    [self.pointArray enqueue:number];
    
    //self.maxY = (self.maxY < point) ? point : self.maxY;
    [self.pointArray dequeue];
}

- (void)graph
{
    [self setNeedsDisplay];
}

- (void)calibrateGraphToNumber:(float)number
{
    self.calibrationValue = number;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    int dataArrayIterator = 1;
    for (int i = self.frame.size.width; i >= 0; i--) {
//        NSLog(@"Width2: %f", self.frame.size.width);
//        NSLog(@"dataArrayInterator: %d", dataArrayIterator);
//        NSLog(@"Array: %@", self.pointArray);
        CGFloat previousPointHeight = ((NSNumber *)self.pointArray[self.pointArray.count - dataArrayIterator - 1]).floatValue;
        CGPoint previousPoint = CGPointMake(i, previousPointHeight);
        CGFloat currentPointHeight = ((NSNumber *)self.pointArray[self.pointArray.count - dataArrayIterator]).floatValue;
        CGPoint currentPoint = CGPointMake(i, currentPointHeight);
        dataArrayIterator++;
        
        // Draws a line between the two points
        UIBezierPath *bar = [[UIBezierPath alloc] init];
        [bar moveToPoint:previousPoint];
        [bar addLineToPoint:currentPoint];
        bar.lineWidth = 2;
        [[UIColor blackColor] setStroke];
        [bar stroke];
    }
}




@end
