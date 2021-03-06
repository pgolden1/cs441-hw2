//
//  MainViewController.h
//  2048CSGame
//
//  Created by Peter Golden on 2/2/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "Universe.h"
@interface MainViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *easy;
@property (nonatomic, strong) IBOutlet UIButton *hard;

- (IBAction) easyMode: (UIButton*) sender;
- (IBAction) hardMode: (UIButton*) sender;

@end
