//
//  SignUpViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "SignUpViewController.h"
#import <EverliveSDK/EverliveSDK.h>
#import "FlappyBirdUser.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.text = @"Register";
    //self.registerButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //Picture logic
}

- (void)buttonClicked:(id)sender
{
    if ([sender isEqual:self.registerButton]){
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"Please wait";
        
        FlappyBirdUser *newUser = [[FlappyBirdUser alloc]init];
        
        [newUser setUsername: _userName.text];
        [newUser setPassword: _password.text];
        [newUser setDisplayName: _name.text];
        //picture logic
        
        [newUser signUp:^(EVUser *user, NSError *error) {
            if (error == nil){
                [self.hud hide:YES];
                [EVUser loginInWithUsername:user.username password: _password.text block:^(EVUser *user, NSError *error) {
                    //[self performSegueWithIdentifier:@"" sender:self];
                }];
            }
            else{
                [self.hud hide:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
