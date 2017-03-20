//
//  AHRuler.h
//  Ruler
//
//  Created by 呜拉巴哈 on 16/2/1.
//  Copyright © 2016年 http://www.swiftnews.cn . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHRulerScrollView.h"

@protocol AHRrettyRulerDelegate <NSObject>

- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler;

@end

@interface AHRuler : UIView <UIScrollViewDelegate>

@property (nonatomic,assign) id <AHRrettyRulerDelegate> rulerDeletate;

@property (nonatomic,strong) AHRulerScrollView *rulerScrollVieww;

@property (nonatomic,assign)NSInteger rulerMin;  //最小值
@property (nonatomic)BOOL isText; //是否显示文字
@property (nonatomic)BOOL isRangingHeight; //是否等高
@property (nonatomic)BOOL isDisplayTags; //是否显示标记
@property (nonatomic,assign)CGFloat distanceTopAndBottom; // 标尺上下距离
/*
 *  count * average = 刻度最大值
 *  @param count        10个小刻度为一个大刻度，大刻度的数量
 *  @param average      每个小刻度的值，最小精度 0.1
 *  @param currentValue 直尺初始化的刻度值
 *  @param mode         是否最小模式
 */
- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode;

@end
