//
//  RRArticleList.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "RRArticleList.h"
#import "articleInfo.h"

//多线程安全
#import <FMDatabaseQueue.h>

@implementation RRArticleList
-(NSMutableArray *)getArticleList:(NSString *)url{
    _url = url;
    //初始化_articleList
    _articleList = [[NSMutableArray alloc]init];
    [self loadFromInternet];
    [self writeIntoDataBase];
    [self loadDataFromDataBase];
    
    return _articleList;
}

-(void) loadFromInternet{
    NSURL *feedURL = [NSURL URLWithString:_url];
    MWFeedParser *feedParser = [[MWFeedParser alloc]initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeSynchronously;
    [feedParser parse];
    
}

-(void)feedParserDidStart:(MWFeedParser *)parser{
    NSLog(@"feedParserDidStart");
}

// Provides info about a feed item
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    NSString *title = item.title ? item.title : @"[No Title]";
    NSString *link = item.link ? item.link : @"[No Link]";
    NSString *summary = item.summary ? item.summary : @"[No Summary]";
    NSDate *NSdate = item.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    
    NSString *date = [dateFormatter stringFromDate:item.date];
    
    
    articleInfo *info = [[articleInfo alloc]init];
    info.title = title;
    info.link = link;
    info.summary = summary;
    info.date = date;
    NSLog(@"info = %@",info);
    if (info == nil) {
        NSLog(@"🐒🐒🐒🐒空的啊");
    }
    [_articleList addObject:info];
    if (_articleList == nil) {
        NSLog(@"🐸🐸🐸🐸空的啊");
    }
    NSLog(@"在RRArticleList中，%lu",(unsigned long)[_articleList count]);
    
    
    NSLog(@"%@",title);
//    NSLog(@"%@",link);
//    NSLog(@"%@",summary);
//    NSLog(@"you have called feedParser, totalMsg = %d, title=%@",++totalMsgs,title);
//    if (totalMsgs == 2) {
//        NSLog(@"--------------------\nlink=%@ and summary=%@\n content=%@",link,summary,item.content);
//    }
}

// Parsing failed
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    NSLog(@"🐒🐒🐒🐒🐒failed to load");
}

-(void) writeIntoDataBase{
    
}

-(void)loadDataFromDataBase{
    
}
@end
