//
//  LoginViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/3/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKUIButton.h"
#import "TKUITextField.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet TKUITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet TKUITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)login:(id)sender;

@end
