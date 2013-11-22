//
//  CVDetailViewController.m
//  CodeVitae
//
//  Created by CSB on 23/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import "CVDetailViewController.h"

@interface CVDetailViewController ()


@end

@implementation CVDetailViewController
@synthesize readmeText;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)removeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
