//
//  RRCategoryList.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "RRCategoryList.h"
#import "sourceCategory.h"
#import "Macro.h"
#import <AFNetworking.h>

@implementation RRCategoryList

-(NSMutableArray *)getList{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //先预设一些数据，后面根据网络数据补充
//    for (int i = 1; i < 20; i++) {
//        sourceCategory *category = [[sourceCategory alloc]init];
//        category.sourceID = i;
//        category.title = [NSString stringWithFormat:@"腾讯新闻%d",i];
////        category.url = @"http://news.qq.com/newsgn/rss_newsgn.xml";
//        category.url = @"http://rss.news.sohu.com/rss/guonei.xml";
//        category.imgURL = @"RSS_img";
//        [array addObject:category];
//    }
    
    //用NSUserDefaults读取数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *NSarr = [user objectForKey:user_category_list];
    NSLog(@"输出一下用户订阅列表数组%@",NSarr);
    for (int i = 0 ; i < [NSarr count]; i++) {
        NSDictionary *dic = [NSarr objectAtIndex:i];
        sourceCategory *category = [[sourceCategory alloc]init];
        category.sourceID = [[dic objectForKey:@"sourceID"] intValue];
        category.title = [dic objectForKey:@"title"];
        category.url = [dic objectForKey:@"url"];
        category.imgURL = [dic objectForKey:@"imgURL"];
        [array addObject:category];
    }
    return array;
}

-(NSMutableArray *)getAllList{
//    NSArray *title = [NSArray arrayWithObjects:@"hello", @"国际新闻". nil]
    //搜狐源
//    NSArray *titleArr = [NSArray arrayWithObjects: @"国内新闻", @"国际新闻", @"社会新闻",@"军事新闻",@"体育新闻",@"财经新闻",@"IT新闻",@"文教新闻",@"娱乐新闻",@"数码资讯",@"汽车新闻",@"留学资讯",@"校园文学",@"校园爱情",@"保健常识",@"就医指南",@"流行时尚",@"美容美发",@"星座新闻",@"国内旅游",@"出境旅游", nil];
//    NSArray *urlArr = [NSArray arrayWithObjects:@"http://rss.news.sohu.com/rss/guonei.xml", @"http://rss.news.sohu.com/rss/guoji.xml", @"http://rss.news.sohu.com/rss/shehui.xml", @"http://mil.sohu.com/rss/junshi.xml", @"http://rss.news.sohu.com/rss/sports.xml", @"http://rss.news.sohu.com/rss/business.xml", @"http://rss.news.sohu.com/rss/it.xml", @"http://rss.news.sohu.com/rss/learning.xml", @"http://rss.news.sohu.com/rss/yule.xml", @"http://digi.it.sohu.com/rss/shuma.xml", @"http://auto.sohu.com/rss/qichexinwen.xml", @"http://rss.goabroad.sohu.com/rss/liuxuezixun.xml", @"http://rss.campus.sohu.com/rss/xiaoyuanwenxue.xml", @"http://rss.campus.sohu.com/rss/xiaoyuanaiqing.xml", @"http://rss.health.sohu.com/rss/baojianchangshi.xml", @"http://rss.health.sohu.com/rss/jiuyizhinan.xml", @"http://rss.women.sohu.com/rss/liuxingshishang.xml", @"http://rss.women.sohu.com/rss/meirongmeifa.xml", @"http://astro.women.sohu.com/rss/xingzuoxinwen.xml", @"http://travel.sohu.com/rss/china.xml", @"http://travel.sohu.com/rss/shijie.xml",  nil];
    
    //新浪源
    NSArray *titleArr = [NSArray arrayWithObjects:@"国内新闻", @"国际新闻", @"社会新闻", @"港澳台新闻", @"社会与法", @"国际足坛", @"英超", @"中国之队", @"手机资讯", @"科普要闻", @"数码资讯", @"家电资讯", @"股票要闻汇总", @"期货要闻", @"国际军情", @"中国军情", @"情感婚姻", @"时装", @"美容", @"购车指导", @"新车上市", @"汽车养护", @"汽车保险", @"电影宝库", @"考研", @"司法考试", @"出国留学", @"星座时尚热点", @"育儿知识", nil];
    NSArray *urlArr = [NSArray arrayWithObjects:@"http://rss.sina.com.cn/news/china/focus15.xml", @"http://rss.sina.com.cn/news/world/focus15.xml",@"http://rss.sina.com.cn/news/society/focus15.xml", @"http://rss.sina.com.cn/news/china/hktaiwan15.xml", @"http://rss.sina.com.cn/news/society/law15.xml", @"http://rss.sina.com.cn/sports/global/focus.xml", @"http://rss.sina.com.cn/sports/global/england.xml", @"http://rss.sina.com.cn/sports/china/team.xml", @"http://rss.sina.com.cn/tech/mobile/mobile_6.xml", @"http://rss.sina.com.cn/tech/discovery/discovery.xml", @"http://rss.sina.com.cn/tech/number/new_camera.xml", @"http://rss.sina.com.cn/tech/elec/buy_elec.xml", @"http://rss.sina.com.cn/roll/stock/hot_roll.xml", @"http://rss.sina.com.cn/finance/future.xml", @"http://rss.sina.com.cn/jczs/taiwan20.xml", @"http://rss.sina.com.cn/jczs/china15.xml", @"http://rss.sina.com.cn/eladies/marry.xml", @"http://rss.sina.com.cn/fashion/style/news.xml", @"http://rss.sina.com.cn/fashion/beauty/news.xml", @"http://rss.sina.com.cn/auto/guide/index.xml", @"http://rss.sina.com.cn/auto/newcar/index.xml", @"http://rss.sina.com.cn/auto/servicing/index.xml", @"http://rss.sina.com.cn/auto/insurance/index.xml", @"http://rss.sina.com.cn/ent/film/focus7.xml", @"http://rss.sina.com.cn/edu/kaoyan.xml", @"http://rss.sina.com.cn/edu/sifa.xml", @"http://rss.sina.com.cn/edu/abroad5.xml", @"http://rss.sina.com.cn/astro/fashion.xml", @"http://rss.sina.com.cn/baby/news/guide.xml",  nil];
    
//    NSMutableArray *titleArr = [[NSMutableArray alloc]init];
//    NSMutableArray *urlArr = [[NSMutableArray alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *imgUrl = [NSArray arrayWithObjects:@"", nil];
    
    
    //使用网络数据
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //修改以支持text/plain
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@null",getListURL];
    if ([array count] == 9999){
        [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"%@",responseObject);
            
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//转换数据格式
            NSLog(@"RESPONSE　DATA: %@",[content objectForKey:@"data"]);//打印结果
            NSArray *returnData = [content objectForKey:@"data"];
            if ([returnData isKindOfClass:[NSArray class]]) {
                NSLog(@"🐒🐒🐒🐒🐒🐒是NSArray啊");
            }
            
            for (int i = 0; i < [returnData count]; i++) {
                
                NSDictionary *dic = [returnData objectAtIndex:i];
//                NSLog(@"dic = %@",dic);
    //            NSLog(@"尼玛, = %@",[dic objectForKey:@"type_name"]);
                //加入title
    //            NSLog(@"有没有啊titleStr=%@",titleStr);
//                [titleArr addObject:[dic objectForKey:@"type_name"]];
                //加入url
//                NSLog(@"dic url = %@",[dic objectForKey:@"url"]);
//                [urlArr addObject:[dic objectForKey:@"url"]];
                if (_delegateLoad) {
                    [_delegateLoad loadList];
                }
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"连接失败,error = %@",error);
        }];
    }
    
    
    
    for (int i = 1; i < [titleArr count]; i++) {
        sourceCategory *category = [[sourceCategory alloc]init];
        category.sourceID = i;
        category.title = [titleArr objectAtIndex:i-1];
        category.url = [urlArr objectAtIndex:i-1];
        category.imgURL = @"RSS_img";
        [array addObject:category];
    }
    NSLog(@"array =%@",array);
    
    return array;
}

+(BOOL)uploadList:(NSMutableArray *)array{
    //与网络交互，更新订阅列表
    
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < [array count]; i++) {
        sourceCategory *category = [array objectAtIndex:i];
        NSString *sourceID = [NSString stringWithFormat:@"%d",category.sourceID];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:sourceID, @"sourceID", category.title, @"title", category.url, @"url", category.imgURL, @"imgURL", nil];
        [mutArr addObject:dic];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:mutArr forKey:user_category_list];
    
    //成功返回yes
    return YES;
}

+(NSArray *)getInitList{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"sourceID", @"标题1", @"title", @"", @"url", @"", @"imgURL", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"sourceID", @"标题2", @"title", @"", @"url", @"", @"imgURL", nil];
    NSArray *array = [NSArray arrayWithObjects:dic, nil];
    return array;
}

@end
