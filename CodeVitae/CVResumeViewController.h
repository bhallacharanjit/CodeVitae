//
//  CVResumeViewController.h
//  CodeVitae
//
//  Created by Charanjit Singh Bhalla on 21/11/13.
//  Copyright (c) 2013 com.VP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVResumeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) NSArray * githubArray;
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;

@end
