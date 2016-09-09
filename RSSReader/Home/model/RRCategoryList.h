//
//  RRCategoryList.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol loadListDelegate  <NSObject>

-(void) loadList;

@end

@interface RRCategoryList : NSObject

-(NSMutableArray*) getList;
-(NSMutableArray*) getAllList;
+(BOOL) uploadList: (NSMutableArray*)array;
+(NSArray*) getInitList;

//代理
@property (weak, nonatomic) id<loadListDelegate> delegateLoad;
@property NSString* test;

@end
