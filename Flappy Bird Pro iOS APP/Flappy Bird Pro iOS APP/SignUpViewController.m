//
//  SignUpViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "SignUpViewController.h"

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
        
//        FlappyBirdUser *newUser = [[FlappyBirdUser alloc]init];
//        
//        [newUser setUsername: _usernameTextField.text];
//        [newUser setPassword: _passwordTextField.text];
//        [newUser setDisplayName: _displayNameTextField.text];
//        [newUser setPoints: [NSNumber numberWithInt: 0]];
//        //picture logic
//        
//        
//        [newUser signUp:^(EVUser *user, NSError *error) {
//            if (error == nil){
//                [self.hud hide:YES];
//                 NSLog(@"Rsegistered");
//                [EVUser loginInWithUsername:user.username password: _passwordTextField.text block:^(EVUser *user, NSError *error) {
//                    NSLog(@"Registered");
//                    //[self performSegueWithIdentifier:@"" sender:self];
//                }];
//            }
//            else{
//                [self.hud hide:YES];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//                [alert show];
//            }
//        }];
    }
}
@end
