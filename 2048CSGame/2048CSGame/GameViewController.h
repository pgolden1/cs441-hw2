//
//  GameViewController.h
//  2048CSGame
//
//  Created by Peter Golden on 2/1/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton* left, *right, *up, *down;

@property (nonatomic) NSArray* arrIndexes;
@property (nonatomic, strong) UIImageView* boxes;
@property (nonatomic, strong) UIImage* easyMode;
@property (nonatomic, strong) UIImage* hardMode;

- (void) collapseBlocks: (int) direction;
- (IBAction) pressLeft: (UIButton*) sender;
- (IBAction) pressDown: (UIButton*) sender;
- (IBAction) pressUp: (UIButton*) sender;
- (IBAction) pressRight: (UIButton*) sender;

@end
