//
//  homePageCollectionViewCell.m
//  RSSReader
//
//  Created by 刘旭 on 16/9/6.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "homePageCollectionViewCell.h"

@implementation homePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

//设置cell边框
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _boderView.layer.borderWidth = 0.5;
//    _boderView.layer.borderColor = [UIColor grayColor].CGColor;
    _boderView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    
}

@end
