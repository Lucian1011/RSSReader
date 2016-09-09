//
//  RRArticleList.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWFeedParser.h>

@interface RRArticleList : NSObject<MWFeedParserDelegate>

-(NSMutableArray*) getArticleList: (NSString*)url;

@property NSString *url;
@property NSMutableArray *articleList;
@end
