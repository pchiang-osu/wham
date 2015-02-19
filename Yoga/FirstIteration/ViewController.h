//
//  ViewController.h
//  playin' around
//
//  Created by CS Team on 2/3/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *LabelTimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *LabelTimeRemaining;

- (IBAction)ClickHereButton:(id)sender;

@end


