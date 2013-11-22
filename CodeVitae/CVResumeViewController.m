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

@interface CVResumeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *user_image;
@property (strong, nonatomic) IBOutlet UILabel *user_email;
@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UILabel *user_organization;

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
    
    
    [cell.lbl_openissues setText:[NSString stringWithFormat:@"Open Issues: %d",[[dict_temp objectForKey:@"open_issues_count"] intValue]]];
    
    return cell;
}



@end
