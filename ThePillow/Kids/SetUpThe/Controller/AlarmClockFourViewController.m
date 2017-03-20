//
//  AlarmClockFourViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/15.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "AlarmClockFourViewController.h"
#import "AHRuler.h"
#import "GWXWDateUtil.h"


@interface AlarmClockFourViewController ()<AHRrettyRulerDelegate>
{
    UILabel *timeLb;
    AHRuler *rulerTime;
    DeviceModel *deviceModelTemp;
    Clock *clock;
    NSString *h;
    NSString *m;
}

@property (nonatomic,strong)ClockTimeModel *clockTimeModel;

@end

@implementation AlarmClockFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:@"闹钟配置完成"];
    
    deviceModelTemp = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:[de valueForKey:@"bind_deviceId"]];
    clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModelTemp.clock]];
    _clockTimeModel = [[ClockTimeModel alloc]init];
    
    //创建主页面
    [self createView];
  
    
}

#pragma mark 创建主页面
- (void)createView {
    
    UILabel *promptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width,30*Height, MainScreenWidth-40*Width, 0)];
    promptLb.font = [UIFont systemFontOfSize:16];
    promptLb.textAlignment = NSTextAlignmentCenter;
    promptLb.text = @"根据您的情况，我们安排\n了最佳叫醒时间";
    promptLb.numberOfLines = 0;//多行显示，计算高度
    promptLb.textColor = MainColorLightGrey;
    CGFloat heightLb = [UILabel getLabelHeight:16 labelWidth:promptLb.width content:promptLb.text];
    promptLb.height = heightLb;
    [self.view addSubview:promptLb];
    
    CGFloat spacing = 20*Height;
    //震动强度标题
    UILabel *timeTitleLb = [[UILabel alloc]init];
    timeTitleLb.y = height_y(promptLb)+spacing;
    timeTitleLb.text = @"每天";
    timeTitleLb.textColor = MainColorDarkGrey;
    timeTitleLb.font = [UIFont systemFontOfSize:18];
    // 根据字体得到NSString的尺寸
    CGSize timeTitleLbSize = [timeTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:timeTitleLb.font,NSFontAttributeName, nil]];
    timeTitleLb.size = timeTitleLbSize;
    timeTitleLb.centerX = self.view.centerX;
    [self.view addSubview:timeTitleLb];
    
    
    //震动强度
    timeLb = [[UILabel alloc]init];
    timeLb.centerX = timeTitleLb.centerX;
    timeLb.y = height_y(timeTitleLb)+5*Height;
//    timeLb.textColor = MainColorDarkGrey;
    timeLb.font = [UIFont systemFontOfSize:60];
    timeLb.text = @"07:00";
    // 根据字体得到NSString的尺寸
    CGSize timeLbSize = [timeLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:timeLb.font,NSFontAttributeName, nil]];
    timeLb.size = timeLbSize;
    [timeLb sizeToFit];
    [self.view addSubview:timeLb];
    
    
    CGFloat scaleHeight = 90;
    CGFloat scaleWidth = 220;
    
    // 2.创建 AHRuler 对象 并设置代理对象
    rulerTime = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(timeLb), scaleWidth, scaleHeight)];
    rulerTime.rulerMin = 0; //最小值
    rulerTime.isText = NO; //是否显示文字计数
    rulerTime.isRangingHeight = NO; //线是否等高
    rulerTime.rulerDeletate = self;
    rulerTime.isDisplayTags = YES; //是否显示标记
    rulerTime.distanceTopAndBottom = 20; //标尺上下距离
    [rulerTime showRulerScrollViewWithCount:308 average:[NSNumber numberWithFloat:1] currentValue:94 smallMode:YES];
    [self.view addSubview:rulerTime];
    
    timeLb.text = @"07:00";
    [timeLb sizeToFit];
    timeLb.centerX = timeTitleLb.centerX;
    
    //叫醒模式标题
    UILabel *stateTitleLb = [[UILabel alloc]init];
    stateTitleLb.y = height_y(rulerTime);
    stateTitleLb.text = @"叫醒模式";
    stateTitleLb.textColor = MainColorDarkGrey;
    stateTitleLb.font = [UIFont systemFontOfSize:16];
    // 根据字体得到NSString的尺寸
    CGSize stateTitleLbSize = [stateTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:stateTitleLb.font,NSFontAttributeName, nil]];
    stateTitleLb.size = stateTitleLbSize;
    stateTitleLb.centerX = self.view.centerX;
    [self.view addSubview:stateTitleLb];
    
    ConfigModel *clockMode = [ConfigModel objectWithKeyValues:clock.clockMode];
    //叫醒模式
    UILabel *stateLb = [[UILabel alloc]init];
    stateLb.y = height_y(stateTitleLb)+10;
    switch ([clockMode.select intValue]) {
        case 1:
            stateLb.text = @"轻度震动";
            break;
        case 2:
            stateLb.text = @"正常震动";
            break;
        case 3:
            stateLb.text = @"重度震动";
            break;
        case 4:
            stateLb.text = @"魔鬼震动";
            break;
        default:
            break;
    }
//    stateLb.textColor = MainColorDarkGrey;
    stateLb.font = [UIFont systemFontOfSize:25 weight:2];
    // 根据字体得到NSString的尺寸
    CGSize stateLbSize = [stateLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:stateLb.font,NSFontAttributeName, nil]];
    stateLb.size = stateLbSize;
    stateLb.centerX = self.view.centerX;
    [self.view addSubview:stateLb];
    
    UIButton *completeBt = [self buildBtn:@"完成" action:@selector(completeBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-180*Height, MainScreenWidth-170*Width,50*Height)];
    [self.view addSubview:completeBt];
    
}

#pragma mark 确认
- (void)completeBtAction:(UIButton *)button {
    //储存闹钟
    [self setClockTimeModelStorage];
    
    if ([[de valueForKey:@"bind_myTag"] intValue] == 3) {
        //返回到第一个页面
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        kAppDelegate.window.rootViewController = kAppDelegate.nc1;
        //返回到第一个页面
        [kAppDelegate.nc2 popToRootViewControllerAnimated:YES];
        
    }
    [GWNotification pushHandle:nil withName:@"返回首页"];
}

- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler{
    //    showLabel.text = [NSString stringWithFormat:@"%.fkg",rulerScrollView.rulerValue];
    NSLog(@"%f",rulerScrollView.rulerValue-10);
    NSLog(@"xx : %f",(rulerScrollView.rulerValue-10)*60-28800);
    
    if (ahRuler == rulerTime) {
        if ((rulerScrollView.rulerValue-10)<0) {
            timeLb.text = @"00:00";
        }else if ( (rulerScrollView.rulerValue-10)>=288) {
            timeLb.text = @"24:00";
        }else {
            NSInteger numbel = (rulerScrollView.rulerValue-10)*60*5;
            h = [NSString stringWithFormat:@"%ld",(numbel % 86400) / 3600];
            m = [NSString stringWithFormat:@"%ld",(((numbel % 86400) % 3600) / 60)];
            if (h.length == 1){
                h = [NSString stringWithFormat:@"0%@",h];
            }
            if (m.length == 1){
                m = [NSString stringWithFormat:@"0%@",m];
            }

//            NSString *ss = [[NSString alloc]initWithTimesp:-28800 format:@"HH:mm"];
//            NSLog(@"%@",ss);
            timeLb.text = [NSString stringWithFormat:@"%@:%@",h,m];
        }
        [timeLb sizeToFit];
        timeLb.centerX = self.view.centerX;
        
    }
    
}





#pragma mark 对模型赋值
- (void)setClockTimeModelStorage{
    
    _clockTimeModel.name = @"闹钟";
    _clockTimeModel.week = [_dateArray copy];
    _clockTimeModel.hour = h;
    _clockTimeModel.min = m;
    if (_dateArray.count == 0) {
        _clockTimeModel.times = @"1";
        _clockTimeModel.ringTime = [self calculateRingTimeHour:[h intValue] andMin:[m intValue]];
    }else {
        _clockTimeModel.times = @"30000";
        _clockTimeModel.ringTime = nil;
    }
    _clockTimeModel.run = @"1";
    
    NSMutableArray *_clockTimeArr = [clock.clockTime mutableCopy];
    NSDictionary *clockTimeDic = [_clockTimeModel keyValues];
    [_clockTimeArr addObject:clockTimeDic];
    clock.clockTime = _clockTimeArr;
    clock.isValid = @"0";
    NSDictionary *clockDic = [clock keyValues];

    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
}



#pragma mark 获取转化闹钟响的时间戳
- (NSString *)calculateRingTimeHour:(int)hours andMin:(int)min {
    
    //获取当前时间
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger yearNow = [dateComponent year];
    NSInteger monthNow = [dateComponent month];
    NSInteger dayNow = [dateComponent day];
    NSInteger hourNow = [dateComponent hour];
    NSInteger minuteNow = [dateComponent minute];
    //    NSLog(@"year is: %ld,month is: %ld,day is: %ld,hour is: %ld,minute is: %ld", (long)yearNow,(long)monthNow,(long)dayNow,(long)hourNow,(long)minuteNow);
    
    if (hours<hourNow) {
        dayNow = dayNow+1;
    }else {
        if (hours == hourNow) {
            if (min<=minuteNow) {
                dayNow = dayNow+1;
            }
        }
    }
    NSDate *ringDate = [GWXWDateUtil DateInitWithString:[NSString stringWithFormat:@"%ld-%ld-%ld %d:%d",(long)yearNow,(long)monthNow,(long)dayNow,hours,min] dateFormatterStr:@"yyyy-MM-dd H:m"];
    NSLog(@"%.f",[ringDate timeIntervalSince1970]);
    return [NSString stringWithFormat:@"%.f",[ringDate timeIntervalSince1970]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
