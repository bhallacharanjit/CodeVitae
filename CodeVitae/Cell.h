//
//  Cell.h
//  CollectionViewExample
//
//  Created by Paul Dakessian on 9/6/12.
//  Copyright (c) 2012 Paul Dakessian, CapTech Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_repoName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_technology;
@property (retain, nonatomic) UILabel* label;
@property (strong, nonatomic) IBOutlet UILabel *lbl_watchers;
@property (strong, nonatomic) IBOutlet UILabel *lbl_openissues;

@end

