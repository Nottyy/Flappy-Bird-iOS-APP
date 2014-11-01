//
//  FlappyBirdFieldController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>

int birdFlight;
int randomTopTunnelPosition;
int randomBottomTunnelPosition;

@interface FlappyBirdGameFieldController : UIViewController{
    NSTimer *birdMovementTimer;
    NSTimer *tunnelMovementTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *objectBird;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartGame;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelTop;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelBottom;
@property (weak, nonatomic) IBOutlet UIImageView *borderTop;
@property (weak, nonatomic) IBOutlet UIImageView *borderBottom;

- (IBAction)startGame:(id)sender;
- (void)birdMoving;
- (void)tunnelMoving;
- (void)placeTunnels;
@end
