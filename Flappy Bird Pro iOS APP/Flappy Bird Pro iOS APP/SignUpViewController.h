//
//  SignUpViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKUIButton.h"
#import "TKUITextField.h"
#import "MBProgressHUD.h"

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet TKUITextField *userName;

@property (weak, nonatomic) IBOutlet TKUITextField *name;

@property (weak, nonatomic) IBOutlet TKUITextField *password;

@property (weak, nonatomic) IBOutlet TKUIButton *registerButton;

@property (nonatomic, strong) MBProgressHUD *hud;

@end
