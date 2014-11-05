//
//  ViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "ViewController.h"
#import <EverliveSDK/EverliveSDK.h>
#import "FlappyBirdUser.h"

@interface ViewController ()

@end

@implementation ViewController
//Tsvetan was here

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FlappyBirdUser *newUser = [[FlappyBirdUser alloc]init];
    
    
    [newUser setUsername: @"Panssadssakdasdooasdeo"];
    [newUser setPassword: @"123456"];
    [newUser setDisplayName: @"pansasdsadaskasdotdoo"];
    [newUser setPoints: [NSNumber numberWithInt: 5]];
    
    [newUser signUp:^(EVUser *user, NSError *error) {
        //NSLog(@"%@", error.description);
        //NSLog(@"%@", user.displayName);
        //NSLog(@"%@", user);
       if (error == nil){
           NSLog(@"Success");
       }
       else{
           
//           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:error.domain delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
           //[alert show];
       }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnToThis:(UIStoryboardSegue*)segue{
    //We can use this method for "Back" button functionality on the other screens
}

@end
