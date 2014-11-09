//
//  UISubscribedPlayersViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/8/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "UISubscribedPlayersViewController.h"
#import "AppDelegate.h"
#import "CorePlayer.h"
#import "SubscribedPlayer.h"
#import "FlappyAngryUser.h"
#import "UISubscribedPlayersCellTableViewCell.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface UISubscribedPlayersViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) FlappyAngryUser *curUser;
@property (nonatomic, strong) NSMutableArray *subscribedUsers;

@end

@implementation UISubscribedPlayersViewController

NSString *subscribedPlayersCell = @"SubscribedPlayersTableViewCell";

-(instancetype)init{
    self = [super init];
    if (self) {
        self.subscribedUsers = [NSMutableArray array];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.subscribedUsers = [NSMutableArray array];
    }
    
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.subscribedUsers = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.subscribedPlayersTableView setDataSource:self];
    UINib *nib = [UINib nibWithNibName:subscribedPlayersCell bundle:nil];
    [self.subscribedPlayersTableView registerNib:nib forCellReuseIdentifier: subscribedPlayersCell];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.curUser = [FlappyAngryUser currentUser];
}

-(void)viewWillAppear:(BOOL)animated{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading Subscribed Players...";
    
    if (self.curUser) {
        NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", self.curUser.username];
        [req setPredicate:pred];
        
        CorePlayer *currentCorePlayer = [[self.appDelegate.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
        NSArray *convertedPlayers = [currentCorePlayer.subscribedPlayers allObjects];
        self.subscribedUsers = [NSMutableArray arrayWithArray: convertedPlayers];
        
        self.subscribedPlayersLabel.text = [NSString stringWithFormat:@"%@'s Subscribed Players", self.curUser.username];
    }
    
    [self.hud hide:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subscribedUsers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UISubscribedPlayersCellTableViewCell *cell = [self.subscribedPlayersTableView dequeueReusableCellWithIdentifier: subscribedPlayersCell];
    
    // set player name and score labels
    cell.usernameTextField.text = [self.subscribedUsers[indexPath.row] name];
    NSNumber *points = [self.subscribedUsers[indexPath.row] highscore];
    NSString *pointsAsStr = [NSString stringWithFormat:@"%@", points];
    cell.highscoreTextField.text = pointsAsStr;
    
    return cell;
}

@end
