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

@property (weak, nonatomic) IBOutlet UIImageView *uiiv0;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv1;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv2;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv3;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv4;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv5;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv6;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv7;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv8;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv9;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv10;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv11;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv12;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv13;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv14;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv15;
@property (weak, nonatomic) IBOutlet UIImageView *uiiv16;

@property (nonatomic, strong) NSArray* boxes;
@property (nonatomic, strong) NSArray* easyMode;
@property (nonatomic, strong) NSArray* hardMode;

- (void) collapseBlocks: (int) direction;
- (void) gameComplete;
- (void) setImages: (NSInteger[16]) values;
- (IBAction) pressLeft: (UIButton*) sender;
- (IBAction) pressDown: (UIButton*) sender;
- (IBAction) pressUp: (UIButton*) sender;
- (IBAction) pressRight: (UIButton*) sender;


@end
