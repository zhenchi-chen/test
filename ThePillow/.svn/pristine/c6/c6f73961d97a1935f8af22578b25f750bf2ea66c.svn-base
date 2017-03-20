//
//  SleepStatus.m
//  KIDS
//
//  Created by 陈镇池 on 16/8/17.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "SleepStatus.h"
#import "ItemsModel.h"
#import "SleepStCell.h"
#import "KIDS-Bridging-Header.h"
#import "CardChartView.h"
#import "IntAxisValueFormatter.h"
#import "IntYAxisValueFormatter.h"

@interface SleepStatus ()<UITableViewDelegate,UITableViewDataSource,ChartViewDelegate>
{
    UIView *headerView;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *itemsArray; //items数组

@property (nonatomic,strong)NSMutableArray *dataArray;//睡眠状态列表数据

@property (nonatomic,strong)NSMutableArray *yVals; //y轴的数据
@property (nonatomic,strong)NSMutableArray *xVals; //x轴的数据
@property(strong,nonatomic)CardChartView *chartViewSleepST; //睡眠状态
@property (nonatomic,strong)NSMutableArray *sleepSTArr; //睡眠状态图表数据
@property (nonatomic,strong)NSMutableArray *dataSleepST; //睡眠状态数据
@property (nonatomic,strong)NSMutableArray *zeroLineVals; //x轴的固定label数据


@end

@implementation SleepStatus

#pragma mark 初始化睡眠状态图标
- (void)setHeaderView {
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 300*Height)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    _chartViewSleepST = [[CardChartView alloc]initWithFrame:CGRectMake(5, 10, MainScreenWidth-10, 300)];
    _chartViewSleepST.lineChartView.frame = CGRectMake(0,30, MainScreenWidth, 150);
    _chartViewSleepST.lineChartView.delegate = self;
    [headerView addSubview:_chartViewSleepST];
    
    
    _chartViewSleepST.lineChartView.scaleXEnabled = NO;//取消X轴缩放
    
    ChartYAxis *leftAxis = _chartViewSleepST.lineChartView.leftAxis;//获取左边Y轴
    leftAxis.axisMinValue = -0.5;//设置Y轴的最小值
    leftAxis.axisMaxValue = 2.5;//设置Y轴的最大值
    leftAxis.labelCount = 3;
    leftAxis.labelTextColor = [UIColor blackColor];
    leftAxis.drawLabelsEnabled = YES; //不显示文字
    leftAxis.drawAxisLineEnabled = NO; //不显示线
    leftAxis.valueFormatter = [[IntYAxisValueFormatter alloc]initWithYArr:_yVals];
    
    //X轴样式
    ChartXAxis *xAxisBar = _chartViewSleepST.lineChartView.xAxis;
    xAxisBar.drawAxisLineEnabled = NO; //不显示线
    xAxisBar.drawLabelsEnabled = NO; //不显示文字
    
    IntAxisValueFormatter *xValueFormatter = [[IntAxisValueFormatter alloc]initWithArr:_xVals];
    _chartViewSleepST.lineChartView.xAxis.valueFormatter = xValueFormatter;
    
    
    _chartViewSleepST.titleLb.text = NSLocalizedString(@"detail_fragment_sleep_statu",nil);
    _chartViewSleepST.averageLb.text = NSLocalizedString(@"detail_fragment_golden_sleep",nil);
    _chartViewSleepST.hrMaxLb.text = NSLocalizedString(@"detail_fragment_ss",nil);
    _chartViewSleepST.hrMinLb.text = NSLocalizedString(@"detail_fragment_rem",nil);
    

    //无人
    NSString *wakeUnitStr = NSLocalizedString(@"detail_fragment_minute",nil);
    NSMutableAttributedString *strWake = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",_detailModrel.rem,wakeUnitStr]];
    [strWake addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,_detailModrel.rem.length)];
    [strWake addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(_detailModrel.rem.length,wakeUnitStr.length)];
    if (_detailModrel.rem == nil) {
        _chartViewSleepST.minLb.text = @"0";
    }else {
        _chartViewSleepST.minLb.attributedText = strWake;
    }
    
    //睡眠
    NSMutableAttributedString *strSleep = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",_detailModrel.s3,wakeUnitStr]];
    [strSleep addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:35] range:NSMakeRange(0,_detailModrel.s3.length)];
    [strSleep addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(_detailModrel.s3.length,wakeUnitStr.length)];
    if (_detailModrel.s3 == nil) {
        _chartViewSleepST.midLb.text = @"0";
    }else {
        _chartViewSleepST.midLb.attributedText = strSleep;
    }
    
    //离床
    NSMutableAttributedString *strOff_bed_count = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",_detailModrel.sws,wakeUnitStr]];
    [strOff_bed_count addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,_detailModrel.sws.length)];
    [strOff_bed_count addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(_detailModrel.sws.length,wakeUnitStr.length)];
    if (_detailModrel.sws == nil) {
        _chartViewSleepST.maxLb.text = @"0";
    }else {
        _chartViewSleepST.maxLb.attributedText = strOff_bed_count;
    }
    
    headerView.height = height_y(_chartViewSleepST);
}

#pragma mark 为心率图设置数据
- (LineChartData *)setDataArry:(NSMutableArray *)array {
    
   
    //将 LineChartDataSet 对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    for (int i = 0; i<array.count; i++) {
        //创建LineChartDataSet对象
        LineChartDataSet *set1  = [[LineChartDataSet alloc]initWithValues:array[i]];
        set1.drawSteppedEnabled = YES; //步线
        set1.drawValuesEnabled = NO; //是否显示数据数字
        if (array.count-1 == i) {
            [set1 setColor:[UIColor clearColor]];//折线颜色
        }else {
            [set1 setColor:MainColor];//折线颜色48,176,255
        }
        
        set1.lineWidth = 2.0;//折线宽度
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawCircleHoleEnabled = NO;//是否绘制中间的空心
        set1.valueColors = @[[UIColor whiteColor]];//折线拐点处显示数据的颜色
        //点击选中拐点的交互样式
        set1.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
        
        _chartViewSleepST.lineChartView.xAxis.drawLabelsEnabled = YES; //显示文字
        set1.valueTextColor = [UIColor blackColor];//文字颜色
        
        
        
        //插入对象不为空
        if (set1) {
            [dataSets addObject:set1];
        }
    }
    
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];

    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:6.f]];//文字字体
    [data setValueTextColor:[UIColor clearColor]];//文字颜色

    
    return data;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self navSet:@"睡眠统计"];
    //处理数据
    _dataArray = [NSMutableArray array];
    _itemsArray = [NSMutableArray array];
    for (NSDictionary *tempDic in _detailModrel.items) {
        ItemsModel *itemsModel = [ItemsModel objectWithKeyValues:tempDic];
        [_itemsArray addObject:itemsModel];
    }
    //y轴上面需要显示的数据
    _yVals = [[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"detail_fragment_sleep_statu_none",nil),NSLocalizedString(@"detail_fragment_sleep_statu_awake",nil),NSLocalizedString(@"detail_fragment_sleep_statu_sleep",nil), nil];
    //X轴上面需要显示的数据
    _xVals = [NSMutableArray array];
    _zeroLineVals = [NSMutableArray array];
    for (int i = 0; i <= 64800; i += 1800) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:36000 + i];
        NSString *a = [[NSString alloc] initWithDate:date format:@"H:mm"];
        [_xVals addObject:a];
        
        ChartDataEntry *entryLine = [[ChartDataEntry alloc] initWithX:i/1800 y:0];
        [_zeroLineVals addObject:entryLine];
    }
    
    [self sleepSTDealData];

    
    for (NSDictionary *dic in _detailModrel.status.items) {
        if (_detailModrel.status.items == 0) {
            return;
        }
        ItemsModel *model = [[ItemsModel alloc]init];
        NSString *status = [dic valueForKey:@"status"];
        if ([status isEqualToString:@"onbed"]) {
            model.status = NSLocalizedString(@"sleep_statu_fragment_onbed",nil);
        }else if ([status isEqualToString:@"offbed"]) {
            model.status = NSLocalizedString(@"sleep_statu_fragment_offbed",nil);
        }else {
            model.status = status;
        }
       
        NSString *dateTime = [dic valueForKey:@"time"];
        NSString *tempTime = [dateTime stringByReplacingCharactersInRange:NSMakeRange(10, 1) withString:@" "];
        NSDateFormatter *dateFm= [[NSDateFormatter alloc]init];
        [dateFm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* date = [dateFm dateFromString:tempTime];
//        NSLog(@"date = %@", date);
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        model.time = timeSp;
//        NSLog(@"tempTime = %@",tempTime);
//        NSLog(@"timeSp = %@",timeSp);
        [_dataArray addObject:model];
    }
    
    //睡眠状态图表
    [self setHeaderView];
    
   
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, MainScreenWidth, MainScreenHeight -64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
    _chartViewSleepST.lineChartView.data = [self setDataArry:_dataSleepST];
    [_chartViewSleepST.lineChartView animateWithYAxisDuration:2.0f];
    
    
}

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.dataArray.count;
    return _dataArray.count;
}

#pragma -mark创建每个cell的方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"Cell";
    SleepStCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[SleepStCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    ItemsModel *model = [_dataArray objectAtIndex:indexPath.row];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time integerValue]];
    cell.timeLb.text = [[NSString alloc] initWithDate:confromTimesp format:@"HH:mm"];
    cell.statusLb.text = model.status;
    NSInteger tempTime;
    if (indexPath.row != _dataArray.count-1) {
        ItemsModel *model1 = [_dataArray objectAtIndex:indexPath.row+1];
        tempTime = [model1.time integerValue];
        
    }
    NSInteger gapTime = tempTime - [model.time integerValue];
    
    CGFloat height = 70;
    if (gapTime >5400) {
        height = height*2;
    }else if ((gapTime>1800) && (gapTime <5400)) {
       height = height*1.5;
    }
    cell.midLine.height = height -22;
    cell.timeGapLb.centerY = cell.midLine.centerY;

    NSString *h = [NSString stringWithFormat:@"%ld",gapTime / 3600];
    NSString *m = [NSString stringWithFormat:@"%ld",(gapTime / 60) % 60];
    NSString *s = [NSString stringWithFormat:@"%ld",gapTime % 60];
//    NSLog(@"%@小时 %@分钟 %@秒 %ld时间差",h,m,s,(long)gapTime);
    if (gapTime < 60) {
        NSString *breatheStr = NSLocalizedString(@"item_sleep_statu_second",nil);
        NSMutableAttributedString *strBreathe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",s,breatheStr]];
        [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0,s.length)];
        [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(s.length,breatheStr.length)];
        cell.timeGapLb.attributedText = strBreathe;
        
    }else if (gapTime > 60 && gapTime < 3600) {
        NSString *breatheStr = NSLocalizedString(@"item_sleep_statu_min",nil);
        NSMutableAttributedString *strBreathe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",m,breatheStr]];
        [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0,m.length)];
        [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(m.length,breatheStr.length)];
        cell.timeGapLb.attributedText = strBreathe;
    }else {
        
        NSString *mStr = NSLocalizedString(@"item_sleep_statu_min",nil);
        NSString *hStr = NSLocalizedString(@"item_sleep_statu_hour",nil);
        if ([m integerValue] != 0) {
            NSMutableAttributedString *strBreathe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",h,hStr,m,mStr]];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0,h.length)];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(h.length,hStr.length)];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(hStr.length+h.length,m.length)];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(m.length+hStr.length+h.length,mStr.length)];
            cell.timeGapLb.attributedText = strBreathe;
        }else {
            NSMutableAttributedString *strBreathe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",h,hStr]];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0,h.length)];
            [strBreathe addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(h.length,hStr.length)];
            cell.timeGapLb.attributedText = strBreathe;
        }
       
    }
    
    cell.midLine.backgroundColor = MainColor;
    cell.openLine.backgroundColor = [UIColor whiteColor];
    cell.closeLine.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
        cell.openLine.backgroundColor = RGB(199, 199, 199);
    }
    if (indexPath.row == _dataArray.count-1) {
        cell.closeLine.backgroundColor = RGB(199, 199, 199);
        cell.midLine.backgroundColor = [UIColor whiteColor];
        cell.timeGapLb.text = @"";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
    
}



#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemsModel *model1;
    if ((_dataArray.count == 1) || (indexPath.row == _dataArray.count-1)) {
        model1=[_dataArray objectAtIndex:indexPath.row];
    }else {
        model1=[_dataArray objectAtIndex:indexPath.row+1];
    }
    ItemsModel *model = [_dataArray objectAtIndex:indexPath.row];
    NSInteger time = [model.time integerValue];

    
    CGFloat height = 70;
    if ([model1.time integerValue] - time >5400) {
        return height*2;
    }else if (([model1.time integerValue] - time >1800) && ([model1.time integerValue] - time <5400)) {
        return height*1.5;
    }else {
        return height;
    }
    
    
}
//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 没有选中折线拐点时回调
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
   
}

#pragma mark 处理睡眠数据
- (void)sleepSTDealData {
    _sleepSTArr = [NSMutableArray array];
    _dataSleepST = [NSMutableArray array];
    for (int i = 0; i < _itemsArray.count; i++) {
        ItemsModel *model = [_itemsArray objectAtIndex:i];
        NSString *timeStr = [model.date substringWithRange:NSMakeRange(11, 5)];
        float timeData = [self transformationTime:timeStr];
        if (timeData<=12) {
            timeData += 24;
        }
        double tempStatus = [self numberTurnStatus:model.status];
        model.xIndex  = (timeData-18)/0.5;
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:(int)model.xIndex y:tempStatus];
        //插入对象不为空
        if (entry) {
            [_sleepSTArr addObject:entry];
        }
        
        
    }
    if (_sleepSTArr.count > 0) {
        [_dataSleepST addObject:_sleepSTArr];
    }
   
    [_dataSleepST addObject:_zeroLineVals];
    
}
#pragma mark 后台时间处理
- (float)transformationTime:(NSString *)time {
    if ([[time substringWithRange:NSMakeRange(3,2)] isEqualToString:@"00"]) {
        return [[time substringWithRange:NSMakeRange(0,2)] floatValue];
    }else {
        return [[time substringWithRange:NSMakeRange(0,2)] floatValue]+0.5;
    }
    
}

//状态转数字方便画图
- (double)numberTurnStatus:(NSString *)status {
    
    if ([status isEqualToString:@"sleep"]) {
        // 睡眠
        return 2;
    }else if ([status isEqualToString:@"wake"]) {
        // 清醒
        return 1;
    }else {
        // 无人
        return 0;
    }
}

@end
