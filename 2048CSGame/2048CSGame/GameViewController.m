//
//  GameViewController.m
//  2048CSGame
//
//  Created by Peter Golden on 2/1/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

@synthesize left, right, down, up;




-(id) init{
    self = [super init];
    if(self){

        NSArray* leftarr = [NSArray arrayWithObjects: @0, @1, @2, @3, nil];
        NSArray* downarr = [NSArray arrayWithObjects: @3, @2, @1, @0, nil];
        NSArray* uparr = [NSArray arrayWithObjects: @0, @4, @8, @12, nil];
        NSArray* rightarr = [NSArray arrayWithObjects: @12, @8, @4, @0, nil];

        _arrIndexes = [NSArray arrayWithObjects: leftarr, downarr, uparr, rightarr, nil];
        
        
        _easyMode = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"110williams"],
                [UIImage imageNamed:@"120madden"],
                [UIImage imageNamed:@"140lander"],
                [UIImage imageNamed:@"220prakash"],
                [UIImage imageNamed:@"240moore"],
                [UIImage imageNamed:@"301weinsc"],
                [UIImage imageNamed:@"320dmitri"],
                [UIImage imageNamed:@"350lewis"],
                [UIImage imageNamed:@"373"],
                [UIImage imageNamed:@"375lyu"],
                [UIImage imageNamed:@"471head"],
                nil];
        
        _hardMode = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"101foreman"],
                [UIImage imageNamed:@"110williams"],
                [UIImage imageNamed:@"120moore"],
                [UIImage imageNamed:@"140lander"],
                [UIImage imageNamed:@"220prakash"],
                [UIImage imageNamed:@"240lewis"],
                [UIImage imageNamed:@"301weinsc"],
                [UIImage imageNamed:@"320dmitri"],
                [UIImage imageNamed:@"350kartrik"],
                [UIImage imageNamed:@"373"],
                [UIImage imageNamed:@"375lyu"],
                [UIImage imageNamed:@"471head"],
                [UIImage imageNamed:@"441Madden"],
                     nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) collapseBlocks:(int) direction{
    //test
    
}

- (IBAction)pressLeft:(UIButton *)sender {
    [self collapseBlocks:0];
}

- (IBAction)pressDown:(UIButton *)sender {
    [self collapseBlocks:1];
}

- (IBAction)pressUp:(UIButton *)sender {
    [self collapseBlocks:2];
}

- (IBAction)pressRight:(UIButton *)sender {
    [self collapseBlocks:3];
}


@end
