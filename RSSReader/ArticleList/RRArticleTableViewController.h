//
//  RRArticleTableViewController.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRArticleTableViewController : UITableViewController

//源ID
@property int sourceID;
//源地址链接
@property NSString *url;
//文章列表
@property NSMutableArray *articleList;

@end
