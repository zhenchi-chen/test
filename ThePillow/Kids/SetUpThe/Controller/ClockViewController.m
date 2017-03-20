//
//  ClockViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "ClockViewController.h"
#import "AHRuler.h"
#import "GWXWDateUtil.h"

@interface ClockViewController ()<UITextFieldDelegate,AHRrettyRulerDelegate>
{
    UITextField *clockTF; //闹钟名字
    UILabel *chooseTitleLb; //选择星期
    AHRuler *rulerTime; //选择时间
    UILabel *timeLb; //时间
    Clock *clock;
    
}
@property (nonatomic,strong)NSMutableArray *btArray; //按钮数组
@property (nonatomic,strong)NSMutableArray *selectedBtArray; //选择按钮数组
@property (nonatomic,strong)NSArray *titleArray; //星期数组
@property (nonatomic,strong)NSArray *weekArr; //星期数组
@property (nonatomic,strong)NSString *hour; //小时
@property (nonatomic,strong)NSString *min; //分钟
@property (nonatomic,strong)NSString *times; //闹钟次数,是否循环

@property (nonatomic,strong)ClockTimeModel *clockTimeModel;

@property (nonatomic,strong)NSMutableArray *clockTimeArr; //闹钟数组

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:@"闹钟"];
    _btArray = [[NSMutableArray alloc]init];
    _weekArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    _titleArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    
    deviceModel = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_deviceDid];
    
    clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.clock]];
    _clockTimeArr = [NSMutableArray array];
    _clockTimeArr = [clock.clockTime mutableCopy];
    
    if (_isAddClock) {
        _clockTimeModel = [[ClockTimeModel alloc]init];
    }else {
        _clockTimeModel = [ClockTimeModel objectWithKeyValues:_clockTimeArr[_numberTag]];;
    }
    
    [self initView];
 
    
}

#pragma mark 初始化界面
-(void)initView{
    
    //闹钟名字
    clockTF = [[UITextField alloc]initWithFrame:CGRectMake(20*Width, 20*Height, MainScreenWidth-40*Width, 50)];
    clockTF.clearsOnBeginEditing = YES;
    clockTF.clearButtonMode = UITextFieldViewModeAlways;
    clockTF.delegate = self;
    clockTF.textColor = [UIColor blackColor];
    clockTF.placeholder = @"标签";
    clockTF.tag = 1;
    clockTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    clockTF.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:clockTF];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(clockTF.x, height_y(clockTF), clockTF.width, 1)];
    line.backgroundColor = MainColorBlack;
    [self.view addSubview:line];
    
    //震动时间
    chooseTitleLb = [[UILabel alloc]init];
    chooseTitleLb.y = height_y(line)+30;
    chooseTitleLb.textColor = MainColorDarkGrey;
    chooseTitleLb.font = [UIFont systemFontOfSize:16];
    if (_isAddClock) {
        clockTF.text = @"闹钟";
        chooseTitleLb.text = @"每天";
        _times = @"30000";
        _selectedBtArray = [_weekArr copy];
    }else {
        clockTF.text = _clockTimeModel.name;
//        NSString *title = [self getClockDayStringArray:_clockTimeModel.week];
//        NSLog(@"%@",title);
        chooseTitleLb.text = [self getClockDayStringArray:_clockTimeModel.week];
        _times = _clockTimeModel.times;
        _selectedBtArray = _clockTimeModel.week;
    }
    
    // 根据字体得到NSString的尺寸
    CGSize chooseTitleLbSize = [chooseTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:chooseTitleLb.font,NSFontAttributeName, nil]];
    chooseTitleLb.size = chooseTitleLbSize;
    [chooseTitleLb sizeToFit];
    [self.view addSubview:chooseTitleLb];
    chooseTitleLb.centerX = self.view.centerX;
 
    CGFloat spacing = (MainScreenWidth - 280)/2;
    for (int i=0; i<_titleArray.count; i++) {
        
        UIButton *nvBt = [UIButton buttonWithType:UIButtonTypeCustom];
        nvBt.frame = CGRectMake(spacing + i*40, height_y(chooseTitleLb)+10*Height, 37, 37);
        if (!_isAddClock) {
            for (int j=0; j<_clockTimeModel.week.count; j++) {
                if ([_weekArr containsObject: _clockTimeModel.week[j]]) {
                    int tempTag = [[_clockTimeModel.week objectAtIndex:j] intValue]-1;
                    if (tempTag == i) {
                        nvBt.selected = NO;
                        nvBt.backgroundColor = MainColor;
                        break;
                    }else {
                        nvBt.selected = YES;
                        nvBt.backgroundColor = MainColorWhite;
                    }
                    
                }
            }
        }else {
            nvBt.backgroundColor = MainColor;
            nvBt.selected = NO;
        }
        nvBt.titleLabel.font = [UIFont systemFontOfSize:18];
        nvBt.layer.cornerRadius = nvBt.width/2;
        nvBt.clipsToBounds = YES;
        [nvBt setTitleColor:MainColorWhite forState:UIControlStateNormal];
        [nvBt setTitleColor:MainColorDarkGrey forState:UIControlStateSelected];
        [nvBt setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        nvBt.tag = i;
        [nvBt addTarget:self action:@selector(nvBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nvBt];
        [_btArray addObject:nvBt];
        
    }

    
    //震动强度
    timeLb = [[UILabel alloc]init];
    timeLb.y = height_y(chooseTitleLb)+80*Height+40;
    timeLb.textColor = MainColorDarkGrey;
    timeLb.font = [UIFont systemFontOfSize:50];
    
    CGFloat choose;
    if (_isAddClock) {
        timeLb.text = @"07:00";
        choose = 94;
    }else {
        [_clockTimeModel.hour floatValue];
        [_clockTimeModel.min floatValue];
        choose = [_clockTimeModel.hour floatValue]*12+[_clockTimeModel.min floatValue]/5+10;
        
        NSString *hourText;
        NSString *minText;
        if (_clockTimeModel.hour.length == 1){
            hourText = [NSString stringWithFormat:@"0%@",_clockTimeModel.hour];
        }
        if (_clockTimeModel.min.length == 1){
            minText = [NSString stringWithFormat:@"0%@",_clockTimeModel.min];
        }

        timeLb.text = [NSString stringWithFormat:@"%@:%@",hourText,minText];
    }
    
    // 根据字体得到NSString的尺寸
    CGSize timeLbSize = [timeLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:timeLb.font,NSFontAttributeName, nil]];
    timeLb.size = timeLbSize;
    [timeLb sizeToFit];
    timeLb.centerX = clockTF.centerX;
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
    [rulerTime showRulerScrollViewWithCount:308 average:[NSNumber numberWithFloat:1] currentValue:choose smallMode:YES];
    [self.view addSubview:rulerTime];
    

    
    UIButton *deleteClockBt = [self buildBtn:@"删除闹钟" action:@selector(deleteClockBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-180*Height, MainScreenWidth-160*Width,50*Height)];
    deleteClockBt.backgroundColor = [UIColor redColor];
    [self.view addSubview:deleteClockBt];
    
    
}

#pragma mark 删除闹钟
- (void)deleteClockBtAction:(UIButton *)button {
    
    
    
    if (_isAddClock) {
        //返回到上一个页面
        [self.navigationController popViewControllerAnimated:YES];
        return;
    } else {
        [_clockTimeArr removeObjectAtIndex:_numberTag];
    }
    clock.clockTime = _clockTimeArr;
    NSDictionary *clockDic = [clock keyValues];
    
//    deviceModel.clock = [GWNSStringUtil convertToJSONString:clockDic];
//    NSLog(@"clock = %@",deviceModel.clock);
    
    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
    
    [GWNotification pushHandle:nil withName:@"闹钟参数修改"];
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 导航按钮执行方法
- (void)nvBtAction:(UIButton *)button {

    if (button.selected == NO) {
        button.backgroundColor = MainColorWhite;
        button.selected = YES;
    }else {
        button.backgroundColor = MainColor;
        button.selected = NO;
    }
    _selectedBtArray = [[NSMutableArray alloc]init];
    for (int i= 0; i<_btArray.count; i++) {
        UIButton *bt = [_btArray objectAtIndex:i];
        if (!bt.selected) {
            [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }

    if (_selectedBtArray.count == 0) {
        _times = @"1";
    } else {
        _times = @"30000";
    }
    chooseTitleLb.text = [self getClockDayStringArray:_selectedBtArray];
    [chooseTitleLb sizeToFit];
    chooseTitleLb.centerX = self.view.centerX;
    
}

#pragma mark 选择显示的星期
- (NSString *)getClockDayStringArray:(NSMutableArray *) array{
    
    NSMutableString *allTextStr = [NSMutableString string];
    if (array.count == 0) {
        return @"只响一次";
    }else if (array.count == 1) {
        return [NSString stringWithFormat:@"每周%@",[_titleArray objectAtIndex:[array[0] integerValue]-1]];
    }else if (array.count == 7) {
        return @"每天";
    }else {
        for (int i= 0; i<array.count; i++) {
            if ([_weekArr containsObject: array[i]]) {
                int tempTag = [[array objectAtIndex:i] intValue];
                [allTextStr appendFormat:@"周%@",[_titleArray objectAtIndex:tempTag-1]];
                [allTextStr appendFormat:@" "];
            }
        }
        if ([allTextStr isEqualToString:[NSString stringWithFormat:@"周%@ 周%@ ",_titleArray[5],_titleArray[6]]]) {
            return @"每个周末";
        }
        if ([allTextStr isEqualToString:[NSString stringWithFormat:@"周%@ 周%@ 周%@ 周%@ 周%@ ",_titleArray[0],_titleArray[1],_titleArray[2],_titleArray[3],_titleArray[4]]]) {
            return @"每个工作日";
        }
        return [allTextStr substringToIndex:[allTextStr length] - 1];
    }
}


- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler{
    //    showLabel.text = [NSString stringWithFormat:@"%.fkg",rulerScrollView.rulerValue];
//    NSLog(@"%f",rulerScrollView.rulerValue-10);
//    NSLog(@"xx : %.f小时,%.f分钟,%.f秒",(rulerScrollView.rulerValue-10)*5/60,(rulerScrollView.rulerValue-10)*5,(rulerScrollView.rulerValue-10)*5*60);
    
    if (ahRuler == rulerTime) {
        if ((rulerScrollView.rulerValue-10)<=0) {
            timeLb.text = @"00:00";
        }else if ( (rulerScrollView.rulerValue-10)>=288) {
            timeLb.text = @"24:00";
        }else {
            NSInteger numbel = (rulerScrollView.rulerValue-10)*60*5;
            NSString *h = [NSString stringWithFormat:@"%ld",(numbel % 86400) / 3600];
            NSString *m = [NSString stringWithFormat:@"%ld",(((numbel % 86400) % 3600) / 60)];
            
            _hour = h;
            _min = m;
            
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


//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 返回上一个页面
- (void)navigationLeftButton:(UIButton *)button {
    if (clockTF.text.length == 0) {
        clockTF.text = @"闹钟";
    }
    NSInteger num = 0;
    if (!_isAddClock) {
        if ([self privateBooleanIsSame]) {
            if (![_clockTimeModel.name isEqualToString:clockTF.text] ) {
                _clockTimeModel.name = clockTF.text;
                num = 1;
            }else {
                //返回到上一个页面
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
    
    }
    
    [self setClockTimeModel];
    [self setStorageDataNum:num];
    [GWNotification pushHandle:nil withName:@"闹钟参数修改"];
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 对模型赋值
- (void)setClockTimeModel{
   
    _clockTimeModel.name = clockTF.text;
    _clockTimeModel.week = [_selectedBtArray copy];
    _clockTimeModel.hour = _hour;
    _clockTimeModel.min = _min;
    _clockTimeModel.times = _times;
    if ([_times isEqualToString:@"1"]) {
        _clockTimeModel.ringTime = [self calculateRingTimeHour:[_hour intValue] andMin:[_min intValue]];
    }else {
        _clockTimeModel.ringTime = nil;
    }
    
    _clockTimeModel.run = @"1";
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

#pragma mark 储存修改信息
- (void)setStorageDataNum:(NSInteger)tag {
    
    clock.isValid = [NSString stringWithFormat:@"%ld",(long)tag];
    
    _clockTimeArr = [clock.clockTime mutableCopy];
    NSDictionary *clockTimeDic = [_clockTimeModel keyValues];
    if (_isAddClock) {
        [_clockTimeArr addObject:clockTimeDic];
    } else {
        _clockTimeArr[_numberTag] = clockTimeDic;
    }
    clock.clockTime = _clockTimeArr;
    NSDictionary *clockDic = [clock keyValues];
    
//    deviceModel.clock = [GWNSStringUtil convertToJSONString:clockDic];
//    NSLog(@"clock = %@",deviceModel.clock);
    
    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModel andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
    
}

#pragma mark 判断蓝牙同步的数据是否改变
- (BOOL)privateBooleanIsSame {
//    NSLog(@"%@=%@?",_clockTimeModel.hour,_hour);
    if (![_clockTimeModel.hour isEqualToString:_hour]) {
        return NO;
    }
    if (![_clockTimeModel.min isEqualToString:_min]) {
        return NO;
    }
    if (![self compareOldArray:_clockTimeModel.week andNewArray:_selectedBtArray]) {
        return NO;
    }
    return YES;
}

#pragma mark
- (BOOL)compareOldArray:(NSMutableArray *)oldArr andNewArray:(NSMutableArray *)newArr{
    
    bool bol = false;
    
    //对数组1排序。
    [oldArr sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
        return obj1 > obj2;
    }];
    
    //对数组2排序。
    [newArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return obj1 > obj2;
    }];
    
    if (newArr.count == oldArr.count) {
        bol = true;
        for (int16_t i = 0; i < oldArr.count; i++) {
            id c1 = [oldArr objectAtIndex:i];
            id newc = [newArr objectAtIndex:i];
            
            if (![newc isEqualToString:c1]) {
                bol = false;
                break;
            }
        }
    }
    
    if (bol) {
//        NSLog(@"两个数组的内容相同！");
        return YES;
    }   
    else {   
//        NSLog(@"两个数组的内容不相同！");
        return NO;
    }  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
