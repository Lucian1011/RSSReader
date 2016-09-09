//
//  selectViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "selectViewController.h"
#import "selectTableViewCell.h"
//数据
#import "RRCategoryList.h"
#import "sourceCategory.h"
//宏
#import "Macro.h"
//主页
#import "homePageViewController.h"

@interface selectViewController (){
    BOOL isSelectedStatus[100];
    
}

@end

@implementation selectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择感兴趣的订阅源";
    //添加完成按钮
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(selectComplete)];
    self.navigationItem.rightBarButtonItem = done;
    //初始化tableView并设置代理
    _selectTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_selectTableView];
    _selectTableView.delegate = self;
    _selectTableView.dataSource = self;
    //注册cell
    _reuseIdentifier = @"reuseId";
    [_selectTableView registerNib:[UINib nibWithNibName:@"selectTableViewCell" bundle:nil] forCellReuseIdentifier:_reuseIdentifier];
    
    //加载数据
    //所有列表数据
    RRCategoryList *list = [[RRCategoryList alloc]init];
    _allCategoryList = [list getAllList];;
    //用户订阅列表数据
//    RRCategoryList *list = [[RRCategoryList alloc]init];
    _userCategoryList = [list getList];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //如果是第一次进入程序
    if ([user boolForKey:is_first_time_enter] == YES) {
        //把所有都设置成未选
        int count = (int)[_allCategoryList count];
        for (int i = 0; i < count; i++) {
            isSelectedStatus[i] = NO;
        }
        //修改不是第一次进入程序
        [user setBool:NO forKey:is_first_time_enter];
    }else{
        NSLog(@"第一次进入程序");
        //设置好_isSelected数组
        [self setIsSelectedArray];
        
        
    }
}

//根据用户订阅列表和总列表设置选中状态
- (void)setIsSelectedArray{
    int allIDCount = (int)[_allCategoryList count];
    int userIDCount = (int)[_userCategoryList count];
    int allID[100];
    int userID[100];
    //初始化两个数组
    for (int i = 0; i < 100; i++) {
        allID[i] = -1;
        userID[i] = -1;
    }
    //赋值allID数组
    for (int i = 0; i < allIDCount; i++) {
        sourceCategory *source = [_allCategoryList objectAtIndex:i];
        allID[i] = source.sourceID;
//        NSLog(@"赋值allID数组,allID[%d] = %d",i,allID[i]);
    }
    //赋值userID数组
    for (int i = 0; i < userIDCount; i++) {
        sourceCategory *source = [_userCategoryList objectAtIndex:i];
        userID[i] = source.sourceID;
//        NSLog(@"赋值allID数组,userID[%d] = %d",i,userID[i]);
    }
    //处理isSelected数组
    for (int i = 0; i < allIDCount; i++) {
        isSelectedStatus[i] = NO;
        int temp = allID[i];
        for (int j = 0; j < userIDCount; j++) {
            if (temp == userID[j]) {
//                NSLog(@"temp == userID[j]");
                isSelectedStatus[i] = YES;
//                NSLog(@"isSelectedStatus[i] = %d",isSelectedStatus[i]);
            }
        }
    }
    
    
}
//选择完成
- (void)selectComplete{
    //根据isSelectedStatus更新订阅源
    NSMutableArray *newList = [[NSMutableArray alloc]init];
    int allIDCount = (int)[_allCategoryList count];
    for (int i = 0; i < allIDCount; i++) {
        if (isSelectedStatus[i] == YES) {
            sourceCategory *temp = [_allCategoryList objectAtIndex:i];
            [newList addObject:temp];
        }
    }
    //将新的订阅源赋值给旧的订阅源
    _userCategoryList = newList;
    //调用更新方法与网络交互
    [RRCategoryList uploadList:_userCategoryList];
    //跳转主页
    homePageViewController *homePageVC = [[homePageViewController alloc]init];
    [self.navigationController pushViewController:homePageVC animated:YES];
//    [self.navigationController presentViewController:homePageVC animated:YES completion:nil];
//    [self presentViewController:homePageVC animated:YES completion:nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_allCategoryList count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    selectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier forIndexPath:indexPath];
    sourceCategory *source = [_allCategoryList objectAtIndex:indexPath.row];
    cell.titleLabel.text = source.title;
//    NSLog(@"复用cell, source.title=%@",source.title);
    //设置滑块选中与否
    
    [cell.selectSwitch setOn:isSelectedStatus[indexPath.row]];

    [cell.selectSwitch setTag:indexPath.row + 1000] ;

    [cell.selectSwitch addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    
    
    return cell;
}

//选择订阅源后调用以更新数据源
-(void)click:(UISwitch*)sender{
    isSelectedStatus[sender.tag - 1000] = sender.on;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
