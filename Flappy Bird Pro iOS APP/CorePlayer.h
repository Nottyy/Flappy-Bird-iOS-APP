//
//  CorePlayer.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/8/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SubscribedPlayer;

@interface CorePlayer : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * highscore;
@property (nonatomic, retain) NSSet *subscribedPlayers;
@end

@interface CorePlayer (CoreDataGeneratedAccessors)

- (void)addSubscribedPlayersObject:(SubscribedPlayer *)value;
- (void)removeSubscribedPlayersObject:(SubscribedPlayer *)value;
- (void)addSubscribedPlayers:(NSSet *)values;
- (void)removeSubscribedPlayers:(NSSet *)values;

@end
