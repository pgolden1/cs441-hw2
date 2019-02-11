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


-(id) init{
    self = [super init];
    if(self){

        _boxes = [NSArray arrayWithObjects: _uiiv1, _uiiv2, _uiiv3, _uiiv4,
                                            _uiiv5, _uiiv6, _uiiv7, _uiiv8,
                                            _uiiv9, _uiiv10, _uiiv11, _uiiv12,
                  _uiiv13, _uiiv14, _uiiv15, _uiiv16, nil];
        
        _easyMode = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"110williams.png"],
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
        
        _values = [[NSMutableArray alloc] initWithObjects: @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, nil];
        
        _negone = [NSNumber numberWithInt:-1];
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
    
    
    //spawn first two blocks
    int r = arc4random_uniform(16), s = arc4random_uniform(16);
    
    while(r == s) s = arc4random_uniform(16);
    
    for(int i = 0; i < 16; i++){
        if(i == r){
            NSNumber* newNum = [NSNumber numberWithInt:arc4random_uniform(2)];
            [_values replaceObjectAtIndex:i withObject: newNum];
        }
        else{
            if(i == s) {
                NSNumber* newNum = [NSNumber numberWithInt:arc4random_uniform(2)];
                [_values replaceObjectAtIndex:i withObject: newNum];
            }
            else {
                [_values replaceObjectAtIndex:i withObject: _negone];
            }
        }
    }
    
    [self setImages];
    
}


- (void)gameComplete{
    
}

//work on this vvvvvvvv
- (void) setImages{
    for(int i = 0; i < 16; i++){
        NSLog(@"%ld", (long) _values[i]);
        UIImageView* current = (UIImageView*) _boxes[i];
        NSNumber* num1 = (NSNumber*) _values[i];
        NSComparisonResult n = [num1 compare:_negone];
        if(n == NSOrderedDescending){
            NSLog(@"Here%d", i);
            NSNumber* arrind = (NSNumber*) _values[i];
            int arrint = [arrind intValue];
            UIImage* newIm = (UIImage*) _easyMode[arrint];
            current.image = newIm;
        }
        else  current.image = nil;
    }
}

// make sure this is correct vvvvvvvv
- (void) collapseBlocks:(int) direction{
    
    /*
     for(int row = 0; row < 4; row++){
         for(int column = 0; column < 4; column++){
             if(cells[row][column].block == cells[row][column+1].block
                        && cells[row][column] is unmarked){
                 cells[row][column].block += 1
                 mark cells[row][column]
                 for(int i = column +2; i < 4; i++){
                     cells[row][i-1] = cells[row][i]
                     delete cells[row][i]
                }
             }
         }
     }
     
     for(int row = 0; row < 4; row++){
         for(int column = 0; column < 4; column++){
             unmark cells[row][column]
             check if any cell is max tile
             if so, go to game complete
         }
     }
     
     spawn random tile
     */
   
    int i, j, r, row, column;
    BOOL marked[4][4];
    BOOL possiblespawns[16];
    BOOL hasBeenSpawned = false;
    NSNumber* max_val = [NSNumber numberWithInt:0]; //set appropriate for game mode
    NSNumber* currNum, *newNum;
    NSInteger arrayIndexes[4][4];
    NSInteger currentArrInd, currentArrInd2;
    
    NSInteger leftarr[4][4] = {{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}};
    NSInteger downarr[4][4] = {{3,7,11,15},{2,6,10,14},{1,5,9,13},{0,4,8,12}};
    NSInteger uparr[4][4] = {{12,8,4,0},{13,9,5,1},{14,10,6,2},{15,11,7,3}};
    NSInteger rightarr[4][4] = {{15,14,13,12},{11,10,9,8},{7,6,5,4},{3,2,1,0}};
    
    //Initializer loops
    for(i = 0; i < 4; i++){
        for(j = 0; j < 4; j++){
            if(direction == 0) arrayIndexes[i][j] = leftarr[i][j];
            if(direction == 1) arrayIndexes[i][j] = downarr[i][j];
            if(direction == 2) arrayIndexes[i][j] = uparr[i][j];
            if(direction == 3) arrayIndexes[i][j] = rightarr[i][j];
            marked[i][j] = false;
        }
    }
    
    
    //2048 collapsing logic
    for(row = 0; row < 4; row++){
        for(column = 0; column < 4; column++){
            currentArrInd = arrayIndexes[row][column];
            currentArrInd2 = arrayIndexes[row][column+1];
            
           if(_values[currentArrInd] == _values[currentArrInd2] && !marked[row][column]){
               currNum = (NSNumber*) _values[currentArrInd];
               int val = [currNum intValue];
               newNum = [NSNumber numberWithInt:val + 1];
               [_values replaceObjectAtIndex:currentArrInd withObject: newNum];
               
               marked[row][column] = true;
               
               for(i = column + 2; i < 4; i++){
                   currNum = (NSNumber*) _values[arrayIndexes[row][i]];
                   val = [currNum intValue];
                   newNum = [NSNumber numberWithInt:val];
                   [_values replaceObjectAtIndex:arrayIndexes[row][i-1] withObject: newNum];
                   
                   [_values replaceObjectAtIndex:arrayIndexes[row][i] withObject: _negone];

               }
            }
        }
    }
    
    //spawning new tile
    for(i = 0; i < 16; i++){
        if(_values[i] == max_val) [self gameComplete];
        if(_values[i] == _negone) possiblespawns[i] = true;
        else possiblespawns[i] = false;
    }
    
    while(!hasBeenSpawned){
        r = arc4random_uniform(16);
        if(possiblespawns[r]){
            newNum = [NSNumber numberWithInt:arc4random_uniform(2)];
            [_values replaceObjectAtIndex:r withObject: newNum];
            hasBeenSpawned = true;
        }
    }
    
    [self setImages];

    
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
