//
//  homePageViewController.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homePageViewController : UIViewController

@property UICollectionView *mainCollecionView;
@property NSString *reuesIdentifier;
//源种类列表
@property NSMutableArray *categoryList;
@end
