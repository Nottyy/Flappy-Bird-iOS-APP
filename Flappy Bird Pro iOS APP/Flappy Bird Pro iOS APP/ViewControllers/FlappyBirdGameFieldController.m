//
//  FlappyBirdFieldController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "FlappyBirdGameFieldController.h"

@interface FlappyBirdGameFieldController ()

@end

@implementation FlappyBirdGameFieldController

- (void)viewDidLoad {
    
    self.tunnelTop.hidden = YES;
    self.tunnelBottom.hidden = YES;
    self.exitButton.hidden = YES;
    scoreNumber = 0;
    
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey: @"HighScoreNumber"];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated..
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller..
}
*/

- (IBAction)startGame:(id)sender {
    self.tunnelTop.hidden = NO;
    self.tunnelBottom.hidden = NO;
    self.buttonStartGame.hidden = YES;
    
    birdMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    
    [self placeTunnels];
    
    tunnelMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tunnelMoving) userInfo:nil repeats:YES];
}

-(void)tunnelMoving{
    self.tunnelTop.center = CGPointMake(self.tunnelTop.center.x - 1, self.tunnelTop.center.y);
    self.tunnelBottom.center = CGPointMake(self.tunnelBottom.center.x - 1, self.tunnelBottom.center.y);
    if (self.tunnelTop.center.x < -55) {
        [self placeTunnels];
    }
    
    if (self.tunnelTop.center.x == 27) {
        [self setScore];
    }
    
    
    // check if the bird has collided with the four tunnels
    if (CGRectIntersectsRect(self.objectBird.frame, self.tunnelTop.frame) ||
        CGRectIntersectsRect(self.objectBird.frame, self.tunnelBottom.frame) ||
        CGRectIntersectsRect(self.objectBird.frame, self.borderBottom.frame) ||
        CGRectIntersectsRect(self.objectBird.frame, self.borderTop.frame)) {
        [self gameOver];
    }
}

-(void)placeTunnels{
    randomTopTunnelPosition = arc4random() % 350;
    randomTopTunnelPosition -= 228;
    randomBottomTunnelPosition = randomTopTunnelPosition + 655;
    
    self.tunnelTop.center = CGPointMake(620, randomTopTunnelPosition);
    self.tunnelBottom.center = CGPointMake(620, randomBottomTunnelPosition);
}

-(void)birdMoving{
    self.objectBird.center = CGPointMake(self.objectBird.center.x, self.objectBird.center.y - birdFlight);
    
    birdFlight -= 5;
    
    if (birdFlight < - 15) {
        birdFlight = -15;
    }
    
    if (birdFlight < 0) {
        self.objectBird.image = [UIImage imageNamed:@"BirdDown.png"];
    }
    else{
        self.objectBird.image = [UIImage imageNamed:@"BirdUp.png"];
    }
        
}

-(void)setScore{
    scoreNumber = scoreNumber + 1;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
}

-(void)gameOver{
    if (scoreNumber > highScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:scoreNumber forKey:@"HighScoreNumber"];
    }
    
    [tunnelMovementTimer invalidate];
    [birdMovementTimer invalidate];
    
    self.exitButton.hidden = NO;
    self.tunnelBottom.hidden = YES;
    self.tunnelTop.hidden = YES;
    self.objectBird.hidden = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    birdFlight = 30;
}
@end
