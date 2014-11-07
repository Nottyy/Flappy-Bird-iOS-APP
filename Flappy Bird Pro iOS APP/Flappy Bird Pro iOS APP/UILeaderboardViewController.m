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

@interface UILeaderboardViewController ()

@property (nonatomic, strong) NSMutableArray *people;
@end

@implementation UILeaderboardViewController
{
    NSMutableArray *people;
    NSArray *names;
    NSArray *scores;
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
    
    
//    names = [NSArray arrayWithObjects: @"Gosho", @"Stamen",nil];
//    scores = [NSArray arrayWithObjects: @"5", @"5", nil];
    
    
    
    //self.leaderboardTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILeaderboardCell *cell = [self.leaderboardTableView dequeueReusableCellWithIdentifier: leaderBoardCell];
    
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:leaderBoardCell bundle:nil];
        [self.leaderboardTableView registerNib:nib forCellReuseIdentifier: leaderBoardCell];
        cell = [self.leaderboardTableView dequeueReusableCellWithIdentifier: leaderBoardCell];
        //cell = [[UILeaderboardCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //cell.textLabel.text = names[indexPath.row];
    cell.playerName.text = names[indexPath.row];
    cell.playerScore.text = scores[indexPath.row];
    
    return cell;
}

-(IBAction)returnToThis: (UIStoryboardSegue*)segue{
    
}

@end
