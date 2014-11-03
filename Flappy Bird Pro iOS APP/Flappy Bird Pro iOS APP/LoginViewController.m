//
//  LoginViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/3/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "LoginViewController.h"
#import <EverliveSDK/EverliveSDK.h>

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
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"Please wait";
            
            [EVUser loginInWithUsername:_usernameTextField.text password:_passwordTextField.text block:^(EVUser *user, NSError *error) {
                [self loginUser:user error:error];
            }];
        }
    }
}

- (void)loginUser:(EVUser*)user error:(NSError*)error
{
    [self.hud hide:YES];
    
    if (error == nil && [user isAuthenticated]){
//        [self.navigationItem setTitle:@"Log out"];
//        [self performSegueWithIdentifier:@"ShowActivities" sender:self];
        NSLog(@"User logged");
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}


@end
