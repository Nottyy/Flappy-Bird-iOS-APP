//
//  LoginViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/3/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"
#import "Reachability.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    if ([sender isEqual:self.loginButton]){
        if([_usernameTextField validate] && [_passwordTextField validate]){
            
            Reachability *reachability = [Reachability reachabilityForInternetConnection];
            NetworkStatus netStatus = [reachability currentReachabilityStatus];
            
            if (netStatus == NotReachable) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet access" message:@"Login cancelled" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            else{
                self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                self.hud.labelText = @"Please wait";
                
                [PFUser logInWithUsernameInBackground:_usernameTextField.text password:_passwordTextField.text  block:^(PFUser *user, NSError *error){
                    
                    [self.hud hide:YES];
                    if (user) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"Successfully logged as '%@'!", user.username] message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                    }
                }];
            }
            
        }
    }
}

-(IBAction)returnToLogin:(UIStoryboardSegue*)segue{
    NSLog(@"Login");
    //We can use this method for "Back" button functionality on the other screens
}

@end
