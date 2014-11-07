//
//  SignUpViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.registerButton.text = @"Register";
    //self.registerButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //Picture logic
}

- (IBAction)signUp:(id)sender {
    if ([sender isEqual:self.signUpButton]){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"Please wait";
        
        FlappyAngryUser *user = [FlappyAngryUser new];
        user.username = _usernameTextField.text;
        user.password = _passwordTextField.text;
        user.Points = [NSNumber numberWithInt:0];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if (error == nil){
                    [self.hud hide:YES];
                    NSLog(@"Rsegistered");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully registered!" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    [alert show];
                    //[self performSegueWithIdentifier:@"" sender:self];
                    
                }
                else{
                    [self.hud hide:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
            }
            else{
                NSLog(@"%@", error);
            }
        }];
    }
}
@end
