//
//  SleepStCell.m
//  KIDS
//
//  Created by 陈镇池 on 16/8/17.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "SleepStCell.h"

@implementation SleepStCell

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
    
    CGFloat width = MainScreenWidth;
    CGFloat height = self.contentView.frame.size.height;
    
    _openLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
    _openLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:_openLine];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width/4, 1)];
    line1.backgroundColor = RGB(199, 199, 199);
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(width_x(line1)+20, 0, width/4*3-20, 1)];
    line2.backgroundColor = RGB(199, 199, 199);
    [self addSubview:line2];
    
    
    _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_openLine), line1.width, 20)];
    _timeLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLb];
    
    UIImageView *circleIv = [[UIImageView alloc]initWithFrame:CGRectMake(width_x(_timeLb), _timeLb.y, 20, 20)];
    circleIv.image = [UIImage imageNamed:@"ring_green"];
    [self addSubview:circleIv];
    
    _statusLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(circleIv)+30, _timeLb.y, 100, _timeLb.height)];
    [self addSubview:_statusLb];
    
    _closeLine = [[UIView alloc]initWithFrame:CGRectMake(0,  height_y(_timeLb), width, 1)];
    _closeLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:_closeLine];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(_timeLb), width/4, 1)];
    line3.backgroundColor = RGB(199, 199, 199);
    [self addSubview:line3];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(width_x(line3)+20, line3.y, width/4*3-20, 1)];
    line4.backgroundColor = RGB(199, 199, 199);
    [self addSubview:line4];
    
    _midLine = [[UIView alloc]initWithFrame:CGRectMake(0, height_y(_closeLine), 1, height-height_y(_closeLine))];
    _midLine.backgroundColor = MainColor;
    _midLine.centerX = circleIv.centerX;
    [self addSubview:_midLine];
    
    _timeGapLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width/2, 40)];
    _timeGapLb.centerX = line4.centerX;
    _timeGapLb.centerY = _midLine.centerY;
    _timeGapLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeGapLb];
    
   
    
    
    
}

@end
