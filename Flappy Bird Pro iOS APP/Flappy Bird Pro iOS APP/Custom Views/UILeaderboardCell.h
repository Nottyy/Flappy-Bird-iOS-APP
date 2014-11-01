//
//  UILeaderboardTableViewCellLogicTableViewCell.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/1/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILeaderboardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;

@end
