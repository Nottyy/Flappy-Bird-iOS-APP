//
//  AppDelegate.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIBackgroundTaskIdentifier backgroundTask;
    NSTimer *checkingSubscribedPlayersScores;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *currentPlayeName;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTask;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

