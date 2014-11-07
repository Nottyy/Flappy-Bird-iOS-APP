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

@interface UILeaderboardViewController ()

@property (nonatomic, strong) NSMutableArray *people;

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
    
    //self.leaderboardTableView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading Leaderboard...";
    
    PFQuery *query = [FlappyAngryUser query];
    [query orderByDescending:@"Points"];
    NSArray *users = [query findObjects];
    self.people = [NSMutableArray arrayWithArray:users];
    
    [self.hud hide:YES];
    
    FlappyAngryUser *currentUser = [FlappyAngryUser currentUser];
    if (currentUser) {
        self.userName.text = [NSString stringWithFormat:@"Username -> %@", currentUser.username];
        NSNumber *points = currentUser.Points;
        NSString *pointsAsStr = [NSString stringWithFormat:@"%@", points];
        self.userHighScore.text = [NSString stringWithFormat:@"Highscore -> %@", pointsAsStr];
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
        cell.playerAvatar.image = image;
    }];
    return cell;
}

@end
