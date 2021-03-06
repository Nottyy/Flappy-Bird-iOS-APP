//
//  SubscribedPlayer.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/8/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SubscribedPlayer : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * highscore;
@property (nonatomic, retain) NSNumber * checked;
@property (nonatomic, retain) NSManagedObject *corePlayer;

@end
