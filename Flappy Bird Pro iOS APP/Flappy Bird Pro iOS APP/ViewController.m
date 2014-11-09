//
//  ViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"
#import "CorePlayer.h"
#import "SubscribedPlayer.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController{
    FlappyAngryUser *curUser;
}
//Tsvetan was here

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    CorePlayer *fp1 = [NSEntityDescription insertNewObjectForEntityForName:@"CorePlayer" inManagedObjectContext:appDelegate.managedObjectContext];
//    fp1.highscore = [NSNumber numberWithInt:525];
//    fp1.id = @0;
//    fp1.name = @"Stavri";
//    
//    SubscribedPlayer *fp2 = [NSEntityDescription insertNewObjectForEntityForName:@"SubscribedPlayer" inManagedObjectContext:appDelegate.managedObjectContext];
//    
//    fp2.highscore = [NSNumber numberWithInt:5235];
//    fp2.id = @1;
//    fp2.name = @"Pinko";
//    
//    SubscribedPlayer *fp3 = [NSEntityDescription insertNewObjectForEntityForName:@"SubscribedPlayer" inManagedObjectContext:appDelegate.managedObjectContext];
//    
//    fp3.highscore = [NSNumber numberWithInt:5];
//    fp3.id = @2;
//    fp3.name = @"Dinko";
//    
//    
//    [fp1 addSubscribedPlayersObject:fp2];
//    [fp1 addSubscribedPlayersObject:fp3];
//    
//    [appDelegate.managedObjectContext insertObject:fp1];
//    [appDelegate.managedObjectContext insertObject:fp2];
//    [appDelegate.managedObjectContext insertObject:fp3];
//    
//    NSError *err;
//    [appDelegate.managedObjectContext save:&err];
//    //Do any additional setup after loading the view, typically from a nib.
//    
//    NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", self.curUser.username];
//    [req setPredicate:pred];
//    
//    CorePlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
//    
//    
//    for (CorePlayer *player in fetchedObjects) {
//        NSLog(@"%@m %@, %@", player.name, player.id, player.highscore);
//        
//        for (SubscribedPlayer *sub in player.subscribedPlayers) {
//            NSLog(@"SUB %@ %@", sub.name, sub.highscore);
//        }
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    curUser = [FlappyAngryUser currentUser];
    
    if (curUser) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.loginButton.hidden = YES;
        self.logoutButton.hidden = NO;
        NSLog(@"%@ Current highscore from PARSE", curUser.Points);
    }
    else {
        self.logoutButton.hidden = YES;
        self.loginButton.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnToMain:(UIStoryboardSegue*)segue{
    //We can use this method for "Back" button functionality on the other screens
}

- (IBAction)logout:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully logged out!" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    self.logoutButton.hidden = YES;
    self.loginButton.hidden = NO;
}
@end
