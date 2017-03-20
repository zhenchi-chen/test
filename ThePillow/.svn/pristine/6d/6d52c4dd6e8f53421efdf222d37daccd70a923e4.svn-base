//
//  BindingBluetoothViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/13.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "BindingBluetoothViewController.h"
#import "DetailViewController.h"
#import "UIImage+LXDCreateBarcode.h" //二维码生成
#import "AlarmClockOneViewController.h"

@interface BindingBluetoothViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    BOOL switchStatus; //是否开启初始化
    BluetoothOrder *bluetoothOrder; //蓝牙助手
    UIButton *goBt;
    BOOL isLinkBluetooth; //是否连接蓝牙
   
}

@property (nonatomic,strong)UITextField *nameTextField;  //名字

@property (nonatomic,strong)NSString *hardwareVersion; //硬件版本号
@property (nonatomic,strong)NSString *softwareVersion; //软件版本号

@end

@implementation BindingBluetoothViewController

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
//            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code == 200) {
                //                [SVProgressHUD showSuccessWithStatus:@"恭喜你,绑定成功成功!"];
              
                //初始化设备
                NSString *configDataStr = [self setDeviceModelAndindex:YES];
                NSLog(@"configDataStr= %@",configDataStr);
                //                NSLog(@"%@",[dataDic objectForKey:@"devcieID"]);
                
                if (_myTag == 3) {
                    [GWNotification pushHandle:nil withName:@"更换首页"];
                }
                
                [de setValue:[NSString stringWithFormat:@"%ld",(long)_myTag] forKey:@"bind_myTag"];
                [de setValue:_device.did forKey:@"bind_deviceId"];
                
                AlarmClockOneViewController *alarmClockOneVC = [[AlarmClockOneViewController alloc]init];
                [self.navigationController pushViewController:alarmClockOneVC animated:YES];
                
            }else if (baseModel.code == 12040) {
              //已经绑定了
                DeviceModel *model = [[[DeviceListTool alloc]init]queryDeviceListShowModelDevice:_device.did];
//                NSLog(@"model.did = %@,_device.did = %@",model.did,_device.did);
                if (![model.did isEqualToString:_device.did]) {
                    //初始化设备
                    NSString *configDataStr = [self setDeviceModelAndindex:YES];
                    NSLog(@"configDataStr= %@",configDataStr);
                    
                    
                    if (_myTag == 3) {
                        [GWNotification pushHandle:nil withName:@"更换首页"];
                    }
                    
                    [de setValue:[NSString stringWithFormat:@"%ld",(long)_myTag] forKey:@"bind_myTag"];
                    [de setValue:_device.did forKey:@"bind_deviceId"];
                    
                    AlarmClockOneViewController *alarmClockOneVC = [[AlarmClockOneViewController alloc]init];
                    [self.navigationController pushViewController:alarmClockOneVC animated:YES];

                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
        
    }
    
    
}

#pragma mark 对设备赋初值
- (NSString *) setDeviceModelAndindex:(BOOL)index {
    //didInfo
    DidInfoModel *didInfoModel = [[DidInfoModel alloc]init];
    didInfoModel.deviceName = _nameTextField.text;
    didInfoModel.softwareVersion = _softwareVersion;
    didInfoModel.hardwareVersion = _hardwareVersion;
    didInfoModel.isHome = @"1";
    didInfoModel.type = @"vble";
    
    
    //snore
    ConfigModel *snoreModel = [[ConfigModel alloc]init];
    snoreModel.select = @"1";
    snoreModel.isValid = @"0";
    NSMutableArray *customArray = [NSMutableArray array];
    snoreModel.custom = [CustomModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:customArray]];

    
    //Clock
    Clock *clock = [[Clock alloc]init];
    ConfigModel *clockMode = [[ConfigModel alloc]init];
    clockMode.select = @"1";
    clockMode.isValid = @"0";
    NSMutableArray *customTempArr = [NSMutableArray array];
    clockMode.custom = [CustomModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:customTempArr]];
    
    clock.clockMode = [clockMode keyValues];
    
   
    NSMutableArray *clockTimeTempArr = [NSMutableArray array];
    clock.clockTime = [ClockTimeModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:clockTimeTempArr]];
    clock.isValid = @"0";
    
    
    //userInfo
    NSDictionary *userInfoDicTemp = [NSDictionary dictionary];
    UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:userInfoDicTemp];
    
    DeviceModel *deviceModelTemp = [[DeviceModel alloc]init];
    deviceModelTemp.did = _device.did;
    deviceModelTemp.didInfo = [GWNSStringUtil convertToJSONString:[didInfoModel keyValues]];
    deviceModelTemp.userInfo = [GWNSStringUtil convertToJSONString:[userInfoModel keyValues]];
    deviceModelTemp.snore = [GWNSStringUtil convertToJSONString:[snoreModel keyValues]];
    deviceModelTemp.clock = [GWNSStringUtil convertToJSONString:[clock keyValues]];
    deviceModelTemp.isServer = @"0";
    deviceModelTemp.rule = @"admin";
    
    NSString *configDataStr = [GWNSStringUtil convertToJSONString:[deviceModelTemp keyValues]];
    if (index) {
        deviceModelTemp.isServer = @"1";
        //存本地
        [[[DeviceListTool alloc]init] insertDeviceList:deviceModelTemp];
        //设为首页
        [[UpdateDeviceData sharedManager]setUpdateDataDevice:deviceModelTemp];
    }
   return configDataStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_myTag == 4) {
        [self navSet:@"请输入设备名字"];
    }else {
        
        [self navSet:@"欢迎使用智能枕头"];
    }
    
    
    
    
    bluetoothOrder = [[BluetoothOrder alloc]init];
    //连接蓝牙
    [self getData];
    
    [self createMainView];
    
    
}

#pragma mark 创建主要元素
- (void)createMainView {
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(50*Width, 50*Height, MainScreenWidth-100*Width, 40*Height)];
    self.nameTextField.clearsOnBeginEditing = YES;
    self.nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _nameTextField.placeholder = NSLocalizedString(@"add_bluetooth_device_fragment_device_name",nil);
//    _nameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;  //提示居左
    _nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameTextField];
    _nameTextField.delegate = self;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_nameTextField.x, height_y(_nameTextField), _nameTextField.width, 1)];
    line.backgroundColor = MainColorLightGrey;
    [self.view addSubview:line];
    
    if (_myTag != 4) {
        //初始化设备
        UILabel *initializesDeviceLb = [[UILabel alloc]initWithFrame:CGRectMake(_nameTextField.x+40, height_y(_nameTextField)+20*Height, _nameTextField.width-100*Width, 20*Height)];
        initializesDeviceLb.font = [UIFont systemFontOfSize:12];
        initializesDeviceLb.textAlignment = NSTextAlignmentCenter;
        initializesDeviceLb.text = NSLocalizedString(@"add_bluetooth_device_fragment_device_Initializes",nil);
        initializesDeviceLb.textColor = MainColorDarkGrey;
        [self.view addSubview:initializesDeviceLb];
        
        //开关
        UISwitch* mySwitch = [[ UISwitch alloc]init];
        mySwitch.x = width_x(initializesDeviceLb);
        mySwitch.centerY = initializesDeviceLb.centerY;
        mySwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [mySwitch setOn:YES animated:YES];
        mySwitch.onTintColor = MainColor; // 在oneSwitch开启的状态显示的颜色 默认是blueColor
        //    mySwitch.tintColor = [UIColor purpleColor]; // 设置关闭状态的颜色
        [self.view addSubview:mySwitch];
        [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        switchStatus = mySwitch.on;
        
        //确定
        goBt = [self buildBtn:@"GO! 开启全新体验" action:@selector(searchBtAction:) frame:CGRectMake(80*Width, height_y(mySwitch)+40*Height, MainScreenWidth-160*Width,50*Height)];
        

        
    }else {
        //确定
        goBt = [self buildBtn:@"保存" action:@selector(searchBtAction:) frame:CGRectMake(80*Width, height_y(line)+40*Height, MainScreenWidth-160*Width,50*Height)];
        
    }
    
    [self.view addSubview:goBt];
    
    
    UILabel *shareTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(goBt)+40*Height, MainScreenWidth, 20)];
    shareTitleLb.textColor = MainColorDarkGrey;
    shareTitleLb.textAlignment = NSTextAlignmentCenter;
    shareTitleLb.text = @"设备分享二维码";
    shareTitleLb.font = [UIFont systemFontOfSize:12];
//    [self.view addSubview:shareTitleLb];
    
    UIImage *image = [UIImage imageOfQRFromURL:[NSString stringWithFormat:@"GOSPEL:%@",_device.did] codeSize: 60 red: 0 green: 0 blue: 0 insertImage: [UIImage imageNamed: @"app_store"] roundRadius: 15.0f];
    CGSize size = image.size;
    
    UIImageView *ermImage = [[UIImageView alloc] init];
    ermImage.image = image;
    ermImage.size = size;
    ermImage.y = height_y(shareTitleLb)+5;
    ermImage.centerX  = self.view.centerX;
//    [self.view addSubview: ermImage];
    
}

#pragma mark 确定
- (void)searchBtAction:(UIButton *)button{
    if (_nameTextField.text.length < 1) {
        _nameTextField.text = NSLocalizedString(@"device_default_name", nil);
    }
//    NSLog(@"%@",_nameTextField.text);
    if (_myTag != 4) {
        if (_device.did != nil) {
            if (switchStatus) {
                if (isLinkBluetooth) {
                    //初始化蓝牙设备
                    [self getData5];
                }else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"蓝牙未连接" delegate:self cancelButtonTitle:@"连接蓝牙" otherButtonTitles:@"绑定设备",nil];
                    [alert show];
                }
            }else {
                [self initData];
            }
            
        }else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"add_bluetooth_device_fragment_warn",nil)];
        }
    } else {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:_device andtype:DidInfo_Set andChangeName:@"deviceName" andChangeDetail:_nameTextField.text];
        [GWNotification pushHandle:nil withName:@"更新设备信息"];
        //返回到上一个页面
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if (isLinkBluetooth) {
            //初始化蓝牙设备
            [self getData5];
        }else {
            [self getData];
        }
    
    }else if (buttonIndex == 1) {
        [self initData];
    }
    
}



//监听开关
- (void) switchValueChanged:(UISwitch *)sender{
    
    switchStatus = sender.on;
    
}

//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 已经消失页面
- (void)viewDidDisappear:(BOOL)animated {
    

    //    int bluetoothStaitc = [[ConfigurationUtil sharedManager] getBlueStatic];
    //    if (bluetoothStaitc != 0) {
    //断开连接
    [self getData4];
    //    }
}


#pragma mark 连接蓝牙
-(void)getData{
    
    //连接蓝牙,传入设备ID
    [bluetoothOrder ConnectionBluetoothDeviceMacAddress:_device.did block:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_electricCharge) {//电量获取
                NSLog(@"电量获取,电量是: %@",[dic objectForKey:@"electric"]);
                
            }else if(result == bluetooth_result_ready){//蓝牙已经准备好接受命令
                NSLog(@"蓝牙已经准备好接受命令");
                isLinkBluetooth = YES;
                //获取版本号
                [self getData2];
                
            }else if(result == bluetooth_result_log){//日志信息输出
                
                
            }
        }
    }];
    
}

//获取版本号
-(void)getData2{
    [bluetoothOrder getVersion:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if(result == bluetooth_result_version){//蓝牙失败返回
                //版本信息回传
                _softwareVersion = [dic objectForKey:@"softwareVersion"];
                _hardwareVersion = [dic objectForKey:@"hardwareVersion"];
            }
        }else {
            _softwareVersion = 0;
            _hardwareVersion = 0;
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
                    isLinkBluetooth = NO;
                }
            }
        }
        
    }];
}

//初始化蓝牙
-(void)getData5{
    [bluetoothOrder initializeDevice:^(int result, NSDictionary *dic, NSError *error) {
        
        if ([self isResultEffective:result dic:dic error:error]) {
            if (result == bluetooth_result_electricCharge) {//电量获取
                NSLog(@"电量获取,电量是: %@",[dic objectForKey:@"electric"]);
            }else if(result == bluetooth_result_ready){//蓝牙初始化成功
                [self initData];
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

//调此接口前要先上传设备配置信息
#pragma mark 调用蓝牙绑定接口
-(void)initData{
    
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:_device.did forKey:@"deviceID"];
    [reqDic setValue:_nameTextField.text forKey:@"deviceName"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic setValue:_softwareVersion forKey:@"softversion"];
    [reqDic setValue:_hardwareVersion forKey:@"hardversion"];
    [reqDic setValue:[self setDeviceModelAndindex:NO] forKey:@"configData"];
    [req reqDataWithUrl:SETBIND reqDic:reqDic reqHeadDic:nil];
    
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
