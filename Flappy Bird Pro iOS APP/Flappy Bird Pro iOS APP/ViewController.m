//
//  ViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"

@interface ViewController ()

@end

@implementation ViewController{
    FlappyAngryUser *curUser;
}
//Tsvetan was here

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    curUser = [FlappyAngryUser currentUser];
    
    if (curUser) {
        self.loginButton.hidden = YES;
        self.logoutButton.hidden = NO;
    }
    else {
        self.logoutButton.hidden = YES;
        self.loginButton.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnToMain:(UIStoryboardSegue*)segue{
    //We can use this method for "Back" button functionality on the other screens
}

- (IBAction)logout:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully logged out!" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    self.logoutButton.hidden = YES;
    self.loginButton.hidden = NO;
}
@end
