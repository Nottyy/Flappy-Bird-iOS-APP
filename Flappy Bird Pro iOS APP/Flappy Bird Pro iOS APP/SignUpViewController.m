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
#import "Reachability.h"
#import "AppDelegate.h"
#import "CorePlayer.h"

@interface SignUpViewController ()
@property (nonatomic, strong) UIImage *imageTaken;

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
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        
        if (netStatus == NotReachable) {
            [self.hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet access" message:@"Signing up cancelled" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else{
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.labelText = @"Please wait";
            
            FlappyAngryUser *user = [FlappyAngryUser new];
            user.username = _usernameTextField.text;
            user.password = _passwordTextField.text;
            user.Points = [NSNumber numberWithInt:0];
            
            //if the user uploads a photo
            if (self.imageTaken) {
                NSData *imageData = UIImageJPEGRepresentation(self.imageTaken, 0.05f);
                PFFile *userAvatar = [PFFile fileWithName:[NSString stringWithFormat:@"%@ avatar", _usernameTextField.text] data: imageData];
                user.Avatar = userAvatar;
            }
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    if (error == nil){
                        [self.hud hide:YES];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully registered!" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                        
                        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                        
                        CorePlayer *player = [NSEntityDescription insertNewObjectForEntityForName:@"CorePlayer" inManagedObjectContext:appDelegate.managedObjectContext];
                        player.highscore = [NSNumber numberWithInt:0];
                        player.name = _usernameTextField.text;
                        
                        [appDelegate.managedObjectContext insertObject:player];
                        
                        NSError *err;
                        [appDelegate.managedObjectContext save:&err];
                        if (err) {
                            NSLog(@"%@", err.description);
                        }
                        else{
                            NSLog(@"Saved to core Data");
                        }
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
}

- (IBAction)photoFromGallery:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)photoFromCamera:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The device has no camera" message:@"Skip it or upload an avatar from your gallery" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

//from here we get the image
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *imgAfterUpload = info[UIImagePickerControllerEditedImage];
    
    //resizing the image to 200x200
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [imgAfterUpload drawInRect:CGRectMake(0, 0, 200, 200)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageTaken = smallImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//if the user press the cancel button while taking a picture
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
