//
//  RRArticleTableViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "RRArticleTableViewController.h"
#import "RRArticleList.h"
#import "articleInfo.h"
//cell
#import "RRArticleTableViewCell.h"
//网页浏览框架
#import <KINWebBrowserViewController.h>

@interface RRArticleTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RRArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //加载数据
    RRArticleList *list = [[RRArticleList alloc]init];
    _articleList = [list getArticleList:_url];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RRArticleTableViewCell" bundle:nil] forCellReuseIdentifier:@"RRArticleTableViewCell"];
    //代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_articleList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"RRArticleTableViewCell";
    RRArticleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    RRArticleTableViewController *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[articleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    
    articleInfo *info = [_articleList objectAtIndex:indexPath.row];
    cell.titleLabel.text = info.title;
    cell.dateLabel.text = info.date;
//    NSLog(@"info.date=%@",info.date);
    
    return cell;
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KINWebBrowserViewController *webBrowser = [KINWebBrowserViewController webBrowser];
    [self.navigationController pushViewController:webBrowser animated:YES];
    articleInfo *info = [_articleList objectAtIndex:indexPath.row];
    NSLog(@"🐒🐒🐒🐒🐒🐒link = %@",info.link);
    [webBrowser loadURLString:info.link];
}



@end
