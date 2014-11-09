//
//  AppDelegate.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 10/30/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "FlappyAngryUser.h"
#import "CorePlayer.h"
#import "SubscribedPlayer.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize backgroundTask;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FlappyAngryUser registerSubclass];
    [Parse setApplicationId:@"FPaH3syB3HrqAecdxFl4A5XfhqCGsn8dv1PmoqhB"
                  clientKey:@"dBOIQIdufD0GVNpMij8slmQ2JZtEPzxw8RFEZadh"];
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    
    NSLog(@"GONE IN BACKGROUND");
    
    [self.managedObjectContext save:nil];
    backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:backgroundTask];
        
        backgroundTask = UIBackgroundTaskInvalid;
    }];
    
    checkingSubscribedPlayersScores = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(chekingSubscribedPlayersHighScores) userInfo:nil repeats:YES];
}

-(void)chekingSubscribedPlayersHighScores{
    FlappyAngryUser *currentPlayer = [FlappyAngryUser currentUser];
    if (currentPlayer) {
        NSFetchRequest * req = [NSFetchRequest fetchRequestWithEntityName:@"CorePlayer"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", currentPlayer.username];
        [req setPredicate:pred];
        
        CorePlayer *currentCorePlayer = [[self.managedObjectContext executeFetchRequest:req error:nil] objectAtIndex:0];
        
        if (currentCorePlayer.subscribedPlayers.count > 0) {
            int currentPlayerScore = [currentCorePlayer.highscore intValue];
            
            for (SubscribedPlayer *subcribedPlayer in currentCorePlayer.subscribedPlayers) {
                
                NSString *subscribedPlayerName = subcribedPlayer.name;
                PFQuery *quer = [PFUser query];
                [quer whereKey:@"username" equalTo:subscribedPlayerName];
                NSArray *objects = [quer findObjects];
                
                if (objects.count == 1) {
                    subcribedPlayer.highscore = [objects[0] Points];
                    
                    int currentSubscribedPlayerHighScore = [subcribedPlayer.highscore intValue];
                    
                    if (currentSubscribedPlayerHighScore > currentPlayerScore && [subcribedPlayer.checked isEqualToNumber: @0]) {
                        subcribedPlayer.checked = [NSNumber numberWithBool:YES];
                        
                        NSLog(@"SUCCESSSSSSSSSS");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ beats your highscore", subcribedPlayer.name] message:[NSString stringWithFormat:@"Hold on...%@ points.. Can you beat that?", subcribedPlayer.highscore] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                        
                        [self.managedObjectContext save:nil];
                    }
                }
                else{
                    NSLog(@"ERROORR");
                }
            }
            
            [self.managedObjectContext save:nil];
        }
    }
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    [checkingSubscribedPlayersScores invalidate];
    
    [application endBackgroundTask:backgroundTask];
    
    backgroundTask = UIBackgroundTaskInvalid;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    return true;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "fpbpia.Flappy_Bird_Pro_iOS_APP" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataPlayers" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataPlayers.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
