//
//  MyScrollerView.h
//  UI7_滚动视图
//
//  Created by lanou on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollerView : UIView<UIScrollViewDelegate>



@property(nonatomic,assign)int number;
@property(nonatomic,assign)int indexZoom;//存放当前正在放大的图像下标
@property(nonatomic,retain)UIScrollView *uiScrolView;
@property(nonatomic,retain)UIPageControl *pageControl;

//添加视图
-(void)addScrollerSubView:(UIView *)subView;
//设置可以存放的view数量
-(void)setViewNumber:(int)number;
//设置页面控制条的颜色
-(void)setPageControlColor:(UIColor *)color1 color2:(UIColor *)color2;
//添加数组
-(void)addArray:(NSArray *)arr;

//添加数组图片,嵌套scrollerView缩放
-(void)addarrayScrollerView:(NSArray *)arr;

@end
