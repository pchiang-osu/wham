//
//  WWGrapherView.m
//  WearWare
//
//  Created by Rutger Farry on 11/22/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "WWGrapherView.h"
#import "NSMutableArray+QueueAdditions.h"

@interface WWGrapherView ()

@property (nonatomic) CGFloat currentXPosition;
@property (nonatomic) CGFloat maxY;
@property (strong, nonatomic) NSMutableArray *pointArray;

@end

@implementation WWGrapherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentXPosition = 0;
        _maxY = 1;
        _pointArray = [[NSMutableArray alloc] init];
        _calibrationScalar = 2.0;
        _calibrationOffset = 0;
        
        (self.strokeColor == nil) ? [UIColor grayColor] : self.strokeColor;
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
//    NSLog(@"Point: %f", point);
    
    point *= self.calibrationScalar;
    point += self.calibrationOffset;
    
    NSNumber *number = [NSNumber numberWithFloat:point];
    
    [self.pointArray enqueue:number];
    [self.pointArray dequeue];
}

- (void)graph
{
    [self setNeedsDisplay];
}

- (void)calibrateGraphToNumber:(float)number
{
    self.calibrationScalar = number;
}

- (void)drawRect:(CGRect)rect {
    int dataArrayIterator = 1;
    for (int i = self.frame.size.width; i >= 0; i--) {
        CGFloat previousPointHeight = ((NSNumber *)self.pointArray[self.pointArray.count - dataArrayIterator - 1]).floatValue;
        CGPoint previousPoint = CGPointMake(i, previousPointHeight);
        CGFloat currentPointHeight = ((NSNumber *)self.pointArray[self.pointArray.count - dataArrayIterator]).floatValue;
        CGPoint currentPoint = CGPointMake(i, currentPointHeight);
        dataArrayIterator++;
        
        // Draws a line between the two points
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:previousPoint];
        [path addLineToPoint:currentPoint];
        path.lineWidth = 3;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        [self.strokeColor setStroke];
        [path stroke];
    }
}



@end
