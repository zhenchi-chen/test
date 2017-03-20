//
//  AddBluetoothViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/23.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "AddBluetoothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BindingBluetoothViewController.h"



@interface AddBluetoothViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
 
    UIButton *searchBt; //搜索
    UILabel *promptLb;
    int howTime; //第几次搜索
    int peripheralTimerNum;    //寻找蓝牙的时间
}
@property (strong,nonatomic)UITableView *tableView;

@property(strong, nonatomic)NSString *peripheralEquipmentUUID; //外围设备UUID
@property (strong, nonatomic)NSString *deice; //外围设备地址
@property(strong, nonatomic)NSMutableArray *peripheralAddress; //外围设备地址数组
@property(strong, nonatomic)NSMutableArray *peripheralName; //外围设备名字

@property (strong,nonatomic) CBCentralManager *centralManager;//中心设备管理器
@property (strong,nonatomic) NSMutableArray *peripherals;//连接的外围设备

@property (strong,nonatomic)CBPeripheral *waiweishebei; //外围设备

@property (assign,nonatomic)int isOpenBluetooth; //是否打开蓝牙,0关闭,1打开

@property (strong,nonatomic)NSTimer *peripheralTimer;  //定时器,寻找自己的蓝牙设备


@end

@implementation AddBluetoothViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self navSet:@"欢迎使用智能枕头"];
    
    _myTag = [[de valueForKey:@"bind_myTag"] integerValue];
    
    _peripheralAddress = [NSMutableArray array];
    _peripheralName = [NSMutableArray array];
    _peripherals=[NSMutableArray array];
    
    //初始化本地中心设备 蓝牙
    [self connection];

    
    [self createView];
    
    
}

#pragma mark 创建主元素
- (void)createView {
    
    UIImageView *photoIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenWidth*3/5)];
    photoIv.image = [UIImage imageNamed:@"addLanYa"];
    [self.view addSubview:photoIv];
    
    promptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, height_y(photoIv), MainScreenWidth-40*Width, 20*Height)];
//    promptLb.backgroundColor = [UIColor orangeColor];
    promptLb.textAlignment = NSTextAlignmentCenter;
    promptLb.font = [UIFont systemFontOfSize:12];
    promptLb.numberOfLines = 0;//多行显示，计算高度
    promptLb.textColor = MainColorDarkGrey;
    promptLb.text = @"搜索前请先开启手机蓝牙";
    CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:promptLb.width content:promptLb.text];
    promptLb.height = heightLb;
    [self.view addSubview:promptLb];
    
    CGFloat heightq = height_y(promptLb);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, heightq, MainScreenWidth, MainScreenHeight-heightq-100*Height-64)];
//    _tableView.backgroundColor = [UIColor brownColor];
    //分割线颜色
    _tableView.separatorColor = RGB(212, 212, 212);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    
    searchBt = [self buildBtn:@"停止" action:@selector(searchBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-150*Height, MainScreenWidth-160*Width,40*Height)];
    searchBt.selected = NO;
    [searchBt setTitle:@"搜索" forState:UIControlStateSelected];
    [self.view addSubview:searchBt];
    
}




#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {
    

}

#pragma mark 连接设备
- (void)searchBtAction:(UIButton *)button
{
    
    //1, 连接蓝牙
    if (_centralManager == nil) {
        //初始化本地中心设备 蓝牙
        [self connection];
    }else {
        if (button.selected == NO) {
            //停止扫描
            [self CancelTheScan];
        }else {
            promptLb.text = @"";
            promptLb.height = 20*Height;
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
            //开始扫描
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            button.selected = NO;
            if (_peripheralAddress != nil) {
                [_peripheralAddress removeAllObjects];
            }
            if (_peripheralName != nil) {
                [_peripheralName removeAllObjects];
            }
            if (_peripherals != nil) {
                [_peripherals removeAllObjects];
            }
        }
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
    cell.imageView.image = [UIImage imageNamed:@"LanYa"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_peripheralName[indexPath.row]];
//    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

#pragma mark -- 点击cell方法,蓝牙操作4
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //停止扫描
    [self CancelTheScan];
    
    _waiweishebei = [_peripherals objectAtIndex:indexPath.row];
    _deice = [_peripheralAddress objectAtIndex:indexPath.row];
 
    BindingBluetoothViewController *bindingBLE = [[BindingBluetoothViewController alloc]init];
    DeviceModel *deviceTemp = [[DeviceModel alloc]init];
    deviceTemp.did = _deice;
    bindingBLE.device = deviceTemp;
    bindingBLE.myTag = _myTag;
    [self.navigationController pushViewController:bindingBLE animated:YES];
   
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
        case CBPeripheralManagerStatePoweredOn:{
            _isOpenBluetooth = 1;
            NSLog(@"BLE已打开.");
            promptLb.text = @"";
            
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
//            //扫描外围设备
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        }
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.");
            _isOpenBluetooth = 0;
            promptLb.text = @"此设备不支持BLE或未打开蓝牙功能";
            [searchBt setTitle:@"搜索" forState:UIControlStateNormal];
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
    if (_peripheralName == nil) {
        _peripheralName = [NSMutableArray array];
    }
    if (_peripherals == nil) {
        _peripherals = [NSMutableArray array];
    }
    //连接外围设备
    if (peripheral) {
        
        //定时器,寻找蓝牙设备
        if (!_peripheralTimer) {
            
            _peripheralTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(peripheralTimerAction) userInfo:nil repeats:YES];
        }
      
        //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
        //判断当前蓝牙是否在蓝牙列表中
        if(![self.peripherals containsObject:peripheral]){
            NSData *ssData = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
            NSMutableString *addressStr = [NSMutableString stringWithFormat:@"%@",ssData];
            NSLog(@"发现设备: %@,地址是:%@",peripheral.name,addressStr);
//            [advertisementData objectForKey:CBAdvertisementDataLocalNameKey]
            NSString *localName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
            NSLog(@"Local: name: %@", localName);
//            NSData *manufacturerData = [advertisementData objectForKey:CBAdvertisementDataManufacturerDataKey];
//            NSLog(@"Manufact. Data: %@", [manufacturerData description]);
        
            //判断是否是乐乎传感器蓝牙
            if ([addressStr hasPrefix:@"<484d"] && [localName hasPrefix:@"Le-P"]) {
                [addressStr deleteCharactersInRange:NSMakeRange(0, 5)];
                [addressStr deleteCharactersInRange:NSMakeRange(addressStr.length-1, 1)];
                NSString *tempStr1 = [addressStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                //判断数组是否包含了这个外围设备
                if (![_peripheralAddress containsObject:[tempStr1 uppercaseString]]) {
                    [_peripheralAddress addObject:[tempStr1 uppercaseString]];
                    [_peripherals addObject:peripheral];
                    [_peripheralName addObject:localName];
//                    if (promptLb.text.length > 2) {
//                        promptLb.text = @"";
//                        promptLb.height = 20*Height;
//                    }
                    
                }
            }
        }
    }
    [_tableView reloadData];

    
}


#pragma mark 寻找蓝牙设备定时器(定时器时不准确,需要找原因)
- (void)peripheralTimerAction{
    
    if (peripheralTimerNum == 10) {
        [self CancelTheScan];
        
        [self sendBluetoothTimeout];
    }
    peripheralTimerNum++;
    
}

#pragma mark 蓝牙超时
-(void)sendBluetoothTimeout{
    if (_peripheralAddress.count != 0) {
        return;
    }

    if (howTime == 0) {
        promptLb.text = @"未找到任何设备！\n请把您的手机靠近5米以内再试一次";
        CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:promptLb.width content:promptLb.text];
        promptLb.height = heightLb;
        howTime = 1;
        _tableView.y = height_y(promptLb)+10;
        return;
    }else if (howTime == 1) {
        promptLb.text = @"依然未找到任何设备！\n请先充电30分钟再试一次";
        CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:promptLb.width content:promptLb.text];
        promptLb.height = heightLb;
        _tableView.y = height_y(promptLb)+10;
        howTime = 0;
    }
    
}
//取消扫描蓝牙设备
- (void)CancelTheScan{
    //停止扫描
    [self.centralManager stopScan];
    if (_peripheralTimer) {
        [_peripheralTimer setFireDate:[NSDate distantFuture]];
        [_peripheralTimer invalidate];//取消定时器
        _peripheralTimer = nil;
        peripheralTimerNum = 0;
    }
    searchBt.selected = YES;
}

#pragma mark - 属性
//-(NSMutableArray *)peripherals{
//    if(!_peripherals){
//        _peripherals=[NSMutableArray array];
//    }
//    return _peripherals;
//}



@end
