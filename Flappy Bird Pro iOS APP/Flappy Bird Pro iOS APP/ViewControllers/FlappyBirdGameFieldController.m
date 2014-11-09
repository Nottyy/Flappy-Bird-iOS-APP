//
//  FlappyBirdFieldController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "FlappyBirdGameFieldController.h"
#import "AppDelegate.h"
#import "CorePlayer.h"
#import "FlappyAngryUser.h"
#import "CurrentPlayer.h"

@interface FlappyBirdGameFieldController ()

@property (strong,nonatomic) FlappyAngryUser* curUser;
@property (strong,nonatomic) AppDelegate* appDelegate;
@end

@implementation FlappyBirdGameFieldController{
    BOOL gameBegan;
    BOOL usedCutBird;
    BOOL usedPush;
    BOOL madeNewHighScore;
    CGFloat initialLogoXCoordinate;
    UIDynamicAnimator *animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tunnelTop.hidden = YES;
    self.tunnelBottom.hidden = YES;
    
    self.curUser = [FlappyAngryUser currentUser];
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    logoMotion = -5;
    
    audioForPointPath = [[NSBundle mainBundle] pathForResource:@"point" ofType:@"mp3"];
    audioPlayerForPoint = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioForPointPath] error:NULL];
    [audioPlayerForPoint prepareToPlay];
    
    audioForGameOverPath = [[NSBundle mainBundle] pathForResource:@"crash" ofType:@"wav"];
    audioPlayerForGameOver = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForGameOverPath] error:NULL];
    [audioPlayerForGameOver prepareToPlay];
    
    audioForPushingTunnelsPath = [[NSBundle mainBundle] pathForResource:@"pushTunnelsSound" ofType:@"wav"];
    audioPlayerForPushingTunnels = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForPushingTunnelsPath] error:NULL];
    [audioPlayerForPushingTunnels prepareToPlay];
    
    audioForShrinkng = [[NSBundle mainBundle] pathForResource:@"shrink" ofType:@"wav"];
    audioPlayerForShrinkig = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForShrinkng] error:NULL];
    [audioPlayerForShrinkig prepareToPlay];
    
    audioForNewHighScore = [[NSBundle mainBundle] pathForResource:@"new-highscore" ofType:@"wav"];
    audioPlayerForNewHighScore = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:audioForNewHighScore] error:NULL];
    [audioPlayerForNewHighScore prepareToPlay];
}

-(void)viewDidAppear:(BOOL)animated{
    initialLogoXCoordinate = self.logoGameOverAndStartGame.center.x;
    
    [self setLogoTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [logoMovement invalidate];
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

- (IBAction)swipeGasture:(UISwipeGestureRecognizer *)sender {
    if (gameBegan == YES && cutBird > 0 && usedCutBird == NO) {
        [audioPlayerForShrinkig play];
        cutBird -= 1;
        usedCutBird = YES;
        NSLog(@"Swiped");
        self.objectBird.frame = CGRectMake(self.objectBird.center.x - 20, self.objectBird.center.y - 20, self.objectBird.frame.size.width - 20, self.objectBird.frame.size.height - 20);
    }
}

- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender {
    NSLog(@"Pinched");
    // the user can use the option to pass the tunnels easily as he push the tunnels with the pinch gesture
    if (gameBegan == YES && pushTunnels > 0 && usedPush == NO) {
        [audioPlayerForPushingTunnels play];
        pushTunnels -= 1;
        usedPush = YES;
        self.tunnelTop.center = CGPointMake(self.tunnelTop.center.x, self.tunnelTop.center.y - 20);
        self.tunnelBottom.center = CGPointMake(self.tunnelBottom.center.x, self.tunnelBottom.center.y + 20);
    }
}

- (IBAction)startGame:(id)sender {
    [logoMovement invalidate];
    gameBegan = YES;
    usedCutBird = NO;
    usedPush = NO;
    madeNewHighScore = NO;
    pushTunnels = 3;
    cutBird = 3;
    scoreNumber = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
    
    highScoreNumber = [self getCurrentPersonHighScore];
    
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
        // see if the user has cutBird options left and nullify the BOOL 'usedCutBird'
        if (pushTunnels > 0) {
            usedPush = NO;
        }
        if (usedCutBird == YES) {
            self.objectBird.frame = CGRectMake(self.objectBird.center.x - 10, self.objectBird.center.y - 10, self.objectBird.frame.size.width + 20, self.objectBird.frame.size.height + 20);
        }
        if (cutBird >= 0) {
            usedCutBird = NO;
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
    
    if (highScoreNumber >= scoreNumber || madeNewHighScore == YES) {
        [audioPlayerForPoint play];
    }
    else{
        madeNewHighScore = YES;
        [audioPlayerForNewHighScore play];
    }
}

-(void)gameOver{
    gameBegan = NO;
    [audioPlayerForGameOver play];
    if (scoreNumber > highScoreNumber) {
        [self setCurrentPersonHighScore];
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

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //End game when device is shaked
    if (motion == UIEventSubtypeMotionShake)
    {
        [self gameOver];
    }
}

- (int)getCurrentPersonHighScore{
    if (self.curUser) {
        NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", self.curUser.username];
        [req setPredicate:pred];
        
        CorePlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
        
        int score = [currentCorePlayer.highscore intValue];
        return score;
    }
    else{
        NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CurrentPlayer"];
        
        CurrentPlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
        
        int score = [currentCorePlayer.highscore intValue];
        return score;
    }
}

- (void)setCurrentPersonHighScore{
    NSLog(@"Previous highscore -> %d", highScoreNumber);
    NSLog(@"New highscore -> %d", scoreNumber);
    if (self.curUser) {
        self.curUser.Points = [NSNumber numberWithInt:scoreNumber];
        NSError *err;
        
        [self.curUser save:&err];
        if (err) {
            NSLog(@"%@", err.description);
        }
        
        NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", self.curUser.username];
        [req setPredicate:pred];
        
        CorePlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
        
        currentCorePlayer.highscore = [NSNumber numberWithInt:scoreNumber];
        
        [self.appDelegate.managedObjectContext save:&err];
        
        if (err) {
            NSLog(@"%@", err.description);
        }
    }
    
//    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CurrentPlayer"];
//    
//    CurrentPlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
//    
//    currentCorePlayer.highscore = [NSNumber numberWithInt:scoreNumber];
}

@end

