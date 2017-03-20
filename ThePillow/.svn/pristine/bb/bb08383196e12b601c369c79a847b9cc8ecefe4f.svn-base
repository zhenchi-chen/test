//
//  CardChartView.m
//  KIDS
//
//  Created by 陈镇池 on 16/8/12.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "CardChartView.h"

@implementation CardChartView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat szHeight = 30;  //需要换行的高度
        
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width, 20)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLb];
        
        
        _lineChartView = [[LineChartView alloc] init];
        [self addSubview:self.lineChartView];
        //基本样式
        _lineChartView.noDataText = @""; //无数据提示
        _lineChartView.borderColor  = [UIColor whiteColor];//背景颜色
        //交互样式
        self.lineChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.lineChartView.pinchZoomEnabled = NO; //捏合手势
        self.lineChartView.dragEnabled = YES;//启用拖拽图标
        self.lineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.lineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //X轴样式
        ChartXAxis *xAxis = self.lineChartView.xAxis;
        xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格
        xAxis.avoidFirstLastClippingEnabled = YES; //文字不超出
        xAxis.axisLineColor = [UIColor blackColor];
//        xAxis.labelCount = 9;//X显示个数
        xAxis.granularity = 1.0; //x间距
        xAxis.forceLabelsEnabled = YES; //x轴显示完整的坐标
//        [xAxis setLabelCount:6 force:YES];
        
        //Y轴样式
        self.lineChartView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = self.lineChartView.leftAxis;//获取左边Y轴
        leftAxis.drawGridLinesEnabled = NO;
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        //    leftAxis.forceLabelsEnabled = YES;//不强制绘制指定数量的label
//        leftAxis.axisMinValue = 40;//设置Y轴的最小值
//        leftAxis.axisMaxValue = 120;//设置Y轴的最大值
        leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
        
        //描述及图例样式
        [self.lineChartView setDescriptionText:@""];
        //    [self.chartView1 setDescriptionTextColor:[UIColor darkGrayColor]];
        self.lineChartView.legend.form = ChartLegendFormLine;
        self.lineChartView.legend.formSize = 30;
        self.lineChartView.legend.enabled = NO;
        
        _barChartView = [[CandleStickChartView alloc] init];
        [self addSubview:self.barChartView];
        //基本样式
        _barChartView.noDataText = @""; //无数据提示
        _barChartView.borderColor  = [UIColor whiteColor];//背景颜色
        //交互样式
        self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        self.barChartView.dragEnabled = YES;//启用拖拽图标
        self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //X轴样式
        ChartXAxis *xAxisBar = self.barChartView.xAxis;
        xAxisBar.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxisBar.drawGridLinesEnabled = NO;//不绘制网格
        xAxisBar.avoidFirstLastClippingEnabled = YES; //文字不超出
        xAxisBar.drawAxisLineEnabled = NO; //不显示线
        xAxisBar.forceLabelsEnabled = YES; //x轴显示完整的坐标
        xAxisBar.granularity = 1.0; //x间距
        //Y轴样式
        self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxisBar = self.barChartView.leftAxis;//获取左边Y轴
        leftAxisBar.drawGridLinesEnabled = NO;
        leftAxisBar.drawAxisLineEnabled = NO;
        leftAxisBar.drawLabelsEnabled = NO; //不显示文字
//        leftAxisBar.axisMinValue = 0;//设置Y轴的最小值
        
        ChartYAxis *rightAxis = _barChartView.rightAxis;
        rightAxis.enabled = NO;
        
        

        //描述及图例样式
        [self.barChartView setDescriptionText:@""];
        //    [self.chartView1 setDescriptionTextColor:[UIColor darkGrayColor]];
        self.barChartView.legend.form = ChartLegendFormLine;
        self.barChartView.legend.formSize = 30;
        self.barChartView.legend.enabled = NO;
        
        
        //平均分
        _averageLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_titleLb)+160, width, 20)];
        _averageLb.text = NSLocalizedString(@"detail_fragment_avg",nil);
        _averageLb.font = [UIFont systemFontOfSize:20];
        _averageLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_averageLb];
        
        _midLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_averageLb)+10, MainScreenWidth/3, 40)];
        _midLb.centerX = _averageLb.centerX;
        _midLb.textAlignment = NSTextAlignmentCenter;
        _midLb.font = [UIFont systemFontOfSize:40];
        [self addSubview:_midLb];
        
        //最高值
        _hrMaxLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_averageLb), MainScreenWidth/3, szHeight)];
//        _hrMaxLb.centerX = width/4;
        _hrMaxLb.text = NSLocalizedString(@"detail_fragment_max",nil);
        _hrMaxLb.textAlignment = NSTextAlignmentCenter;
        _hrMaxLb.font = [UIFont systemFontOfSize:12];
        _hrMaxLb.numberOfLines = 2;//根据最大行数需求来设置
        [self addSubview:_hrMaxLb];
        
        _maxLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_hrMaxLb)+10, _midLb.width, 20)];
        _maxLb.centerX = _hrMaxLb.centerX;
        _maxLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_maxLb];
        
        //最低值
        _hrMinLb = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth*2/3, height_y(_averageLb), _maxLb.width, szHeight)];
//        _hrMinLb.centerX = width/4*3;
        _hrMinLb.text = NSLocalizedString(@"detail_fragment_min",nil);
        _hrMinLb.textAlignment = NSTextAlignmentCenter;
        _hrMinLb.font = [UIFont systemFontOfSize:12];
        _hrMinLb.numberOfLines = 2;//根据最大行数需求来设置
        [self addSubview:_hrMinLb];
        
        _minLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(_hrMinLb)+10, _midLb.width, 20)];
        _minLb.centerX = _hrMinLb.centerX;
        _minLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_minLb];
        
    }
    return self;
}


@end
