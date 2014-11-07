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

@interface SignUpViewController : UIViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet TKUITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet TKUITextField *displayNameTextField;
@property (weak, nonatomic) IBOutlet TKUITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)signUp:(id)sender;
- (IBAction)photoFromGallery:(UIButton *)sender;
- (IBAction)photoFromCamera:(UIButton *)sender;

@property (nonatomic, strong) MBProgressHUD *hud;

@end
