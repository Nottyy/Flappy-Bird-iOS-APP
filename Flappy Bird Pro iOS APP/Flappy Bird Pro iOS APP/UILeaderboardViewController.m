//
//  UILeaderboardViewController.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "UILeaderboardViewController.h"
#import "UILeaderboardCell.h"

@interface UILeaderboardViewController ()

@end

@implementation UILeaderboardViewController
{
    NSArray *names;
    NSArray *scores;
}
NSString *leaderBoardCell = @"LeaderboardTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    names = [NSArray arrayWithObjects: @"Gosho", @"Stamen",nil];
    scores = [NSArray arrayWithObjects: @"5", @"5", nil];
    [self.leaderboardTableView setDataSource:self];
    //self.leaderboardTableView.hidden = YES;
    // Do any additional setup after loading the view.
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
