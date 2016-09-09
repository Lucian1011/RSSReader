//
//  MeViewController.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

//退出登录代理通知主页刷新数据
@protocol LogoutDelegate <NSObject>

- (void)Logout;

@end

@interface MeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *myCollection;
- (IBAction)changePwd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

//代理
@property (weak, nonatomic) id<LogoutDelegate> delegate;

@end
