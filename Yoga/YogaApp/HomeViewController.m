//
//  HomeViewController.m
//  YogaApp
//
//  Created by CS Team on 2/14/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)start:(id)sender{
     _StartLabel.text=[NSString stringWithFormat:@"Start Clicked"];
}

@end
