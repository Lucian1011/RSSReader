//
//  selectTableViewCell.h
//  RSSReader
//
//  Created by 刘旭 on 16/9/7.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
