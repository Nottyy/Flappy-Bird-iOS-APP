//
//  FlappyAngryUser.m
//  Flappy Bird Pro iOS APP
//
//  Created by Antonio on 11/6/14.
//  Copyright (c) 2014 Antonio Marinov. All rights reserved.
//

#import "FlappyAngryUser.h"

@implementation FlappyAngryUser
@dynamic Points;
@dynamic Avatar;

+(FlappyAngryUser *)currentUser{
    return (FlappyAngryUser *)[PFUser currentUser];
}

@end
