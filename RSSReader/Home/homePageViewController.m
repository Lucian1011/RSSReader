//
//  homePageViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "homePageViewController.h"

#import "RRCategoryList.h"
#import "sourceCategory.h"
//宏常量
#import "Macro.h"
//主页cell
#import "homePageCollectionViewCell.h"
//登录界面
#import "LoginViewController.h"
//个人设置
#import "MeViewController.h"
//文章列表
#import "RRArticleTableViewController.h"
//选择订阅源
#import "selectViewController.h"

@interface homePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, LoginDelegate, LogoutDelegate, loadListDelegate>

@end

@implementation homePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RSS Reader";
    _reuesIdentifier = @"homePage";
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES];
//    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    //设置collectionView背景
    _mainCollecionView.backgroundColor = [UIColor grayColor];
    //初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //初始化collectionView
    _mainCollecionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    //设置一下collecionView背景色
    _mainCollecionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainCollecionView];
    
    //添加“我”
    UIBarButtonItem *me = [[UIBarButtonItem alloc]initWithTitle:@"我" style:UIBarButtonItemStylePlain target:self action:@selector(pressMe)];
    self.navigationItem.rightBarButtonItem = me;
    
    //注册cell
    [_mainCollecionView registerNib:[UINib nibWithNibName:@"homePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:_reuesIdentifier];
    
    //设置代理
    _mainCollecionView.delegate = self;
    _mainCollecionView.dataSource = self;
    
    //获取数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //如果已经登录则获取用户数据
    if ([user boolForKey:is_login]) {
        [_categoryList removeAllObjects];
        RRCategoryList *list = [[RRCategoryList alloc]init];
        list.delegateLoad = self;
        _categoryList = [list getList];
        //添加修改订阅源按钮
        sourceCategory *modifyCategory = [[sourceCategory alloc]init];
        modifyCategory.imgURL = @"modifyCategory";
        modifyCategory.title = @"修改";
        [_categoryList addObject:modifyCategory];
    }else{
        //否则获取全部数据
        RRCategoryList *list = [[RRCategoryList alloc]init];
        list.delegateLoad = self;
        _categoryList = [list getAllList];
    }
    
    
    
}

-(void) pressMe{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //如果已经登录
    if ([user boolForKey:is_login]==YES) {
        //跳转个人设置
        MeViewController *me = [[MeViewController alloc]init];
        me.delegate = self;
        [self.navigationController pushViewController:me animated:YES];
    }else{
        //否则跳转登录界面
        LoginViewController *login = [[LoginViewController alloc]init];
        login.delegate = self;
        [self presentViewController:login animated:YES completion:nil];
    }
}

//登录代理
- (void) Login{
    //刷新数据
    RRCategoryList *list = [[RRCategoryList alloc]init];
    _categoryList = [list getList];
    [_mainCollecionView reloadData];
    NSLog(@"Login代理被调用");
}



//退出登录代理
- (void) Logout{
    //刷新数据
    RRCategoryList *list = [[RRCategoryList alloc]init];
    _categoryList = [list getAllList];
    [_mainCollecionView reloadData];
    NSLog(@"Logout代理被调用");
}

//loadListDelegate
-(void)loadList{
    NSLog(@"🐒🐒🐒🐒🐒🐒delegate被调用");
    RRCategoryList *list = [[RRCategoryList alloc]init];
    _categoryList = [list getAllList];
    
    [self.mainCollecionView reloadData];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"返回section个数");
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"每个section的item个数是：%i",[_categoryList count]);
    return [_categoryList count];
}



//复用cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"复用cell");
    homePageCollectionViewCell *cell = (homePageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:_reuesIdentifier forIndexPath:indexPath];
    sourceCategory *category = [_categoryList objectAtIndex:indexPath.row];
    //设置标题
    cell.titleLabel.text = category.title;
    //设置图片
    cell.image.image = [UIImage imageNamed:category.imgURL];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (ScreenW)/3;
    return CGSizeMake(width, width);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//设置头部
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *header = (UICollectionReusableView*)[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
//    header.backgroundColor = [UIColor greenColor];
//    return header;
//}

//选中响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //如果选中的是修改
//    NSLog(@"indexPath.row=%d and [_categoryList count] = %i",indexPath.row,[_categoryList count]);
    if (indexPath.row == [_categoryList count]-1) {
        selectViewController *select = [[selectViewController alloc]init];
        [self.navigationController pushViewController:select animated:YES];
    }else{
        RRArticleTableViewController *articleVC = [[RRArticleTableViewController alloc]init];
        sourceCategory *list = [_categoryList objectAtIndex:indexPath.row];
        articleVC.url = list.url;
        NSLog(@"url = %@",articleVC.url);
        [self.navigationController pushViewController:articleVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
