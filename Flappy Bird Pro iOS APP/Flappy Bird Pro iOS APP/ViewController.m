//
//  ViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController
//Tsvetan was here

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *users = [PFObject objectWithClassName:@"Users"];
    users[@"Username"] = @"Antonio";
    users[@"Points"] = @1;
    
    [users saveInBackground];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnToThis:(UIStoryboardSegue*)segue{
    //We can use this method for "Back" button functionality on the other screens
}

@end
