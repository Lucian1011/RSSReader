//
//  LoginViewController.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking.h>
#import <IQKeyboardManager.h>
#import "Macro.h"
//主页
#import "homePageViewController.h"
//选择话题页面
#import "selectCategoryViewController.h"
#import "selectViewController.h"

//#import "RRHomePageViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //修改状态栏颜色
    [self preferredStatusBarStyle];
    
    //取消登录
    [_cancelBtn addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    
    //LoginBtn点击
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //点击随便看看
    [_justHaveALook addTarget:self action:@selector(haveALook) forControlEvents:UIControlEventTouchUpInside];
    
    //设置textField代理
    _userName.delegate = self;
    _userPwd.delegate = self;
    
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //如果是第一次进入，隐藏掉右上方关闭按钮
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user boolForKey:is_first_time_enter]) {
        [_cancelBtn setHidden:YES];
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void) login{
    //确保_userNameS和_userPwdS不为空
    if ((_userNameS == nil) || (_userPwdS == nil)) {
        //未输入用户名密码警告
        [self alert:@"警告" message:@"请输入用户名和密码"];
    }else{
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        //修改以支持text/plain
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        //很重要，去掉就容易遇到错误，暂时还未了解更加详细的原因
        
//        NSString *u = loginURL;
//        NSString *url = [u stringByAppendingFormat:@"?user_name=%@&password=%@", _userNameS, _userPwdS];
        
//        url = @"http://api.douban.com/book/subjects?q=ios&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1";
//        url = @"http://localhost:8080/cssReaderServer/response.jsp?user=123&pwd=123";
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        //如果是第一次进来
        if ([user boolForKey:is_first_time_enter] == YES) {
            selectViewController *selectViewVC = [[selectViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:selectViewVC];
            [self presentViewController:nav animated:YES completion:nil];
            
//            [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                selectViewController *selectViewVC = [[selectViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:selectViewVC];
//                [self presentViewController:nav animated:YES completion:nil];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                [self alert:@"登录失败" message:@"用户名或密码错误"];
//            }];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
            //代理通知主页刷新数据
            if (_delegate) {
                [_delegate Login];
            }
            
            //如果不是第一次进来，则dismiss登录页面
//            [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"response = %@",responseObject);
//                NSLog(@"下面将获取的data转换成NSString");
//                
//                NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                
//                NSLog(@"转换过后输出：%@",aString);
//                [self dismissViewControllerAnimated:YES completion:nil];
//                //代理通知主页刷新数据
//                if (_delegate) {
//                    [_delegate Login];
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"url=%@",url);
//                NSLog(@"%@",error);
//                [self alert:@"登录失败" message:@"用户名或密码错误"];
//                
//            }];
            
        }
        //登录成功后修改userInfo
        //        [user setBool:NO forKey:is_first_time_enter]; //修改要放在selectViewController里面来进行
        [user setBool:YES forKey:is_login];
    }
    
}

//-(BOOL) loginSuccess: (NSString*)userName pwd: (NSString*)userPwd{
//    //创建HTTP连接管理对象
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    
//    //豆瓣的一个地址
//    NSString *u = loginURL;
//    NSString *url = [u stringByAppendingFormat:@"?user_name=%@&password=%@", _userNameS, _userPwdS];
//    
//    
//    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"连接成功");
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
//    return NO;
//}

-(void) alert: (NSString*)title message: (NSString*)mes{
    //添加一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:mes preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void) haveALook{
    //修改userInfo，不是第一次进入程序了
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:is_first_time_enter];
    homePageViewController *homePageVC = [[homePageViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    [self presentViewController:nav animated:NO completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        _userNameS = textField.text;
        NSLog(@"用户名是：%@",_userNameS);
    }
    if (textField.tag == 102) {
        _userPwdS = textField.text;
        NSLog(@"密码是：%@",_userPwdS);
    }
}

-(void) cancelLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
