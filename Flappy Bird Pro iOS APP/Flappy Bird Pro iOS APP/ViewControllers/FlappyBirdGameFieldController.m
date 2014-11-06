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

@implementation FlappyBirdGameFieldController{
    BOOL gameBegan;
    BOOL usedPush;
    CGFloat initialLogoXCoordinate;
    UIDynamicAnimator *animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tunnelTop.hidden = YES;
    self.tunnelBottom.hidden = YES;
    
    logoMotion = -5;
    
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey: @"HighScoreNumber"];
    
    audioForPointPath = [[NSBundle mainBundle] pathForResource:@"point" ofType:@"mp3"];
    audioPlayerForPoint = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioForPointPath] error:NULL];
    [audioPlayerForPoint prepareToPlay];
    
    audioForGameOverPath = [[NSBundle mainBundle] pathForResource:@"crash" ofType:@"wav"];
    audioPlayerForGameOver = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForGameOverPath] error:NULL];
    [audioPlayerForGameOver prepareToPlay];
    
    audioForPushingTunnelsPath = [[NSBundle mainBundle] pathForResource:@"pushTunnelsSound" ofType:@"wav"];
    audioPlayerForPushingTunnels = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForPushingTunnelsPath] error:NULL];
    [audioPlayerForPushingTunnels prepareToPlay];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    initialLogoXCoordinate = self.logoGameOverAndStartGame.center.x;
    
    [self setLogoTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated..
}

-(void) logoMoving{
    self.logoGameOverAndStartGame.center = CGPointMake(self.logoGameOverAndStartGame.center.x + logoMotion, self.logoGameOverAndStartGame.center.y);
    
    if (self.logoGameOverAndStartGame.center.x <= initialLogoXCoordinate - 20) {
        logoMotion = 5;
    }
    
    if (self.logoGameOverAndStartGame.center.x >= initialLogoXCoordinate + 20) {
        logoMotion = -5;
    }
}

- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender {
    
    // the user can use the option to pass the tunnels easily as he push the tunnels with the pinch gesture
    if (gameBegan == YES && pushTunnels > 0 && usedPush == NO) {
        [audioPlayerForPushingTunnels play];
        pushTunnels -= 1;
        usedPush = YES;
        NSLog(@"Pinched");
        self.tunnelTop.center = CGPointMake(self.tunnelTop.center.x, self.tunnelTop.center.y - 20);
        self.tunnelBottom.center = CGPointMake(self.tunnelBottom.center.x, self.tunnelBottom.center.y + 20);
    }
}

- (IBAction)startGame:(id)sender {
    [logoMovement invalidate];
    gameBegan = YES;
    usedPush = NO;
    pushTunnels = 3;
    scoreNumber = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
    
    self.logoGameOverAndStartGame.hidden = YES;
    self.tunnelTop.hidden = NO;
    self.tunnelBottom.hidden = NO;
    self.buttonStartGame.hidden = YES;
    self.exitButton.hidden = YES;
    
    
    self.objectBird.center = CGPointMake(self.objectBird.center.x, [[UIScreen mainScreen]bounds].size.height / 2);
    self.objectBird.image = [UIImage imageNamed: @"BirdUp.png"];
    
    birdMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    
    [self placeTunnels];
    
    tunnelMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tunnelMoving) userInfo:nil repeats:YES];
}

-(void)tunnelMoving{
    self.tunnelTop.center = CGPointMake(self.tunnelTop.center.x - 1, self.tunnelTop.center.y);
    self.tunnelBottom.center = CGPointMake(self.tunnelBottom.center.x - 1, self.tunnelBottom.center.y);
    if (self.tunnelTop.center.x <= -55) {
        
        // see if the user has pushTunnels options left and nullify the BOOL 'usedPush'
        if (pushTunnels > 0) {
            usedPush = NO;
        }
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
    randomBottomTunnelPosition = randomTopTunnelPosition + 855;
    
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
    //self.scoreLabel.text = [NSString stringWithFormat:@"%d", scoreNumber];

    [audioPlayerForPoint play];
}

-(void)gameOver{
    gameBegan = NO;
    [audioPlayerForGameOver play];
    if (scoreNumber > highScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:scoreNumber forKey:@"HighScoreNumber"];
    }
    
    [tunnelMovementTimer invalidate];
    [birdMovementTimer invalidate];
    
    self.objectBird.image = [UIImage imageNamed:@"gameOverBird.png"];
//    birdMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(birdMovementWhenCrashed) userInfo:nil repeats:YES];
    self.tunnelBottom.hidden = YES;
    self.tunnelTop.hidden = YES;
    
    [self setAnimator];
}

-(void) setAnimator{
    animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    animator.delegate = self;
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.objectBird]];
    [animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.objectBird]];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [animator addBehavior: collision];
    
    UIDynamicItemBehavior *dynamic = [[UIDynamicItemBehavior alloc] initWithItems: @[self.objectBird]];
    dynamic.elasticity = 0.75;
    dynamic.density = 20.0;
    dynamic.allowsRotation = YES;
    [animator addBehavior: dynamic];
    
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.objectBird] mode:UIPushBehaviorModeInstantaneous];
    int pushVector = scoreNumber + 70;
    push.pushDirection = CGVectorMake(pushVector, pushVector);
    [animator addBehavior:push];
}

//-(void) birdMovementWhenCrashed{
//    self.objectBird.center = CGPointMake(self.objectBird.center.x, self.objectBird.center.y + birdFlight);
//    
//    birdFlight = birdFlight + 5;
//    
//    if (birdFlight >= 10) {
//        birdFlight = 10;
//    }
//    
//    if (self.objectBird.center.y >= [[UIScreen mainScreen] bounds].size.height - 40) {
//        [birdMovementTimer invalidate];
//        self.objectBird.hidden = YES;
//        self.logoGameOverAndStartGame.image = [UIImage imageNamed:@"game-over.jpg"];
//        self.logoGameOverAndStartGame.hidden = NO;
//        self.exitButton.hidden = NO;
//        self.buttonStartGame.hidden = NO;
//        self.buttonStartGame.titleLabel.text = @"Try Again?";
//        
//        [self setLogoTimer];
//    }
//}

-(void) setLogoTimer{
    logoMovement = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(logoMoving) userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    birdFlight = 30;
}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    self.logoGameOverAndStartGame.image = [UIImage imageNamed:@"game-over.jpg"];
    self.logoGameOverAndStartGame.hidden = NO;
    self.exitButton.hidden = NO;
    self.objectBird.image = [UIImage imageNamed:@"BirdUp.png"];
    self.buttonStartGame.hidden = NO;
    [self setLogoTimer];
}

@end
