//
//  selectCategoryViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "selectCategoryViewController.h"

#import "RRCategoryList.h"
#import "sourceCategory.h"
//选择话题界面cell
#import "selectCategoryCollectionViewCell.h"

@interface selectCategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation selectCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择感兴趣的话题";
    _reuesIdentifier = @"selectCategory";
    //初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //初始化collectionView
    _mainCollecionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    //设置一下collecionView背景色
    _mainCollecionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainCollecionView];
    
    //注册cell
    [_mainCollecionView registerNib:[UINib nibWithNibName:@"selectCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:_reuesIdentifier];
    
    //设置代理
    _mainCollecionView.delegate = self;
    _mainCollecionView.dataSource = self;
    
    //获取数据
//    RRCategoryList *list = [[RRCategoryList alloc]init];
    RRCategoryList *list = [[RRCategoryList alloc]init];
    _categoryList = [list getAllList];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_categoryList count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    selectCategoryCollectionViewCell *cell = (selectCategoryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:_reuesIdentifier forIndexPath:indexPath];
    sourceCategory *category = [_categoryList objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = category.title;
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-26)/4;
    return CGSizeMake(width, width/170*80);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
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
