//
//  LoginViewController.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>


//
@protocol LoginDelegate <NSObject>
- (void)Login;
@end

@interface LoginViewController : UIViewController
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
//随便看看
@property (weak, nonatomic) IBOutlet UIButton *justHaveALook;



//代理
@property (weak, nonatomic) id<LoginDelegate> delegate;

@property NSString *userNameS;
@property NSString *userPwdS;

@end
