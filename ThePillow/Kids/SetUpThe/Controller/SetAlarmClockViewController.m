//
//  SetAlarmClockViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetAlarmClockViewController.h"
#import "ClockViewController.h"
#import "SetAlarmClockCell.h"
#import "ClockVibrationSettingViewController.h"
#import "AlarmClockThreeViewController.h"

@interface SetAlarmClockViewController ()<UITableViewDataSource,UITableViewDelegate,SwitchingSetAlarmClockCellDelegate>
{
    UIButton *rightBt;
    UIView *footerView;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *clockTime;

@end

@implementation SetAlarmClockViewController


#pragma mark 页面即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [GWStatisticalUtil onPageViewBegin:self withName:@"闹钟设置页"];
    
    
    
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"闹钟设置"];
    
 
    
    _device = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_device.did];
    Clock *clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.clock]];
    _clockTime = [NSMutableArray arrayWithArray:clock.clockTime];
    
    for (int i = 0; i<_clockTime.count; i++) {
        ClockTimeModel *clockTimeModel =[ClockTimeModel objectWithKeyValues:_clockTime[i]];
        if ([clockTimeModel.times isEqualToString:@"1"] && [clockTimeModel.run isEqualToString:@"1"]) {
            if ([clockTimeModel.ringTime longLongValue] < [[NSDate date] timeIntervalSince1970]) {
                clockTimeModel.run = @"0";
                _clockTime[i] = [clockTimeModel keyValues];
                clock.clockTime = _clockTime;
                NSDictionary *clockDic = [clock keyValues];
                
                //    _device.clock = [GWNSStringUtil convertToJSONString:clockDic];
                //    NSLog(@"clock = %@",_device.clock);
                
                [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
                

            }
        }
    }
    
    //导航右边按钮
    rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    if (_clockTime.count < 4) {
        [rightBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        rightBt.userInteractionEnabled = YES;
    }else {
        [rightBt setImage:[UIImage imageNamed:@"无效"] forState:UIControlStateNormal];
        rightBt.userInteractionEnabled = NO;
    }
    [rightBt addTarget:self action:@selector(navigationButtonsRightBt:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        
        _device = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_device.did];
        Clock *clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.clock]];
        _clockTime = [NSMutableArray arrayWithArray:clock.clockTime];

        if (_clockTime.count < 4) {
            [rightBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            rightBt.userInteractionEnabled = YES;
        }else {
            [rightBt setImage:[UIImage imageNamed:@"无效"] forState:UIControlStateNormal];
            rightBt.userInteractionEnabled = NO;
        }

        [_tableView reloadData];
        
    } withName:@"闹钟参数修改"];
    
    [self initFooterView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 1)];
    line.backgroundColor = MainColorLightGrey;
    [self.view addSubview:line];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, MainScreenWidth, MainScreenHeight-90-64)];
//    _tableView.backgroundColor = MainColorLightGrey;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark 加载FooterView
- (void)initFooterView
{
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenHeight-90-64, MainScreenWidth, 90)];
//    footerView.backgroundColor = MainColorLightGrey;
    
    UIButton *setClockBt = [self buildBtn:@"闹钟震动强度设置"action:@selector(setClockBtAction:) frame:CGRectMake(MainScreenWidth/4, 20, MainScreenWidth/2, 50)];
    [footerView addSubview:setClockBt];
    
    [self.view addSubview:footerView];
    
}

#pragma mark 闹钟震动强度设置
- (void)setClockBtAction:(UIButton *)button {
    
    ClockVibrationSettingViewController *clockVibrationSettingVC = [[ClockVibrationSettingViewController alloc]init];
    clockVibrationSettingVC.deviceDid = _device.did;
    [self.navigationController pushViewController:clockVibrationSettingVC animated:YES];
    
}

#pragma -mark 添加闹钟
- (void)navigationButtonsRightBt:(UIButton *)button {
    
    if (_clockTime.count < 4) {
        [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;
//        AlarmClockThreeViewController
        ClockViewController *clockViewController = [[ClockViewController alloc]init];
        clockViewController.isAddClock = YES;
        clockViewController.deviceDid = _device.did;
        [self.navigationController pushViewController:clockViewController animated:YES];
    }else {
        [button setImage:[UIImage imageNamed:@"无效"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
    }
    
}

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _clockTime.count;
    
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    SetAlarmClockCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[SetAlarmClockCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    NSDictionary *tempClockTimeDic = [_clockTime objectAtIndex:indexPath.row];
    ClockTimeModel *clockTimeModel = [self modelConversionDictionary:tempClockTimeDic];
    if ([clockTimeModel.run isEqualToString:@"1"]) {
        cell.mySwitch.on = YES;
    }else {
        cell.mySwitch.on = NO;
    }
    if (clockTimeModel.min.length == 1){
        clockTimeModel.min = [NSString stringWithFormat:@"0%@",clockTimeModel.min];
    }
    cell.timeLb.text = [NSString stringWithFormat:@"%@:%@",clockTimeModel.hour,clockTimeModel.min];
    cell.titleLb.text = [NSString stringWithFormat:@"%@,%@",clockTimeModel.name,[self getClockDayStringArray:clockTimeModel.week]];
    cell.row = indexPath.row;
    cell.delegate = self;
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    
    return cell;
}




#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
    
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClockViewController *clockViewController = [[ClockViewController alloc]init];
    clockViewController.isAddClock = NO;
    clockViewController.numberTag = indexPath.row;
    clockViewController.deviceDid = _device.did;
    [self.navigationController pushViewController:clockViewController animated:YES];
    
}


/**
 * 删除设备
 */
#pragma -mark点击编辑按钮执行的方法（第一步）
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //必须要让父类也调用该方法，不用只能进入到编辑状态，不能返回原始状态
    [super setEditing:editing animated:animated];
    
    //点击编辑按钮的时候，让表视图处于可编辑状态
    [self.tableView setEditing:editing animated:animated];
}

#pragma -mark设置单元格是否可以编辑(第二步)
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //默认是都可编辑的，如果，你的需要是都可以编辑，该方法可以不写
    //    if (indexPath.row==4)
    //    {
    //        return NO;
    //    }
    return YES;
}
#pragma -mark设置单元格是删除样式还是添加的样式(第三步)
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleDelete;
    return style;
}
#pragma -mark真正的根据编辑的样式去删除和添加(第四步)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    _device = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_device.did];
    Clock *clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.clock]];
    [_clockTime removeObjectAtIndex:indexPath.row];
    clock.clockTime = _clockTime;
    NSDictionary *clockDic = [clock keyValues];
    
//    _device.clock = [GWNSStringUtil convertToJSONString:clockDic];
//    NSLog(@"clock = %@",_device.clock);
    
    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];
  
 
    if (_clockTime.count < 4) {
        [rightBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        rightBt.userInteractionEnabled = YES;
    }else {
        [rightBt setImage:[UIImage imageNamed:@"无效"] forState:UIControlStateNormal];
        rightBt.userInteractionEnabled = NO;
    }
    
    [_tableView reloadData];
}

#pragma mark 选择显示的星期
- (NSString *)getClockDayStringArray:(NSMutableArray *) array{
    
    NSArray *_titleArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    NSArray *_weekArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
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

#pragma mark 赋值模型
- (ClockTimeModel *)modelConversionDictionary:(NSDictionary *)dic {
    
    ClockTimeModel *clockTimeModel = [[ClockTimeModel alloc]init];
    clockTimeModel.week = [dic objectForKey:@"week"];
    clockTimeModel.hour = [dic objectForKey:@"hour"];
    clockTimeModel.min = [dic objectForKey:@"min"];
    clockTimeModel.times = [dic objectForKey:@"times"];
    clockTimeModel.run = [dic objectForKey:@"run"];
    clockTimeModel.name = [dic objectForKey:@"name"];
    clockTimeModel.ringTime = [dic objectForKey:@"ringTime"];
    
    return clockTimeModel;
}


#pragma mark 开关的方法
-(void)showSwitchingSetAlarmClockCellSwitchStatus:(BOOL)switchStatus andRow:(NSInteger)row {
//    NSLog(@"你点击了开关");
//    _device = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_device.did];
    Clock *clock = [Clock objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.clock]];
    clock.isValid = @"0";
    NSDictionary *tempClockTimeDic = [_clockTime objectAtIndex:row];
    ClockTimeModel *clockTimeModel = [self modelConversionDictionary:tempClockTimeDic];
    if (switchStatus) {
        clockTimeModel.run = @"1";
    }else {
        clockTimeModel.run = @"0";
    }
    
    NSMutableArray *_clockTimeArr = [clock.clockTime mutableCopy];
    NSDictionary *clockTimeDic = [clockTimeModel keyValues];
    _clockTimeArr[row] = clockTimeDic;
    clock.clockTime = _clockTimeArr;
    NSDictionary *clockDic = [clock keyValues];
    
//    _device.clock = [GWNSStringUtil convertToJSONString:clockDic];
//    NSLog(@"clock = %@",_device.clock);
    
    [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:Clock_Set andChangeName:@"clock" andChangeDetail:[GWNSStringUtil convertToJSONString:clockDic]];


    
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
