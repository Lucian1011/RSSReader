//
//  MeViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "MeViewController.h"
#import <Masonry.h>
#import "Macro.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置了这些东西之后就可以把self.view下移到UINavigationController下面
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [_logoutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
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

- (IBAction)changePwd:(id)sender {
    
}

- (void)logOut {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:is_login];
    //代理
    if (_delegate == nil) {
        NSLog(@"🐸🐸🐸🐸🐸delegate都是空的");
    }
    if (_delegate) {
        [_delegate Logout];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
