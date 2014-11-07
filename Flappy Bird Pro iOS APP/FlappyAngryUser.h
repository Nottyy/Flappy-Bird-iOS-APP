//
//  FlappyAngryUser.h
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/6/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import <Parse/Parse.h>

@interface FlappyAngryUser : PFUser<PFSubclassing>

+(FlappyAngryUser*)currentUser;

@property (nonatomic, strong) NSNumber *Points;
@property (nonatomic, strong) PFFile *Avatar;

@end
