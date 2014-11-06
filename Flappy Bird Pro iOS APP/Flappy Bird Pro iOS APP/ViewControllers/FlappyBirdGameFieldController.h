//
//  FlappyBirdFieldController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

int birdFlight;
int randomTopTunnelPosition;
int randomBottomTunnelPosition;
int scoreNumber;
int logoMotion;
int pushTunnels;
NSInteger *highScoreNumber;
NSString *audioForPointPath;
NSString *audioForGameOverPath;
NSString *audioForPushingTunnelsPath;

@interface FlappyBirdGameFieldController : UIViewController<UIDynamicAnimatorDelegate>{
    NSTimer *birdMovementTimer;
    NSTimer *tunnelMovementTimer;
    NSTimer *logoMovement;
    
    AVAudioPlayer *audioPlayerForPoint;
    AVAudioPlayer *audioPlayerForGameOver;
    AVAudioPlayer *audioPlayerForPushingTunnels;
}

//@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *objectBird;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartGame;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelTop;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelBottom;
@property (weak, nonatomic) IBOutlet UIImageView *borderTop;
@property (weak, nonatomic) IBOutlet UIImageView *borderBottom;
@property (weak, nonatomic) IBOutlet UIImageView *logoGameOverAndStartGame;


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender;

- (IBAction)startGame:(id)sender;
- (void)birdMoving;
- (void)tunnelMoving;
- (void)placeTunnels;
- (void)setScore;
- (void)gameOver;
@end
