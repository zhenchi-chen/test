//
//  AHRulerScrollView.h
//  Ruler
//
//  Created by 呜拉巴哈 on 16/2/1.
//  Copyright © 2016年 http://www.swiftnews.cn . All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCELEFTANDRIGHT 10.f // 标尺左右距离
#define DISTANCEVALUE 10.f // 每隔刻度实际长度8个点


@interface AHRulerScrollView : UIScrollView

@property (nonatomic) NSUInteger rulerCount;

@property (nonatomic) NSNumber * rulerAverage;

@property (nonatomic) NSUInteger rulerHeight;

@property (nonatomic) NSUInteger rulerWidth;

@property (nonatomic) CGFloat rulerValue;

@property (nonatomic,assign)NSInteger rulerAboutSpacing; // 标尺左右距离

@property (nonatomic,assign)CGFloat distanceTopAndBottom; // 标尺上下距离

@property (nonatomic,assign)NSInteger rulerMin;  //最小值

@property (nonatomic)BOOL isText; //是否显示文字

@property (nonatomic)BOOL isRangingHeight; //是否等高

@property (nonatomic) BOOL mode;

- (void)drawRuler;

@end
