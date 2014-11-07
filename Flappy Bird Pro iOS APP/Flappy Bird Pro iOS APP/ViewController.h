//
//  ViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)logout:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;


@end

