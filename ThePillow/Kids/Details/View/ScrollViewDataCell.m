//
//  ScrollViewDataCell.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/19.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "ScrollViewDataCell.h"

@implementation ScrollViewDataCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
        [self layoutView];
    }
    
    return self;
}

-(void)layoutView
{
    UIImageView *imageTemp = [[UIImageView alloc]initWithFrame:CGRectMake((width-160)/2, 20*Height, 160, 160)];
    imageTemp.image = [UIImage imageNamed:@"circular_3"];
    [self addSubview:imageTemp];
    
    _scoreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 150, 150)];
    _scoreImageView.image = [UIImage imageNamed:@"circular_2"];
    _scoreImageView.layer.cornerRadius = 75;
    //_scoreImageView.layer.borderWidth = 1;
    //_scoreImageView.layer.borderColor = [RGB(77, 207, 199)CGColor];
    _scoreImageView.clipsToBounds = YES;
    [imageTemp addSubview:self.scoreImageView];
    
    if (iPhone_Plus) {
        imageTemp.y = 80*Height;
    }else if (iPhone_6) {
        imageTemp.y = 70*Height;
    }else if (iPhone_5) {
        imageTemp.y = 40*Height;
    }

    
    _scoreLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, _scoreImageView.width, _scoreImageView.height - 80)];
    _scoreLb.font = [UIFont systemFontOfSize:60];
    _scoreLb.text = @"0";
//    _scoreLb.textColor = RGB(249, 235, 60);
    _scoreLb.textAlignment = NSTextAlignmentCenter;
    [_scoreImageView addSubview:self.scoreLb];
    
    _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, _scoreImageView.height - 60, _scoreImageView.width, 15)];
    _timeLb.font = [UIFont systemFontOfSize:12];
    _timeLb.text = @"18:00-12:00";
    _timeLb.textColor = RGB(138, 138, 138);
    _timeLb.textAlignment = NSTextAlignmentCenter;
    [_scoreImageView addSubview:self.timeLb];
    
    _appraisalLb = [[UILabel alloc]initWithFrame:CGRectMake(0, _scoreImageView.height - 45, _scoreImageView.width, 15)];
    _appraisalLb.font = [UIFont systemFontOfSize:14];
    _appraisalLb.text = @"非常好";
    _appraisalLb.textColor = RGB(138, 138, 138);
    _appraisalLb.textAlignment = NSTextAlignmentCenter;
    [_scoreImageView addSubview:self.appraisalLb];
    
    
    
    _remindLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(imageTemp)+20*Height, self.width, 15)];
    _remindLb.font = [UIFont systemFontOfSize:16];
    _remindLb.text = @"你拥有良好的睡眠习惯请继续保持!";
    _remindLb.textColor = RGB(138, 138, 138);
    _remindLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.remindLb];

    
    _heartRateLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height- 120*Height, (width-3)/4, 20*Height)];
    _heartRateLb.font = [UIFont systemFontOfSize:10];
    _heartRateLb.text = @"  次/分";
    _heartRateLb.textColor = RGB(77, 207, 199);
    _heartRateLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.heartRateLb];
    
    UILabel *heart = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height- 100*Height, (width-3)/4, 10*Height)];
    heart.font = [UIFont systemFontOfSize:10];
    heart.text = @"心率";
    heart.textColor = RGB(138, 138, 138);
    heart.textAlignment = NSTextAlignmentCenter;
    [self addSubview:heart];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(width_x(heart), _heartRateLb.y, 1, 30*Height)];
    line1.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line1];
    
    _breatheLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line1), _heartRateLb.y, (width-3)/4, 20*Height)];
    _breatheLb.font = [UIFont systemFontOfSize:10];
    _breatheLb.text = @" 次/分";
    _breatheLb.textColor = RGB(77, 207, 199);
    _breatheLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.breatheLb];
    
    UILabel *breathe = [[UILabel alloc]initWithFrame:CGRectMake(_breatheLb.x, heart.y, (width-3)/4, 10*Height)];
    breathe.font = [UIFont systemFontOfSize:10];
    breathe.text = @"呼吸率";
    breathe.textColor = RGB(138, 138, 138);
    breathe.textAlignment = NSTextAlignmentCenter;
    [self addSubview:breathe];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(width_x(_breatheLb), _heartRateLb.y, 1, 30*Height)];
    line2.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line2];

    _snoringLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line2), _heartRateLb.y, (width-3)/4, 20*Height)];
    _snoringLb.font = [UIFont systemFontOfSize:10];
    _snoringLb.text = @"次/分";
    _snoringLb.textColor = RGB(77, 207, 199);
    _snoringLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.snoringLb];
    
    UILabel *snoring = [[UILabel alloc]initWithFrame:CGRectMake(_snoringLb.x, heart.y, (width-3)/4, 10*Height)];
    snoring.font = [UIFont systemFontOfSize:10];
    snoring.text = @"打鼾";
    snoring.textColor = RGB(138, 138, 138);
    snoring.textAlignment = NSTextAlignmentCenter;
    [self addSubview:snoring];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(width_x(_snoringLb), _heartRateLb.y, 1, 30*Height)];
    line3.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line3];
    
    _sleepDurationLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line3), _heartRateLb.y, (width-3)/4, 20*Height)];
    _sleepDurationLb.font = [UIFont systemFontOfSize:10];
    _sleepDurationLb.text = @"次";
    _sleepDurationLb.textColor = RGB(77, 207, 199);
    _sleepDurationLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.sleepDurationLb];
    
    UILabel *sleepDuration = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line3), heart.y, (width-3)/4, 10*Height)];
    sleepDuration.font = [UIFont systemFontOfSize:10];
    sleepDuration.text = @"体动次数";
    sleepDuration.textColor = RGB(138, 138, 138);;
    sleepDuration.textAlignment = NSTextAlignmentCenter;
    [self addSubview:sleepDuration];

  
    _leavebedNumLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height- 70*Height, (width-3)/4, 20*Height)];
    _leavebedNumLb.font = [UIFont systemFontOfSize:10];
    _leavebedNumLb.text = @" 次";
    _leavebedNumLb.textColor = RGB(77, 207, 199);
    _leavebedNumLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.leavebedNumLb];
    
    UILabel *leavebedNum = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height- 50*Height, (width-3)/4, 10*Height)];
    leavebedNum.font = [UIFont systemFontOfSize:10];
    leavebedNum.text = @"离床次数";
    leavebedNum.textColor = RGB(138, 138, 138);
    leavebedNum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:leavebedNum];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(width_x(_leavebedNumLb), _leavebedNumLb.y, 1, 30*Height)];
    line4.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line4];
    
    _soberNumLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line4), _leavebedNumLb.y, (width-3)/4, 20*Height)];
    _soberNumLb.font = [UIFont systemFontOfSize:10];
    _soberNumLb.text = @" 时/分";
    _soberNumLb.textColor = RGB(77, 207, 199);
    _soberNumLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.soberNumLb];
    
    UILabel *soberNum = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line4), leavebedNum.y, (width-3)/4, 10*Height)];
    soberNum.font = [UIFont systemFontOfSize:10];
    soberNum.text = @"在床时长";
    soberNum.textColor = RGB(138, 138, 138);
    soberNum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:soberNum];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(width_x(_soberNumLb), _leavebedNumLb.y, 1, 30*Height)];
    line5.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line5];

    _fallingAsleepLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line5), _leavebedNumLb.y, (width-3)/4, 20*Height)];
    _fallingAsleepLb.font = [UIFont systemFontOfSize:10];
    _fallingAsleepLb.text = @" 时/分";
    _fallingAsleepLb.textColor = RGB(77, 207, 199);
    _fallingAsleepLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.fallingAsleepLb];
    
    UILabel *fallingAsleep = [[UILabel alloc]initWithFrame:CGRectMake(_fallingAsleepLb.x, leavebedNum.y, (width-3)/4, 10*Height)];
    fallingAsleep.font = [UIFont systemFontOfSize:10];
    fallingAsleep.text = @"无人时长";
    fallingAsleep.textColor = RGB(138, 138, 138);
    fallingAsleep.textAlignment = NSTextAlignmentCenter;
    [self addSubview:fallingAsleep];
    
    UIView *line6 = [[UIView alloc]initWithFrame:CGRectMake(width_x(_fallingAsleepLb), _leavebedNumLb.y, 1, 30*Height)];
    line6.backgroundColor = RGB(138, 138, 138);
    [self addSubview:line6];


    _sleepTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line6), _leavebedNumLb.y, (width-3)/4, 20*Height)];
    _sleepTimeLb.font = [UIFont systemFontOfSize:10];
    _sleepTimeLb.text = @"小时";
    _sleepTimeLb.textColor = RGB(77, 207, 199);
    _sleepTimeLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.sleepTimeLb];
    
    UILabel *sleepTime = [[UILabel alloc]initWithFrame:CGRectMake(width_x(line6),leavebedNum.y, (width-3)/4, 10*Height)];
    sleepTime.font = [UIFont systemFontOfSize:10];
    sleepTime.text = @"睡眠时长";
    sleepTime.textColor = RGB(138, 138, 138);
    sleepTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:sleepTime];

    for (int i = 0; i<4; i++) {
        UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(width/4*i, self.height- 120*Height, width/4, 30*Height)];
        tagView.userInteractionEnabled = YES;
        [self addSubview:tagView];
        MyTap *tap1 = [[MyTap alloc]initWithTarget:self action:@selector(tagAction:)];
        tap1.myTag = i+1; //记录你点击的View
        [tagView addGestureRecognizer:tap1];
    }
    
}

- (void)tagAction:(MyTap *)tap{
    
//    NSLog(@"你点击的是第%ld个View",(long)tap.myTag);
    if ([self.delegate respondsToSelector:@selector(didSelectScrollViewDataCellWithNumber:)])
    {
        [self.delegate didSelectScrollViewDataCellWithNumber:tap.myTag];
    }
    
}


@end
