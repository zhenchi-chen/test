//
//  DetailTableViewCell.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/5.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

#pragma -mark代码创建cell的时候执行的方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化的代码
        [self layoutCell];
    }
    
    return self;
}

#pragma -mark对cell进行排版的方法
-(void)layoutCell {
    
    _sleepStatisticsLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, 20, 100, 20)];
    [self addSubview:_sleepStatisticsLb];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
