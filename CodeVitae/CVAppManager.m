//
//  CVAppManager.m
//  CodeVitae
//
//  Created by CSB on 22/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import "CVAppManager.h"

@implementation CVAppManager
@synthesize githubArray;



+ (id)sharedManager {
    static CVAppManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}




//getter setter for github array
-(void)setGithubDetails:(NSMutableArray *)githubthings {
    self.githubArray = githubthings;
}
-(NSMutableArray *)getgithubDetails {
    return self.githubArray;
}


//getter setter for github array
-(void)setGithubuserDetails:(NSMutableDictionary *)githubthings {
    self.githubUserDetails = githubthings;
}
-(NSMutableDictionary *)getgithubuserDetails {
    return self.githubUserDetails;
}


@end
