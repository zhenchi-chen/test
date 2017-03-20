//
//  SnoreSetViewViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/7.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SnoreSetViewViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "SelectBluetoothView.h"
#import "AHRuler.h"

@interface SnoreSetViewViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,SelectBluetoothViewDelegate,UITableViewDataSource,UITableViewDelegate,AHRrettyRulerDelegate>
{
    BluetoothOrder *bluetoothOrder; //蓝牙助手
    ListModel *listModel;
    UIView *viewHe;
    SelectBluetoothView *popupWindowView;
    BOOL isConnection; //蓝牙是否连接
    //导航右按钮
    UIButton *rightBt;
    //标题
    UILabel *titleLb;
    
    //震动次数
    UILabel *numberLb;
    //选择震动次数
    AHRuler *rulerNumber;
    //次数单位
    UILabel *rulerNumberUnitLb;
    
    //震动时间
    UILabel *timeLb;
    //选择震动时间
    AHRuler *rulerTime;
    //震动时间单位
    UILabel *rulerTimeUnitLb;
    
    //震动时间间隔
    UILabel *intervalLb;
    //选择震动时间间隔
    AHRuler *rulerInterval;
    //震动时间间隔单位
    UILabel *rulerIntervalUnitLb;
}

@property (strong, nonatomic)NSString *deice; //外围设备地址
@property(strong, nonatomic)NSMutableArray *peripheralAddress; //外围设备地址数组

@property (strong,nonatomic) CBCentralManager *centralManager;//中心设备管理器
@property (strong,nonatomic) NSMutableArray *peripherals;//连接的外围设备

@property (strong,nonatomic)CBPeripheral *waiweishebei; //外围设备

@property (assign,nonatomic)int isOpenBluetooth; //是否打开蓝牙,0关闭,1打开

@end

@implementation SnoreSetViewViewController

#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {
    
    [self disappearWindow];
//    int bluetoothStaitc = [[ConfigurationUtil sharedManager] getBlueStatic];
//    if (bluetoothStaitc != 0) {
    //断开连接
    [self getData4];
//    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:@"打鼾设置"];
    
    bluetoothOrder = [[BluetoothOrder alloc] init];
    
    isConnection = NO;
    NSDictionary *dic = [[ListTheCacheClass sharedManager]readData];
    NSInteger isDevice = [[dic valueForKey:@"isDevice"] integerValue];
    NSMutableArray *saveArr = nil;
    listModel = [saveArr objectAtIndex:isDevice];
    _deice = listModel.did;
    //连接蓝牙
    [self getData];
    
    rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 0, 80, 25);
    rightBt.selected = NO;
    [rightBt setTitleColor:MainColor forState:UIControlStateNormal];
    [rightBt setTitle:@"连接设备" forState:UIControlStateNormal];
    [rightBt setTitle:@"断开设备" forState:UIControlStateSelected];
    [rightBt addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    
    
    
//    self.view.backgroundColor = RGB(56, 72, 93);
    
    
    //标题
    titleLb = [[UILabel alloc]init];
    titleLb.text = @"打鼾设置模式";
    titleLb.textColor = MainColorDarkGrey;
    titleLb.font = [UIFont systemFontOfSize:20];
    //根据字体得到宽度
    //    CGFloat width = [UILabel getWidthWithTitle:titleLb.text font:titleLb.font];
    // 根据字体得到NSString的尺寸
    CGSize titleLbSize = [titleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLb.font,NSFontAttributeName, nil]];
    titleLb.size = titleLbSize;
    titleLb.centerX = self.view.centerX;
    titleLb.y = 20*Height;
    [self.view addSubview:titleLb];
    
    //创建主页面
    [self createView];
    
    
}

#pragma mark 创建主页面
- (void)createView {

    CGFloat spacing = 20*Height;
    //震动强度标题
    UILabel *intensityTitleLb = [[UILabel alloc]init];
    intensityTitleLb.y = height_y(titleLb)+spacing;
    intensityTitleLb.text = @"震动频率";
    intensityTitleLb.textColor = MainColorDarkGrey;
    intensityTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize intensityTitleLbSize = [intensityTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:intensityTitleLb.font,NSFontAttributeName, nil]];
    intensityTitleLb.size = intensityTitleLbSize;
    intensityTitleLb.centerX = self.view.centerX;
    [self.view addSubview:intensityTitleLb];
    
    
    //震动强度
    numberLb = [[UILabel alloc]init];
    numberLb.centerX = intensityTitleLb.centerX;
    numberLb.y = height_y(intensityTitleLb)+5*Height;
    numberLb.textColor = MainColorDarkGrey;
    numberLb.font = [UIFont systemFontOfSize:16];
    numberLb.text = @"2";
    // 根据字体得到NSString的尺寸
    CGSize numberLbSize = [numberLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:numberLb.font,NSFontAttributeName, nil]];
    numberLb.size = numberLbSize;
    [numberLb sizeToFit];
    [self.view addSubview:numberLb];
    
    //次数单位
    rulerNumberUnitLb = [[UILabel alloc]init];
    rulerNumberUnitLb.text = @"次数";
    rulerNumberUnitLb.textColor = MainColorDarkGrey;
    rulerNumberUnitLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize titleLbSize = [rulerNumberUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rulerNumberUnitLb.font,NSFontAttributeName, nil]];
    rulerNumberUnitLb.size = titleLbSize;
    rulerNumberUnitLb.x = width_x(numberLb);
    rulerNumberUnitLb.centerY = numberLb.centerY;
    [self.view addSubview:rulerNumberUnitLb];
    
    CGFloat scaleHeight = 70;
    CGFloat scaleWidth = 220;
    
    // 2.创建 AHRuler 对象 并设置代理对象
    rulerNumber = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(numberLb)+5, scaleWidth, scaleHeight)];
    rulerNumber.rulerMin = 0;
    rulerNumber.isRangingHeight = YES;
    rulerNumber.isDisplayTags = YES;
    rulerNumber.isText = YES;
    rulerNumber.rulerDeletate = self;
    [rulerNumber showRulerScrollViewWithCount:40 average:[NSNumber numberWithFloat:1] currentValue:12 smallMode:YES];
    [self.view addSubview:rulerNumber];
    
 
    //震动时间
    UILabel *timeTitleLb = [[UILabel alloc]init];
//    timeTitleLb.frame = CGRectMake(20, height_y(rulerNumber)+30, MainScreenWidth-40, 15);
//    timeTitleLb.backgroundColor = [UIColor orangeColor];
    timeTitleLb.y = height_y(rulerNumber)+spacing;
    timeTitleLb.text = @"震动持续时间(一个单位为2ms)";
    timeTitleLb.textColor = MainColorDarkGrey;
    timeTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize timeTitleLbSize = [timeTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:timeTitleLb.font,NSFontAttributeName, nil]];
    timeTitleLb.size = timeTitleLbSize;
    timeTitleLb.centerX = self.view.centerX;
    [self.view addSubview:timeTitleLb];
    
    
    //震动时间
    timeLb = [[UILabel alloc]init];
    timeLb.centerX = intensityTitleLb.centerX;
    timeLb.y = height_y(timeTitleLb)+5*Height;
    timeLb.textColor = MainColorDarkGrey;
    timeLb.font = [UIFont systemFontOfSize:16];
    timeLb.text = @"200";
    // 根据字体得到NSString的尺寸
    CGSize timeLbSize = [timeLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:timeLb.font,NSFontAttributeName, nil]];
    timeLb.size = timeLbSize;
    [timeLb sizeToFit];
    [self.view addSubview:timeLb];
    
    //震动时间单位
    rulerTimeUnitLb = [[UILabel alloc]init];
    rulerTimeUnitLb.text = @"ms";
    rulerTimeUnitLb.textColor = MainColorDarkGrey;
    rulerTimeUnitLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize rulerTimeUnitLbSize = [rulerTimeUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rulerTimeUnitLb.font,NSFontAttributeName, nil]];
    rulerTimeUnitLb.size = rulerTimeUnitLbSize;
    rulerTimeUnitLb.x = width_x(timeLb);
    rulerTimeUnitLb.centerY = timeLb.centerY;
    [self.view addSubview:rulerTimeUnitLb];
    
    //选择震动时间
    rulerTime = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(timeLb)+5*Height, scaleWidth, scaleHeight)];
    rulerTime.rulerDeletate = self;
    rulerTime.rulerMin = 1;
    rulerTime.isRangingHeight = YES;
    rulerTime.isDisplayTags = YES;
    rulerTime.isText = YES;
    [rulerTime showRulerScrollViewWithCount:271 average:[NSNumber numberWithFloat:1] currentValue:110 smallMode:YES];
    [self.view addSubview:rulerTime];
    
    //震动时间初始值
    timeLb.text = @"200";
    [timeLb sizeToFit];
    timeLb.centerX = self.view.centerX;
    rulerTimeUnitLb.x = width_x(timeLb);
    
    
    
   
    
    
    //震动时间间隔标题
    UILabel *intervalTitleLb = [[UILabel alloc]init];
    intervalTitleLb.y = height_y(rulerTime)+spacing;
    intervalTitleLb.text = @"震动时间间隔(一个单位为2ms)";
    intervalTitleLb.textColor = MainColorDarkGrey;
    intervalTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize intervalTitleLbSize = [intervalTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:intervalTitleLb.font,NSFontAttributeName, nil]];
    intervalTitleLb.size = intervalTitleLbSize;
    intervalTitleLb.centerX = self.view.centerX;
    [self.view addSubview:intervalTitleLb];
    
    //震动时间间隔
    intervalLb = [[UILabel alloc]init];
    intervalLb.centerX = intensityTitleLb.centerX;
    intervalLb.y = height_y(intervalTitleLb)+5*Height;
    intervalLb.textColor = MainColorDarkGrey;
    intervalLb.font = [UIFont systemFontOfSize:16];
    intervalLb.text = @"200";
    // 根据字体得到NSString的尺寸
    CGSize intervalLbSize = [intervalLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:intervalLb.font,NSFontAttributeName, nil]];
    intervalLb.size = intervalLbSize;
    [intervalLb sizeToFit];
    [self.view addSubview:intervalLb];
    
    //震动时间间隔单位
    rulerIntervalUnitLb = [[UILabel alloc]init];
    rulerIntervalUnitLb.text = @"ms";
    rulerIntervalUnitLb.textColor = MainColorDarkGrey;
    rulerIntervalUnitLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize rrulerIntervalUnitLbSize = [rulerIntervalUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rulerIntervalUnitLb.font,NSFontAttributeName, nil]];
    rulerIntervalUnitLb.size = rrulerIntervalUnitLbSize;
    rulerIntervalUnitLb.x = width_x(intervalLb);
    rulerIntervalUnitLb.centerY = intervalLb.centerY;
    [self.view addSubview:rulerIntervalUnitLb];
    
    //选择震动时间间隔
    rulerInterval = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(intervalLb)+5*Height, scaleWidth, scaleHeight)];
    rulerInterval.rulerDeletate = self;
    rulerInterval.rulerMin = 1;
    rulerInterval.isRangingHeight = YES;
    rulerInterval.isDisplayTags = YES;
    rulerInterval.isText = YES;
    [rulerInterval showRulerScrollViewWithCount:271 average:[NSNumber numberWithFloat:1] currentValue:110 smallMode:YES];
    [self.view addSubview:rulerInterval];
    
    //震动时间间隔
    intervalLb.text = @"200";
    [intervalLb sizeToFit];
    intervalLb.centerX = self.view.centerX;
    rulerIntervalUnitLb.x = width_x(intervalLb);



    UIButton *completeBt = [self buildBtn:@"完成" action:@selector(completeBtAction:) frame:CGRectMake(80*Width, height_y(rulerInterval)+30*Height, MainScreenWidth-160*Width,40*Height)];
    [self.view addSubview:completeBt];
    

}


#pragma mark 确认
- (void)completeBtAction:(UIButton *)button {
    if (isConnection) {
        if (_isClock) {
            [self getData2];
        }else {
            [self getData1];
        }
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"设备连接中"];
    }
    
}

- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler{
//    showLabel.text = [NSString stringWithFormat:@"%.fkg",rulerScrollView.rulerValue];
    if (ahRuler == rulerNumber) {
        if ((rulerScrollView.rulerValue-10)<0) {
            numberLb.text = @"0";
        }else if ( (rulerScrollView.rulerValue-10)>20) {
            numberLb.text = @"20";
        }else {
            numberLb.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue-10];
        }
        [numberLb sizeToFit];
        numberLb.centerX = self.view.centerX;
        rulerNumberUnitLb.x = width_x(numberLb);
    }else if (ahRuler == rulerTime) {
        if ((rulerScrollView.rulerValue-10)*2<0) {
            timeLb.text = @"0";
        }else if ((rulerScrollView.rulerValue-10)*2>500) {
            timeLb.text = @"500";
        }else {
            timeLb.text = [NSString stringWithFormat:@"%.f",(rulerScrollView.rulerValue-10+1)*2];
        }
        [timeLb sizeToFit];
        timeLb.centerX = self.view.centerX;
        rulerTimeUnitLb.x = width_x(timeLb);
        
    }else if (ahRuler == rulerInterval) {
        if ((rulerScrollView.rulerValue-10)*2<0) {
            intervalLb.text = @"0";
        }else if ((rulerScrollView.rulerValue-10)*2>500) {
            intervalLb.text = @"500";
        }else {
            intervalLb.text = [NSString stringWithFormat:@"%.f",(rulerScrollView.rulerValue-10+1)*2];
        }
        [intervalLb sizeToFit];
        intervalLb.centerX = self.view.centerX;
        rulerIntervalUnitLb.x = width_x(intervalLb);
        
    }
}

#pragma mark 连接设备
- (void)joinAction{
    
    if (rightBt.selected == NO) {
        if (_peripheralAddress != nil) {
            [_peripheralAddress removeAllObjects];
            [popupWindowView.tableView reloadData];
        }
        if (_peripherals != nil) {
            [_peripherals removeAllObjects];
        }
        [self selectionBluetooth];
        //1, 连接蓝牙
        if (_centralManager == nil) {
            //初始化本地中心设备 蓝牙
            [self connection];
        }else {
           
            if (_isOpenBluetooth == 0) {
                [SVProgressHUD showErrorWithStatus:@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备."];
                [self disappearWindow];
            }else {
                //开始扫描
                [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            }
        }
    }else {
        int bluetoothStaitc = [[ConfigurationUtil sharedManager] getBlueStatic];
        if (bluetoothStaitc != 0) {
            //断开连接
            [self getData4];
        }else {
            [SVProgressHUD showErrorWithStatus:@"设备没有连接"];
            [self disappearWindow];
        }
    }
}





#pragma mark ***************************蓝牙弹窗操作**************************

#pragma mark 弹窗选择蓝牙
- (void)selectionBluetooth
{
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    viewHe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    viewHe.backgroundColor = RGBA(0, 0, 0, 0.7);
    viewHe.userInteractionEnabled = YES;
    [window addSubview:viewHe];
    MyTap *tapView = [[MyTap alloc]initWithTarget:self action:@selector(tapViewAction:)];
    tapView.myTag = 1;
    [viewHe addGestureRecognizer:tapView];
    
    
    if (popupWindowView == nil) {
        popupWindowView = [[SelectBluetoothView alloc]initWithFrame:CGRectMake(20*Width, 64+50*Height, MainScreenWidth-40*Width, MainScreenHeight-64-100*Height)];
        popupWindowView.backgroundColor = RGB(238, 238, 238);
        popupWindowView.tableView.backgroundColor = RGB(238, 238, 238);
        popupWindowView.tableView.delegate = self;
        popupWindowView.tableView.dataSource = self;
        popupWindowView.delegate = self;
        [window addSubview:popupWindowView];
        
    }
}

- (void)tapViewAction:(MyTap *)tap{
    
    [self disappearWindow];
    
}


#pragma mark 蓝牙弹窗消失
- (void)disappearWindow
{
    if (popupWindowView != nil) {
        [popupWindowView removeFromSuperview];
        popupWindowView = nil;
    }
    
    if (viewHe != nil) {
        [viewHe removeFromSuperview];
        viewHe = nil;
    }
    
    
    //停止扫描
    [self.centralManager stopScan];
    
}

#pragma mark 停止/开始扫描
- (void)didSelectSelectBluetoothViewWithbutton:(UIButton *)button {
    if (button.selected == NO) {
        
        //停止扫描
        [self.centralManager stopScan];
        button.selected = YES;
    }else {
        //开始扫描
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        button.selected = NO;
    }
}


#pragma mark ***************************cell的操作**************************
#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _peripheralAddress.count;
    
}

#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

#pragma -mark创建每个cell的方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool1 = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool1];
    }
    _waiweishebei = [_peripherals objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ID:%@",_waiweishebei.name,[_peripheralAddress objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

#pragma mark -- 点击cell方法,蓝牙操作4
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _waiweishebei = [_peripherals objectAtIndex:indexPath.row];
    _deice = [_peripheralAddress objectAtIndex:indexPath.row];
    [self disappearWindow];
    
    //连接蓝牙
    [self getData];


}


#pragma maek ***************************************蓝牙操作***************************

#pragma mark 连接蓝牙_ 蓝牙操作步骤一.开启Central Manager
- (void)connection
{
    //创建中心设备管理器并设置当前控制器视图为代理
    _centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
}

#pragma mark - CBCentralManager代理方法 _ 蓝牙操作步骤二.搜索正在广告的外围设备
//当创建了一个central manager，会回调代理的方法，你必须实现这个代理方法来确定中心设备是否支持BLE以及是否可用。
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBPeripheralManagerStatePoweredOn:
            _isOpenBluetooth = 1;
            NSLog(@"BLE已打开.");
            //扫描外围设备
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
            
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.");
            [self disappearWindow];
            _isOpenBluetooth = 0;
            break;
    }
}

/**
 *  发现外围设备
 *
 *  @param central           中心设备
 *  @param peripheral        外围设备
 *  @param advertisementData 特征数据
 *  @param RSSI              信号质量（信号强度）
 */
#pragma mark 发现外围设备的时候会调用该方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (_peripheralAddress == nil) {
        _peripheralAddress = [NSMutableArray array];
    }
    
    //连接外围设备
    if (peripheral) {
        //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
        //判断当前蓝牙是否在蓝牙列表中
        if(![self.peripherals containsObject:peripheral]){
            NSData *ssData = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
            NSMutableString *addressStr = [NSMutableString stringWithFormat:@"%@",ssData];
            //判断是否是乐乎传感器蓝牙
            if ([addressStr hasPrefix:@"<484d"]) {
                [addressStr deleteCharactersInRange:NSMakeRange(0, 5)];
                [addressStr deleteCharactersInRange:NSMakeRange(addressStr.length-1, 1)];
                NSString *tempStr1 = [addressStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                //判断数组是否包含了这个外围设备
                if (![_peripheralAddress containsObject:[tempStr1 uppercaseString]]) {
                    [_peripheralAddress addObject:[tempStr1 uppercaseString]];
                    [_peripherals addObject:peripheral];
                }
            }
        }
    }
    
    if (popupWindowView == nil) {
        [self selectionBluetooth];
    }
    [popupWindowView.tableView  reloadData];
    
}


#pragma mark - 属性
-(NSMutableArray *)peripherals{
    if(!_peripherals){
        _peripherals=[NSMutableArray array];
    }
    return _peripherals;
}



#pragma mark 连接蓝牙
-(void)getData{
    
    //连接蓝牙,传入设备ID
    [bluetoothOrder ConnectionBluetoothDeviceMacAddress:_deice block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_electricCharge) {//电量获取
                NSLog(@"电量获取,电量是: %@",[dic objectForKey:@"electric"]);
                
            }else if(result == bluetooth_result_ready){//蓝牙已经准备好接受命令
                NSLog(@"蓝牙已经准备好接受命令");
//                NSLog(@"%@设备已经连接成功",_deice);
                rightBt.selected = YES;
                isConnection = YES;
            }else if(result == bluetooth_result_log){//日志信息输出
                
                
            }
        }
    }];
    
}


//设置打鼾模式
-(void)getData1{
    
    int time = [timeLb.text intValue]/2;
    int interval = [intervalLb.text intValue]/2;
    //设置打鼾模式传入相关参数
    [bluetoothOrder getSnoreNum:[numberLb.text intValue] andActivityTime:time andInterval:interval block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_snore){
                if ([[dic objectForKey:@"setSnore"] isEqualToString:@"setSnore"]) {
                    NSLog(@"设置打鼾模式成功");
                }
            }
        }
    }];
}


//设置闹钟模式
-(void)getData2{
    
    int time = [timeLb.text intValue]/2;
    int interval = [intervalLb.text intValue]/2;
    //设置打鼾模式传入相关参数
    [bluetoothOrder getClockNum:[numberLb.text intValue] andActivityTime:time andInterval:interval block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_snore){
                if ([[dic objectForKey:@"setClock"] isEqualToString:@"setClock"]) {
                    NSLog(@"设置闹钟模式成功");
                }
            }
        }
    }];
}

//断开蓝牙
-(void)getData4{
    
    [bluetoothOrder DisconnectBluetooth:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_staticupdate) {
                if ([dic[@"staticUpdate"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)bluetooth_static_nil]]) {
                    //蓝牙断开状态
                    NSLog(@"%@设备已经断开",_deice);
                    rightBt.selected = NO;
                }
            }
        }
        
    }];
}


//公共的处理结果的地方 - 结果是否有效
-(Boolean)isResultEffective:(int)result dic:(NSDictionary *)dic error:(NSError *)error{
    
    NSLog(@"操作码:%d\n结果:%@",result,[GWNSStringUtil getStringFromObj:dic]);
    if (result == bluetooth_result_fail) {//蓝牙异常
        return NO;
    }else if (result == bluetooth_result_log){
        if ([dic[@"errorType"] isEqualToString:@"0"]) {//异常信息中断了操作
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"wifi_device_ap_setup_fragment_warm_2", nil)];
            return NO;
        }
    }else if(result == bluetooth_result_busy){//蓝牙正忙,目前是蓝牙处于正在连接中...
        return NO;
    }else if(result == bluetooth_result_anknow){//未知异常,目前没有用到
        return NO;
    }
    return YES;
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
