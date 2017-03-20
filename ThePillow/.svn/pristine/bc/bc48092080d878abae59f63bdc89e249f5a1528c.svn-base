//
//  ChooseAvatarView.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "ChooseAvatarView.h"

@implementation ChooseAvatarView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createMyView];
    }
    
    return self;
}

- (void)createMyView {
    
    //假设每行应用(UIView)的个数
    int columns = 3;
    //假设应用(UIView)的总个数
    int sum = 6;
    //获取控制器所管理的View的宽度
    CGFloat viewWidth = self.frame.size.width;
    
    //每个应用的宽和高
    CGFloat appW = 80;
    CGFloat appH = 80;
    CGFloat marginTop = (MainScreenWidth-240)/8; //第一行距离顶部的距离
    //X方向View之间的间距
    CGFloat marginX = (viewWidth - columns * appW) / (columns + 1);
    //Y方向View之间的间距
    CGFloat marginY = marginX; //假设Y方向间距与X方向相等,好看
    
    
    
    for (int i = 0; i < sum; i++) {
        //1,创建每个应用(UIView)
        _imageV = [[UIImageView alloc]init];
       
        //2,设置(UIView)属性
        //背景颜色
        _imageV.backgroundColor = [UIColor clearColor];
        //设置frame属性
        
        //计算每个View所在的列的索引(列数的意思,从Y方向起第一列为0算起;)
        int colIdx = i % columns;
        //计算每个View所在的行的索引
        int roeIdx = i / columns;
        
        CGFloat appX = marginX + colIdx * (appW + marginX);
        CGFloat appY = marginTop + roeIdx * (appH + marginY);
        
        _imageV.frame = CGRectMake(appX, appY, appW, appH);
        _imageV.userInteractionEnabled = YES;
        _imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"headPortrait%d",i+1]];
        
        //3,将(UIView)加载到屏幕
        
        [self addSubview:self.imageV];
        
        //轻拍手势 UITapGestureRecognizer
        MyTap *tap = [[MyTap alloc]initWithTarget:self action:@selector(imageVAction:)];
        tap.myTag = i+1; //记录你点击的image
        [_imageV addGestureRecognizer:tap];
        
    }
    
    
}

#pragma mark -- 头像图片的点击方法
-(void)imageVAction:(MyTap *)tap{
    NSLog(@"你点击的是第%ld个头像",(long)tap.myTag);
    if ([self.delegate respondsToSelector:@selector(didSelectChooseAvatarViewWithNum:)]) {
        [self.delegate didSelectChooseAvatarViewWithNum:tap.myTag];
    }
}

@end
