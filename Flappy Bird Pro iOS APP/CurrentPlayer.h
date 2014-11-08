//
//  CurrentPlayer.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/8/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CurrentPlayer : NSManagedObject

@property (nonatomic, retain) NSNumber * highscore;
@property (nonatomic, retain) NSString * name;

@end
