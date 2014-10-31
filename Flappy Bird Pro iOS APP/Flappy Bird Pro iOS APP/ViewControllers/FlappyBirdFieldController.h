//
//  FlappyBirdFieldController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>

int birdFlight;

@interface FlappyBirdFieldController : UIViewController{
    NSTimer *birdMovement;
}

@property (weak, nonatomic) IBOutlet UIImageView *objectBird;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartGame;

- (IBAction)startGame:(id)sender;

- (void)birdMoving;
@end
