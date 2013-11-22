//
//  CVViewController.m
//  CodeVitae
//
//  Created by Charanjit Singh Bhalla on 19/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import "CVViewController.h"
#import "CVResumeViewController.h"
#import "CVAppManager.h"

@interface CVViewController ()

@end

@implementation CVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)callGithubForBasicDetails {
   
    
    
    
    NSString * connectionString = [NSString stringWithFormat:@"https://api.github.com/users/%@?client_id=675931ac7d05f93d269d&client_secret=078953d185b6a72de647db18274343b66fa965cd",self.usernametext.text];
    NSURL* requestUrl = [[NSURL alloc] initWithString:connectionString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *err) {
        //NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError * e;
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
        NSLog(@"RESPONSE %@",jsonDict);
        
        //        NSMutableString * allrepos=[[NSMutableString alloc] init];
        //        for (int i=0; i<jsonArray.count; i++) {
        //            [allrepos appendFormat:@",%@",[[jsonArray objectAtIndex:i] objectForKey:@"full_name"]];
        //        }
        
        if (e==nil) {
            [[CVAppManager sharedManager] setGithubUserDetails:jsonDict];
        }
        else{
            NSLog(@"%@",e);
        }
        
        
        
        [self CallGithubforRepos];
        
        
        
        //        [[[UIAlertView alloc] initWithTitle:allrepos message:@"" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];

    
    
    
    
}


-(void)CallGithubforRepos
{
    
    NSString * connectionString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos?client_id=675931ac7d05f93d269d&client_secret=078953d185b6a72de647db18274343b66fa965cd",self.usernametext.text];
    NSURL* requestUrl = [[NSURL alloc] initWithString:connectionString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *err) {
        //NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError * e;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
        NSLog(@"RESPONSE %@",jsonArray);
        
//        NSMutableString * allrepos=[[NSMutableString alloc] init];
//        for (int i=0; i<jsonArray.count; i++) {
//            [allrepos appendFormat:@",%@",[[jsonArray objectAtIndex:i] objectForKey:@"full_name"]];
//        }
        
        [[CVAppManager sharedManager] setGithubArray:jsonArray];
        
        

        CVResumeViewController * resume = [self.storyboard instantiateViewControllerWithIdentifier:@"resumecontroller"];
        [self.navigationController pushViewController:resume animated:YES];
        
        
        
        
        
//        [[[UIAlertView alloc] initWithTitle:allrepos message:@"" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];
}


- (IBAction)FindMe:(id)sender {
    [self callGithubForBasicDetails];
}
@end
