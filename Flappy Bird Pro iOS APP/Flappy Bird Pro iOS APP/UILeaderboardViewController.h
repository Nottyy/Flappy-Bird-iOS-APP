//
//  UILeaderboardViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UILeaderboardViewController : UIViewController<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leaderboardTableView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHighScore;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
