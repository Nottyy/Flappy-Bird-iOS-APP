//
//  UILeaderboardViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILeaderboardViewController : UIViewController<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leaderboardTableView;
@property (weak, nonatomic) IBOutlet UILabel *leaderboardLabel;

@end
