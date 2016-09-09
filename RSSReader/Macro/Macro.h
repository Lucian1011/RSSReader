//
//  Macro.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

// 效率工具
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

// 颜色
#define ColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define themeColor [UIColor colorWithRed:45/255.0 green:62/255.0 blue:84/255.0 alpha:1]


//NSUserDefaults相关
#define is_login @"isLogin"
#define is_first_time_enter @"isFirstTimeEnter"
#define user_category_list @"userCategoryList"

//
#define loginURL @"http://172.22.82.218:8080/Rss/Login"
#define getListURL @"http://172.22.82.218:8080/Rss/GetSubscribe?user_name="


#endif /* Macro_h */
