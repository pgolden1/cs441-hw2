//
//  MainViewController.m
//  2048CSGame
//
//  Created by Peter Golden on 2/2/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@implementation MainViewController

- (void) viewDidLoad{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return NO;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)easym:(id)sender {
}

- (IBAction)easyMode:(id)sender {
    NSLog(@"Pressed easy mode");
}

- (IBAction)hardMode:(id)sender {
    NSLog(@"Pressed hard mode");
}
- (IBAction)pressEasy:(id)sender {
}
@end
