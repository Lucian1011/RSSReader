//
//  AppDelegate.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "AppDelegate.h"
//宏常量
#import "Macro.h"
//登录界面
#import "LoginViewController.h"
//主页
#import "homePageViewController.h"
//用户订阅列表数据源
#import "RRCategoryList.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //首次进入程序
    if ([user objectForKey:is_first_time_enter] == nil) {
        //为空则创建key
        BOOL isFirstTimeEnter = YES;
        [user setBool:isFirstTimeEnter forKey:is_first_time_enter];
        BOOL isLogin = NO;
        [user setBool:isLogin forKey:is_login];
        //创建初始的订阅列表
        NSArray *arr = [RRCategoryList getInitList];
        [user setObject:arr forKey:user_category_list];
    }
    
    //如果是第一次进入程序
    if ([user boolForKey:is_first_time_enter]) {
        //进入登录界面
        LoginViewController *login = [[LoginViewController alloc]init];
        self.window.rootViewController = login;
    }else{
        //否则进入主页
        homePageViewController *homePageVC = [[homePageViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
        self.window.rootViewController = nav;
    }
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
