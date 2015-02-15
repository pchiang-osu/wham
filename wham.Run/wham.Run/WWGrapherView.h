//
//  WWGrapherView.h
//  WearWare
//
//  Created by Rutger Farry on 11/22/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWGrapherView : UIView

@property (strong, nonatomic) UIColor *strokeColor;

- (void)addPointToGraph:(CGFloat)point;
- (void)graph;
- (void)calibrateGraphToNumber:(float)number;

@end
