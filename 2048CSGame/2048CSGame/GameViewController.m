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

        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_currentMode removeAllObjects];
    
    Universe *u = [Universe getSingleton];

    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    _boxes = [NSArray arrayWithObjects: _uiiv1, _uiiv2, _uiiv3, _uiiv4, _uiiv5, _uiiv6, _uiiv7, _uiiv8, _uiiv9, _uiiv10, _uiiv11, _uiiv12, _uiiv13, _uiiv14, _uiiv15, _uiiv16, nil];
    
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
                 [UIImage imageNamed:@"350kartik"],
                 [UIImage imageNamed:@"373"],
                 [UIImage imageNamed:@"375lyu"],
                 [UIImage imageNamed:@"471head"],
                 [UIImage imageNamed:@"441madden"],
                  nil];
    
    
    _values = [[NSMutableArray alloc] initWithObjects: @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, @-1, nil];
    
    _negone = [NSNumber numberWithInt:-1];
    
    if([u magicNumber]) _currentMode = [[NSMutableArray alloc]
                        initWithArray:_hardMode copyItems:YES];

    else _currentMode = [[NSMutableArray alloc]
                        initWithArray:_easyMode copyItems:YES];
    
    
    _uiiv0.image = (UIImage*)  _currentMode[[_currentMode count]-1];
    
    
    
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


- (void)gameWin{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You won! Congratulations!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) gameOver{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game over!" message:@"No more moves can be made!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void) setImages{
    
    for(int i = 0; i < 16; i++){
        UIImageView* current = (UIImageView*) _boxes[i];
        NSNumber* num1 = (NSNumber*) _values[i];
        if([num1 intValue] == -1) current.image = nil;
        else{
            NSNumber* arrind = (NSNumber*) _values[i];
            int arrint = [arrind intValue];
            UIImage* newIm = (UIImage*) _currentMode[arrint];
            current.image = newIm;
        }
    }
    
}

-(void) spawnNewTile{
    BOOL possiblespawns[16];
    BOOL hasBeenSpawned = false;
    NSUInteger max_val = [_currentMode count];
    
    for(int i = 0; i < 16; i++){
        if((NSUInteger) _values[i] == max_val) [self gameWin];
        if(_values[i] == _negone) possiblespawns[i] = true;
        else possiblespawns[i] = false;
    }
    
    BOOL stillPossible = false;
    for(int i = 0; i < 16; i++) if(possiblespawns[i]) stillPossible = true;
    
    if(stillPossible){
        int r;
        NSNumber* newNum;
        while(!hasBeenSpawned){
            r = arc4random_uniform(16);
            if(possiblespawns[r]){
                newNum = [NSNumber numberWithInt:arc4random_uniform(2)];
                [_values replaceObjectAtIndex:r withObject: newNum];
                hasBeenSpawned = true;
            }
        }
    } else [self gameOver];
    
     [self setImages];
}

// make sure this is correct vvvvvvvv
- (void) collapseBlocks:(int) direction{
    
    /*
     PSEUDO CODE:
     
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
   
    int i, j, row, column, col2, currentcol, val;
    BOOL validmove = false, marked[4][4];
    NSNumber* currNum, *newNum;
    NSInteger arrayIndexes[4][4];
    NSInteger currentArrInd, currentArrInd2;
    
    NSInteger leftarr[4][4] = {{0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15}};
    NSInteger uparr[4][4] = {{3,7,11,15},{2,6,10,14},{1,5,9,13},{0,4,8,12}};
    NSInteger downarr[4][4] = {{12,8,4,0},{13,9,5,1},{14,10,6,2},{15,11,7,3}};
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
    
    NSArray* before = [[NSArray alloc]
                       initWithArray:_values copyItems:YES];

    //2048 collapsing logic
    for(row = 0; row < 4; row++){
        for(currentcol = 0; currentcol < 3; currentcol++){
            for(column = currentcol; column < 3; column++){
                
                for(col2 = column+1; col2 <4; col2++){
                    if([_values[arrayIndexes[row][col2]] intValue] != -1){
                        break;
                    }
                }
                
                
                currentArrInd = arrayIndexes[row][column];
                currentArrInd2 = arrayIndexes[row][col2];
                
                int int1 = [(NSNumber*) _values[currentArrInd] intValue];
                int int2 = [(NSNumber*) _values[currentArrInd2] intValue];
                
               if(int1 == int2 && int1 != -1 && !marked[row][column]){

                   currNum = (NSNumber*) _values[currentArrInd];
                   val = [currNum intValue];
                   newNum = [NSNumber numberWithInt:val + 1];
                   [_values replaceObjectAtIndex:currentArrInd withObject: newNum];
                   [_values replaceObjectAtIndex:currentArrInd2 withObject: _negone];
                   
                   marked[row][column] = true;
               }
            }
        }
    }
    
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            for(int k = 0; k < 3; k++){
                NSNumber* n1 = (NSNumber*) _values[arrayIndexes[j][k]];
                NSNumber* n2 = (NSNumber*) _values[arrayIndexes[j][k+1]];
                
                if([n1 intValue] == -1){[_values replaceObjectAtIndex:arrayIndexes[j][k] withObject: n2];
                
                [_values replaceObjectAtIndex:arrayIndexes[j][k+1] withObject: _negone];
                }
            }
        }
    }
    
    for(int i = 0; i < 16; i++){
        int beforenum = [(NSNumber*) before[i] intValue];
        int afternum = [(NSNumber*) _values[i] intValue];
        if(beforenum != afternum) validmove = true;
    }
    
    if(validmove) [self spawnNewTile];
    
    [self setImages];

    
}

- (IBAction)pressLeft:(UIButton *)sender {
    [self collapseBlocks:0];
}

- (IBAction)pressDown:(UIButton *)sender {
    [self gameWin];
    //[self collapseBlocks:1];
}

- (IBAction)pressUp:(UIButton *)sender {
    [self collapseBlocks:2];
}

- (IBAction)pressRight:(UIButton *)sender {
    [self collapseBlocks:3];
}


@end
