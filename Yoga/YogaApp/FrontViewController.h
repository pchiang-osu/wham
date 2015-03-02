//
//  FrontViewController.h
//  YogaApp
//
//  Created by CS Team on 2/21/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *frontTimeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *frontTimeRem;
- (IBAction)frontStart:(id)sender;


@end
