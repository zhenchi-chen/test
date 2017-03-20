//
//  MyScrollerView.m
//  UI7_滚动视图
//
//  Created by lanou on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyScrollerView.h"

@implementation MyScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self createMyView:frame];
    }
    return self;
}

-(void)createMyView:(CGRect)frame
{
    self.number = 0;
    self.indexZoom = 0;
    //scrollerview创建  init
    self.uiScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview:self.uiScrolView];
    //颜色
//    self.uiScrolView.backgroundColor = [UIColor greenColor];
    //分页显示
     self.uiScrolView.pagingEnabled = YES;
    
    //释放允许越界拖动
     self.uiScrolView.bounces = NO;
    
    //取消滚动条
     self.uiScrolView.showsHorizontalScrollIndicator = NO;
    
    //指定代理人
     self.uiScrolView.delegate = self;
    
    //设置从第一张开始
    self.uiScrolView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    //放大缩小效果(代理方法)
//    self.uiScrolView.minimumZoomScale = 0.5;
//    self.uiScrolView.maximumZoomScale = 2;
    
    //页码控制器
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, frame.size.height-50 - 40, frame.size.width - 40, 40)];
    [self addSubview:self.pageControl];
    //颜色
//    self.pageControl.backgroundColor = [UIColor yellowColor];
    
    //指定pagecontrol的代理人
    [self.pageControl addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
   
}

//添加视图
-(void)addScrollerSubView:(UIView *)subView{
//    NSLog(@"我真是日了狗了");
    [self.uiScrolView addSubview:subView];
}
//设置可以存放的view数量
-(void)setViewNumber:(int)number{
    self.number = number;
    self.pageControl.numberOfPages = number;
    self.uiScrolView.contentSize = CGSizeMake(self.frame.size.width * (number+2), self.frame.size.height);
}
//设置页面控制条的颜色
-(void)setPageControlColor:(UIColor *)color1 color2:(UIColor *)color2{
    self.pageControl.currentPageIndicatorTintColor = color1;
    self.pageControl.pageIndicatorTintColor = color2;
}

//添加数组,不是缩放
-(void)addArray:(NSArray *)arr
{
    //设置数量
    [self setViewNumber:(int)[arr count]];
    //5 将图片放入
    UIImage *img1 = [UIImage imageNamed:[arr objectAtIndex:self.number-1]];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgView1.image = img1;
   
    [self addScrollerSubView:imgView1];
    
    //6 填充图片
    
    for (int i = 0; i < self.number; i++) {
        UIImage *img = [UIImage imageNamed:[arr objectAtIndex:i]];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width  * (i+1), 0, self.frame.size.width, self.frame.size.height)];
        imgView.image = img;
        //6 填充图片
        
        [self addScrollerSubView:imgView];
        
        
    }
    
    UIImage *img2 = [UIImage imageNamed:[arr objectAtIndex:0]];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width  * (self.number+1), 0, self.frame.size.width, self.frame.size.height)];
    imgView2.image = img2;
    [self addScrollerSubView:imgView2];
    

}

//添加缩放
-(void)addarrayScrollerView:(NSArray *)arr
{
    //设置数量
    [self setViewNumber:(int)[arr count]];
    NSLog(@"%d",(int)[arr count]);
    NSLog(@"%ld",[self.uiScrolView.subviews count]);
    //5 将图片放入
    UIImage *img1 = [UIImage imageNamed:[arr objectAtIndex:self.number-1]];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgView1.image = img1;

    //注意scrollview和imageview的起始位置
    UIScrollView *sc1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //缩放
    sc1.delegate = self;
    sc1.minimumZoomScale = 1;
    sc1.maximumZoomScale = 2;
    
    [sc1 addSubview:imgView1];
    [self addScrollerSubView:sc1];
  
    //6 填充图片
    
    for (int i = 0; i < self.number; i++) {
        UIImage *img = [UIImage imageNamed:[arr objectAtIndex:i]];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgView.image = img;
        //6 填充图片
        
        UIScrollView *sctemp = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.size.width  * (i+1), 0, self.frame.size.width, self.frame.size.height)];
        //缩放
        sctemp.delegate = self;
        sctemp.minimumZoomScale = 1;
        sctemp.maximumZoomScale = 2;
        
        sctemp.tag = i+1;

        
        [sctemp addSubview:imgView];
        [self addScrollerSubView:sctemp];
    
        
    }
    
    UIImage *img2 = [UIImage imageNamed:[arr objectAtIndex:0]];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgView2.image = img2;


    UIScrollView *sc2 = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.size.width  * (self.number+1), 0, self.frame.size.width, self.frame.size.height)];

    //缩放
    sc2.delegate = self;
    sc2.minimumZoomScale = 1;
    sc2.maximumZoomScale = 2;
  
    
    [sc2 addSubview:imgView2];
    [self addScrollerSubView:sc2];
    

    
    NSLog(@"%ld",[self.uiScrolView.subviews count]);
    
    
}



#pragma -mark scrollerView代理方法
//最重要一个 一旦滚动就会执行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//   self.pageControl.currentPage = scrollView.contentOffset.x/self.frame.size.width -1;//这种方式在后退的时候小圆点会动的比较快
 
}
//减速结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动的时候设置下面的小圆点
    self.pageControl.currentPage = scrollView.contentOffset.x/self.frame.size.width -1;//这种方式改变如果快速切图,小圆点会忽然跳跃过去
    
    if (scrollView.contentOffset.x == self.frame.size.width * (self.number+1)) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.pageControl.currentPage = 0;
    }else if(scrollView.contentOffset.x == 0){
        scrollView.contentOffset = CGPointMake(self.frame.size.width * self.number, 0);
        self.pageControl.currentPage = self.number;
    }
    
    //还原缩放
    for (UIView *view in scrollView.subviews) {
        //不缩放时要注释
        if (view.tag == self.indexZoom) {
           ((UIScrollView *)view).zoomScale = 1.0;
            break;
        }
 
    }
    
}
//控制缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    self.indexZoom = (int)scrollView.tag;
//    NSLog(@"当前未第%d个图像",self.indexZoom);
    //
//    self.pageControl.currentPage = self.indexZoom - 1;
    return [[scrollView subviews] objectAtIndex:0];//返回操作的是第几个view
}


//点击小圆点
-(void)clickMe:(UIPageControl *)pg
{
//    NSLog(@"%ld", pg.currentPage);
    //动画换页
    [self.uiScrolView setContentOffset:CGPointMake(self.frame.size.width * (pg.currentPage+1), 0) animated:YES];
}


@end
