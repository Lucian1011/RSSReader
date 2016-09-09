//
//  selectViewController.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property NSString *reuseIdentifier;
@property UITableView *selectTableView;
//源种类列表
//所有列表
@property NSMutableArray *allCategoryList;
//用户订阅列表
@property NSMutableArray *userCategoryList;
//选中状态数组
//@property NSMutableArray *isSelected;
//选中状态

@end
