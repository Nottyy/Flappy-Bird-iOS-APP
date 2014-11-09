//
//  UILeaderboardViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "UILeaderboardViewController.h"
#import "UILeaderboardCell.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "CorePlayer.h"
#import "SubscribedPlayer.h"

@interface UILeaderboardViewController ()

@property (nonatomic, strong) NSMutableArray *people;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (strong, nonatomic) FlappyAngryUser* curUser;
@property (strong, nonatomic) SubscribedPlayer* currentClickedPlayer;

@end

@implementation UILeaderboardViewController{
}

NSString *leaderBoardCell = @"LeaderboardTableViewCell";

-(instancetype)init{
    self = [super init];
    if (self) {
        self.people = [NSMutableArray array];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.people = [NSMutableArray array];
    }
    
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.people = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leaderboardTableView setDataSource:self];
    UINib *nib = [UINib nibWithNibName:leaderBoardCell bundle:nil];
    [self.leaderboardTableView registerNib:nib forCellReuseIdentifier: leaderBoardCell];
    
    UILongPressGestureRecognizer *lgpr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    lgpr.minimumPressDuration = 1.0;
    
    [self.leaderboardTableView addGestureRecognizer:lgpr];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.curUser = [FlappyAngryUser currentUser];
}

-(void)handleLongPress:(UILongPressGestureRecognizer*) sender{
    CGPoint pointClicked = [sender locationInView:self.leaderboardTableView];
    NSIndexPath *indexPath = [self.leaderboardTableView indexPathForRowAtPoint:pointClicked];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentClickedPlayer = [NSEntityDescription insertNewObjectForEntityForName:@"SubscribedPlayer" inManagedObjectContext:self.appDelegate.managedObjectContext];
        
        self.currentClickedPlayer.highscore = [self.people[indexPath.row] Points];
        self.currentClickedPlayer.name = [self.people[indexPath.row] username];
        
        NSString *subscribedPlayerName = self.currentClickedPlayer.name;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Are you sure you want to subscribe to %@?", subscribedPlayerName] message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Ok", nil];
        alert.tag = 10;
        [alert show];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet access" message:@"You won't be able to view the leaderboard" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
        self.userName.hidden = YES;
        self.userHighScore.hidden = YES;
        self.userAvatar.hidden = YES;
        self.leaderboardTableView.hidden = YES;
    }
    else{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"Loading Leaderboard...";
        
        PFQuery *query = [FlappyAngryUser query];
        [query orderByDescending:@"Points"];
        NSArray *users = [query findObjects];
        self.people = [NSMutableArray arrayWithArray:users];
        
        [self.hud hide:YES];
        
        //populating current user labels and avatar
        FlappyAngryUser *currentUser = [FlappyAngryUser currentUser];
        if (currentUser) {
            self.userName.text = [NSString stringWithFormat:@"User -> %@", currentUser.username];
            NSNumber *points = currentUser.Points;
            NSString *pointsAsStr = [NSString stringWithFormat:@"%@", points];
            self.userHighScore.text = [NSString stringWithFormat:@"Highscore -> %@", pointsAsStr];
            
            PFImageView *userAvatar = [PFImageView new];
            userAvatar.file = currentUser.Avatar;
            
            [userAvatar loadInBackground: ^(UIImage* image, NSError *error)
             {
                 if (image != nil) {
                     self.userAvatar.image = image;
                 }
                 else{
                     self.userAvatar.image = [UIImage imageNamed:@"emptyAvatar.jpeg"];
                 }
                 
             }];
        }
        else{
            self.userName.text = @"Not logged";
            self.userHighScore.text = @"-";
            self.userAvatar.image = [UIImage imageNamed:@"emptyAvatar.jpeg"];
        }
    }
}

- (void)subscribeConfirmation:(CorePlayer *)currentCorePlayer contained:(BOOL)contained curPlayerName:(NSString *)curPlayerName {
    if ([self.currentClickedPlayer.name isEqualToString:curPlayerName]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You cannnot subscribe to yourself" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(contained){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You have already subscribed to %@", self.currentClickedPlayer.name] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    else{
        [currentCorePlayer addSubscribedPlayersObject:self.currentClickedPlayer];
        
        NSError *err;
        [self.appDelegate.managedObjectContext save:&err];
        
        if (err) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:err.description message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Successfully subscribed to %@", self.currentClickedPlayer.name] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            
            NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", self.curUser.username];
            [req setPredicate:pred];
            
            CorePlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
            
            
            NSString *curPlayerName = currentCorePlayer.name;
            
            BOOL contained = NO;
            for (SubscribedPlayer* pl in currentCorePlayer.subscribedPlayers) {
                if ([pl.name isEqualToString:self.currentClickedPlayer.name]) {
                    contained = YES;
                }
            }
            
            [self subscribeConfirmation:currentCorePlayer contained:contained curPlayerName:curPlayerName];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _people.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILeaderboardCell *cell = [self.leaderboardTableView dequeueReusableCellWithIdentifier: leaderBoardCell];
    
    // set player name and score labels
    cell.playerName.text = [_people[indexPath.row] username];
    NSNumber *points = [_people[indexPath.row] Points];
    NSString *pointsAsStr = [NSString stringWithFormat:@"%@", points];
    cell.playerScore.text = pointsAsStr;
    
    // retrieve user avatar and set it to the image view
    PFImageView *userAvatar = [PFImageView new];
    userAvatar.file = [_people[indexPath.row] Avatar];
    
    [userAvatar loadInBackground: ^(UIImage* image, NSError *error)
     {
         if (image != nil) {
             cell.playerAvatar.image = image;
         }
         else{
             cell.playerAvatar.image = [UIImage imageNamed:@"emptyAvatar.jpeg"];
         }
     }];
    return cell;
}

@end
