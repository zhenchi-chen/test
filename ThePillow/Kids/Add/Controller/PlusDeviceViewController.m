//
//  PlusDeviceViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/20.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "PlusDeviceViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "AlarmClockOneViewController.h"
#import "AboutViewController.h"


#define NUMBERS @"0123456789\n"

@interface PlusDeviceViewController ()<UITextFieldDelegate,QRCodeReaderDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITextField *myTextField; //编号

@property (nonatomic,strong)UITextField *nameTextField;  //名字

@property (nonatomic,strong)NSString *deviceID; //设备ID

@end

@implementation PlusDeviceViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:_myTextField];
}


#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
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
                [de setValue:_deviceID forKey:@"bind_deviceId"];
                
                AlarmClockOneViewController *alarmClockOneVC = [[AlarmClockOneViewController alloc]init];
                [self.navigationController pushViewController:alarmClockOneVC animated:YES];
                
            }else if (baseModel.code == 12040) {
                //已经绑定了
                DeviceModel *model = [[[DeviceListTool alloc]init]queryDeviceListShowModelDevice:_deviceID];
                //                NSLog(@"model.did = %@,_deviceID = %@",model.did,_deviceID);
                if (![model.did isEqualToString:_deviceID]) {
                    //初始化设备
                    NSString *configDataStr = [self setDeviceModelAndindex:YES];
                    NSLog(@"configDataStr= %@",configDataStr);
                    
                    
                    if (_myTag == 3) {
                        [GWNotification pushHandle:nil withName:@"更换首页"];
                    }
                    
                    [de setValue:[NSString stringWithFormat:@"%ld",(long)_myTag] forKey:@"bind_myTag"];
                    [de setValue:_deviceID forKey:@"bind_deviceId"];
                    
                    AlarmClockOneViewController *alarmClockOneVC = [[AlarmClockOneViewController alloc]init];
                    [self.navigationController pushViewController:alarmClockOneVC animated:YES];
                    
                }
                
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt",nil)];
        }
        
        
}
    }
}


#pragma mark 对设备赋初值
- (NSString *)setDeviceModelAndindex:(BOOL)index {
    //didInfo
    DidInfoModel *didInfoModel = [[DidInfoModel alloc]init];
    didInfoModel.deviceName = _nameTextField.text;
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
    deviceModelTemp.did = _deviceID;
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
    
    [self navSet:NSLocalizedString(@"add_2g_device_fragment_title",nil)];


    _myTag = [[de valueForKey:@"bind_myTag"] integerValue];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0,50*Height, MainScreenWidth, 20*Height)];
    titleLb.text = NSLocalizedString(@"add_2g_device_fragment_content",nil);
//    titleLb.textColor = [UIColor whiteColor];
    titleLb.font = [UIFont systemFontOfSize:18 weight:0.3];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLb];
    
    UILabel *remindLb = [[UILabel alloc]initWithFrame:CGRectMake(0, height_y(titleLb) +30*Height, MainScreenWidth, 20*Height)];
    remindLb.text = NSLocalizedString(@"add_2g_device_fragment_content_2",nil);
    remindLb.textColor = RGB(138, 138, 138);
    remindLb.font = [UIFont systemFontOfSize:12];
    remindLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:remindLb];
    
    self.myTextField = [[UITextField alloc]initWithFrame:CGRectMake(50*Width, height_y(remindLb)+10*Height, MainScreenWidth-100*Width, 40*Height)];
    self.myTextField.clearsOnBeginEditing = YES;
    self.myTextField.clearButtonMode = UITextFieldViewModeAlways;
    _myTextField.layer.borderWidth = 1;
    _myTextField.layer.cornerRadius = 5;
    _myTextField.layer.borderColor = [RGB(200, 200, 200)CGColor];
    _myTextField.placeholder = NSLocalizedString(@"add_2g_device_fragment_sn_hint",nil);
//    _myTextField.textColor = [UIColor whiteColor];
    _myTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:self.myTextField];
    self.myTextField.delegate = self;
    
    
    //注册观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_myTextField];
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(50*Width, height_y(_myTextField)+10*Height, MainScreenWidth-100*Width, 40*Height)];
    self.nameTextField.clearsOnBeginEditing = YES;
    self.nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _nameTextField.layer.borderWidth = 1;
    _nameTextField.layer.cornerRadius = 5;
    _nameTextField.layer.borderColor = [RGB(200, 200, 200)CGColor];
    _nameTextField.placeholder = NSLocalizedString(@"add_2g_device_fragment_name_hint",nil);
    _nameTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:_nameTextField];
    _nameTextField.delegate = self;

    
    //确定
    UIButton *determineBt = [UIButton buttonWithType:UIButtonTypeCustom];
    determineBt.frame = CGRectMake(50*Width, height_y(_nameTextField)+20*Height, MainScreenWidth-100*Width, 40*Height);
    [determineBt setTitle:NSLocalizedString(@"select_date_fragment_yes", nil) forState:UIControlStateNormal];
    [determineBt setBackgroundImage:[UIColor clearColor].image forState:UIControlStateNormal];
    [determineBt setTitleColor:MainColor forState:UIControlStateNormal];
    determineBt.layer.borderWidth = 1;
    determineBt.layer.borderColor = MainColor.CGColor;
    determineBt.layer.cornerRadius = 10;
    determineBt.clipsToBounds = YES;
    determineBt.titleLabel.font = [UIFont systemFontOfSize:20];
    [determineBt addTarget:self action:@selector(determineBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineBt];

    //扫描
    UIButton *ewmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    ewmBt.frame = CGRectMake(50*Width, height_y(determineBt)+20*Height, MainScreenWidth-100*Width, 40*Height);
    [ewmBt setBackgroundImage:[UIColor clearColor].image forState:UIControlStateNormal];
    [ewmBt setTitleColor:MainColor forState:UIControlStateNormal];
    ewmBt.layer.borderWidth = 1;
    ewmBt.layer.borderColor = MainColor.CGColor;
    ewmBt.layer.cornerRadius = 10;
    ewmBt.clipsToBounds = YES;
    [ewmBt setTitle:NSLocalizedString(@"scan_2g_device_activity_title",nil) forState:UIControlStateNormal];
    ewmBt.titleLabel.font = [UIFont systemFontOfSize:20];
    [ewmBt addTarget:self action:@selector(ewmBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ewmBt];
    
    
}




-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _myTextField) {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        
        BOOL canChange = [string isEqualToString:filtered];
        
        return canChange;
    }else {
        return YES;
    }
    
}

#pragma mark **********************二维码***************
#pragma mark 扫描二维码
- (void)ewmBtAction:(UIButton *)button{
    
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader = [QRCodeReaderViewController new];
        });
        reader.delegate = self;

        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:reader animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"当前的设备不支持此功能" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }

}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"设备ID:%@",result);
        /**
         *  格式
         IMEI:86610402622272200000;
         DATE:2017-05-30;TYPE:GPRS;
         SIM:14766160532;
         ICCID:898600D69915C0155578
         */
        if ([result hasPrefix:@"VBLE:"]) {
            NSString *tempStr = [result substringWithRange:NSMakeRange(5,20)];
            NSLog(@"%@",tempStr);
            
            _deviceID = tempStr;
            _myTextField.text = tempStr;

           
        }else {
           [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"qr_useless_content",nil)];
        }
        
        
    }];
}
        

        
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark *****************手动输入******************************
#pragma mark 确定
- (void)determineBtAction:(UIButton *)button
{

    if (_myTextField.text.length != 20) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"add_2g_device_fragment_warn",nil)];
        return;
    }
   
    
    if (![LoginAuthentication validateFormat:_myTextField.text] ) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"add_2g_device_fragment_warn",nil)];
        return;

    }
    
    NSRange _range = [_myTextField.text rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"add_2g_device_fragment_warn",nil)];
        return;
    }
    
   
   
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:[_myTextField.text uppercaseString] forKey:@"deviceID"];
    if (_nameTextField.text == nil || _nameTextField.text.length < 1) {
        _nameTextField.text = NSLocalizedString(@"device_default_name",nil);
    }
    [reqDic setValue:[_nameTextField.text uppercaseString] forKey:@"deviceName"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic setValue:[self setDeviceModelAndindex:NO] forKey:@"configData"];
    [req reqDataWithUrl:SETBIND reqDic:reqDic reqHeadDic:nil];

    
}



//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark 限制密码长度
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
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
