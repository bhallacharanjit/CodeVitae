//
//  CVAppManager.h
//  CodeVitae
//
//  Created by CSB on 22/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVAppManager : NSObject
@property (nonatomic , retain ) NSMutableArray * githubArray;
@property (nonatomic , retain ) NSMutableDictionary * githubUserDetails;

+ (id)sharedManager;


//setting the user details
-(void)setGithubuserDetails:(NSMutableDictionary *)githubthings;
-(NSMutableDictionary *)getgithubuserDetails;


//setting the user repo details
-(void)setGithubDetails:(NSMutableArray *)githubthings;
-(NSMutableArray *)getgithubDetails;




@end
