//
//  UISubscribedPlayersViewController.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/8/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UISubscribedPlayersViewController : UIViewController<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *subscribedPlayersTableView;
@property (weak, nonatomic) IBOutlet UILabel *subscribedPlayersLabel;
@property (nonatomic, strong) MBProgressHUD *hud;

@end
