//
//  CVResumeViewController.m
//  CodeVitae
//
//  Created by Charanjit Singh Bhalla on 21/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import "CVResumeViewController.h"
#import "Cell.h"
#import "CVAppManager.h"
#import "UIImageView+WebCache.h"
#import "CVDetailViewController.h"
#import "NSData+Base64.h"

@interface CVResumeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *user_image;
@property (strong, nonatomic) IBOutlet UILabel *user_email;
@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UILabel *user_organization;
@property (strong, nonatomic) IBOutlet UIButton *btn_followers;
@property (strong, nonatomic) IBOutlet UIButton *btn_following;

@end

@implementation CVResumeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
//    //getting the data from the github array
//    if ([[[CVAppManager sharedManager] getgithubDetails] count]>0)
//    {
//        NSURL * url = [NSURL URLWithString:[[[[[CVAppManager sharedManager] getgithubDetails] objectAtIndex:0] objectForKey:@"owner"] objectForKey:@"avatar_url"]];
//        NSLog(@" this is it %@",[[[[[CVAppManager sharedManager] getgithubDetails] objectAtIndex:0] objectForKey:@"owner"] objectForKey:@"avatar_url"]);
//        [self.user_image setImageWithURL:url placeholderImage:nil];
//    }
    
    
    NSMutableDictionary * dict = [[CVAppManager sharedManager]  getgithubuserDetails];
    
    if (![[dict objectForKey:@"avatar_url"] isKindOfClass:[NSNull class]]) {
        [self.user_image setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"avatar_url"]] placeholderImage:nil];
        [self.user_image.layer setMasksToBounds:YES];
        [self.user_image.layer setCornerRadius:self.user_image.frame.size.height/1.9];
        
    }
    if (![[dict objectForKey:@"email"] isKindOfClass:[NSNull class]] && [dict valueForKey:@"email"]) {
        [self.user_email setText:[dict objectForKey:@"email"]];
    }
    else
    {
        [self.user_email setText:@""];
    }
    if (![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]] && [dict valueForKey:@"name"]) {
        [self.user_name setText:[dict objectForKey:@"name"]];
    }
    else
    {
        [self.user_name setText:[dict objectForKey:@"login"]];
    }
    if (![[dict objectForKey:@"company"] isKindOfClass:[NSNull class]] && [dict valueForKey:@"company"]) {
        [self.user_organization setText:[dict objectForKey:@"company"]];
    }
    else
    {
        [self.user_organization setText:@""];
    }
    
    
    [self.btn_followers setTitle:[NSString stringWithFormat:@"Followers (%d)",[[dict objectForKey:@"followers"] intValue]] forState:UIControlStateNormal];
    
    
    [self.btn_following setTitle:[NSString stringWithFormat:@"Following (%d)",[[dict objectForKey:@"following"] intValue]] forState:UIControlStateNormal];
    
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //getting the bar button hidden
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark CollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [[[CVAppManager sharedManager] getgithubDetails] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    NSDictionary * dict_temp = [[[CVAppManager sharedManager] getgithubDetails] objectAtIndex:indexPath.item];
    NSLog(@"%@",[dict_temp objectForKey:@"name"]);
    
    cell.lbl_repoName.text = [NSString stringWithFormat:@"%@",[dict_temp objectForKey:@"name"]];
    
    if (![[dict_temp valueForKey:@"language"] isKindOfClass:[NSNull class]]) {
        cell.lbl_technology.text = [NSString stringWithFormat:@"%@",[dict_temp objectForKey:@"language"]];
    }
    
    [cell.lbl_watchers setText:[NSString stringWithFormat:@"watchers:%d",[[dict_temp objectForKey:@"watchers"] intValue]]];
    
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.borderWidth = 1.0f;
    
    [cell.lbl_openissues setText:[NSString stringWithFormat:@"Open Issues: %d",[[dict_temp objectForKey:@"open_issues_count"] intValue]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.item);
    //UIViewController * controller_view = [[UIViewController alloc] init]
    //UIPopoverController * controller = [[UIPopoverController alloc] initWithContentViewController:<#(UIViewController *)#>]
    
    NSDictionary * dict_temp = [[[CVAppManager sharedManager] getgithubDetails] objectAtIndex:indexPath.item];
    NSLog(@"%@",dict_temp);
    
    
    [self GetReadMeFile:[[dict_temp objectForKey:@"owner"] objectForKey:@"login"] andRepo:[dict_temp objectForKey:@"name"]];
    
    
    
    
    
}


-(void)GetReadMeFile:(NSString *)login andRepo:(NSString *)repo {
    NSString * connectionString = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/readme?client_id=675931ac7d05f93d269d&client_secret=078953d185b6a72de647db18274343b66fa965cd",login,repo];
    NSURL* requestUrl = [[NSURL alloc] initWithString:connectionString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *err) {
        NSError * e;
        NSMutableDictionary *jsondict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &e];
        NSLog(@"RESPONSE %@ error %@",[jsondict objectForKey:@"content"],e);
        
        NSString * str =[jsondict objectForKey:@"content"];
        NSData *data1 = [NSData dataFromBase64String:str];
        NSString *convertedString = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSLog(@"Commit data %@",convertedString);
        
        //        NSMutableString * allrepos=[[NSMutableString alloc] init];
        //        for (int i=0; i<jsonArray.count; i++) {
        //            [allrepos appendFormat:@",%@",[[jsonArray objectAtIndex:i] objectForKey:@"full_name"]];
        //        }
       
        
        CVDetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
        
        [detail setModalPresentationStyle:UIModalPresentationFormSheet];
        

        
        [self presentViewController:detail animated:YES completion:^{
            [[detail readmeText] setText:convertedString];
        }];
        
        
        
        
        //        [[[UIAlertView alloc] initWithTitle:allrepos message:@"" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];

}


- (IBAction)FollowersView:(id)sender {
}
- (IBAction)FollowingView:(id)sender {
}

@end
