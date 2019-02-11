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
    [[Universe alloc] init];
}

- (BOOL)shouldAutorotate {
    return NO;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)easym:(id)sender {
}

- (IBAction)em:(id)sender {
}

- (IBAction)easyMode:(id)sender {
    Universe *u = [Universe getSingleton];
    [u setMagicNumber:0];
    [self performSegueWithIdentifier:@"goToGame" sender:self];
}

- (IBAction)hardMode:(id)sender {
    Universe *u = [Universe getSingleton];
    [u setMagicNumber:1];
    [self performSegueWithIdentifier:@"goToGame" sender:self];
}
- (IBAction)pressEasy:(id)sender {
}
@end
