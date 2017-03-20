//
//  ScrollViewDataCell.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/19.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewDataCellDelegate <NSObject>

@optional
- (void)didSelectScrollViewDataCellWithNumber:(NSInteger)selectTag;

@end


@interface ScrollViewDataCell : UIView
{
    CGFloat width;
    CGFloat height;
}

@property (nonatomic,strong)UIImageView *scoreImageView; //评分背景图片
@property (nonatomic,strong)UILabel *scoreLb; //评分
@property (nonatomic,strong)UILabel *timeLb; //时间
@property (nonatomic,strong)UILabel *appraisalLb; //评价
@property (nonatomic,strong)UILabel *remindLb; //提醒
@property (nonatomic,strong)UILabel *heartRateLb; //心率
@property (nonatomic,strong)UILabel *breatheLb; //呼吸率
@property (nonatomic,strong)UILabel *snoringLb; //打鼾
@property (nonatomic,strong)UILabel *sleepDurationLb; //体动次数
@property (nonatomic,strong)UILabel *leavebedNumLb; //离床次数
@property (nonatomic,strong)UILabel *soberNumLb; //清醒次数
@property (nonatomic,strong)UILabel *fallingAsleepLb; //入睡时长
@property (nonatomic,strong)UILabel *sleepTimeLb; //睡眠时长

@property (nonatomic,weak)id<ScrollViewDataCellDelegate>delegate;

@end
