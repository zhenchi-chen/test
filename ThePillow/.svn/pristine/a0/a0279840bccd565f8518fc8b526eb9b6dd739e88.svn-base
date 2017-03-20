//
//  LoginController.m
//  PingHuoTuan
//
//  Created by athudong04 on 15/12/25.
//  Copyright © 2015年 丁小城. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "ResetPasswordController.h"
#import "UITextFieldX.h"
#import "LoginCustomView.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "ListModel.h"

@interface LoginController ()<UITextFieldDelegate>
{
    NSString *customB;
}

// 手机号
@property (nonatomic,strong) UITextField *phoneTxf;
// 密码
@property (nonatomic,strong) UITextField *passwordTxf;
// 登录
@property (nonatomic,strong) UIButton *loginBtn;

@end

@implementation LoginController

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"第一页"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code != 200) {
                //弹窗
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"login_fragment_warn_5", nil) message:NSLocalizedString(@"login_fragment_warn_6", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"can_you_concern_device_fragment_cancel", nil) otherButtonTitles:NSLocalizedString(@"add_bluetooth_device_fragment_yes", nil), nil];
                [alert show];
                alert.delegate = self;
                alert.tag = 3;
                //需要把定义alert加到父视图
                [self.view addSubview:alert];
            }else {
                
                NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
                [saveDic setValue:[dataDic objectForKey:@"username"] forKey:@"username"];
                [saveDic setValue:[dataDic objectForKey:@"token"] forKey:@"token"];
                [saveDic setValue:customB forKey:@"userpassword"];
                [[ListTheCacheClass sharedManager]saveData:saveDic];
//                NSLog(@"username = %@,token = %@",[dataDic objectForKey:@"username"],[dataDic objectForKey:@"token"]);
                if (dataDic != nil) {
                    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
                    req.myDelegate = self;
                    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
                    [reqDic setValue:@"列表" forKey:@"api"];
                    [reqDic setValue:[dataDic objectForKey:@"username"] forKey:@"username"];
                    [reqDic setValue:[dataDic objectForKey:@"token"] forKey:@"token"];
                    [req reqDataWithUrl:DEVICE_LIST reqDic:reqDic reqHeadDic:nil];
                }
                
                
            }
        } else {
    
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
        
    } else if ([api isEqualToString:@"列表"]) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code == 200) {
                //解析列表数据
                [[UpdateDeviceData sharedManager]setDeviceData:[dataDic objectForKey:@"Items"]];
                NSArray *devcieArr = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];;
                if (devcieArr.count == 0) {
                    kAppDelegate.window.rootViewController = kAppDelegate.nc2;
                    [de setValue:@"1" forKey:@"bind_myTag"];
                } else {
                    kAppDelegate.window.rootViewController = kAppDelegate.nc1;
                }
                
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
        }
    }
}


/*
#pragma mark 解析后台数据
- (void)getData {
    NSArray *devcieArr = [dataDic objectForKey:@"Items"];
    for (int i = 0;i<devcieArr.count; i++) {
        DidInfoModel *didInfoModel = [[DidInfoModel alloc]init];
        NSDictionary *devcieDicTemp = [devcieArr objectAtIndex:i];
        NSDictionary *didInfoDicTemp = [devcieDicTemp objectForKey:@"didInfo"];
        NSDictionary *didInfoDicTempS = [GWNSStringUtil dictionaryToJsonString:[didInfoDicTemp objectForKey:@"S"]];
        //                        didInfoModel.deviceName = [devcieDicTemp objectForKey:@"did"];
        didInfoModel.deviceName = [[devcieDicTemp objectForKey:@"devicename"] objectForKey:@"S"];
        didInfoModel.softwareVersion = [didInfoDicTempS objectForKey:@"softwareVersion"];
        didInfoModel.hardwareVersion = [didInfoDicTempS objectForKey:@"hardwareVersion"];
        didInfoModel.rule = [[devcieDicTemp objectForKey:@"rule"] objectForKey:@"S"];
        didInfoModel.isHome = [didInfoDicTempS objectForKey:@"isHome"];
        if ([didInfoModel.isHome intValue] == 1) {
            NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
            [saveDic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"isDevice"];
            [[ListTheCacheClass sharedManager]saveData:saveDic];
        }
        didInfoModel.type = [didInfoDicTempS objectForKey:@"type"];
        NSArray *tempBindArr = [didInfoDicTempS objectForKey:@"bind"];
        didInfoModel.bind = [NSMutableArray array];
        for (int i = 0; i < tempBindArr.count; i++) {
            NSDictionary *dicTemp = (NSDictionary *)[tempBindArr objectAtIndex:i];
            [didInfoModel.bind addObject:dicTemp];
        }
        UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:[[devcieDicTemp objectForKey:@"userInfo"] objectForKey:@"S"]]];
        
        ConfigModel *snoreModel = [[ConfigModel alloc]init];
        
        NSDictionary *selectDicTempS  = [GWNSStringUtil dictionaryToJsonString:[[devcieDicTemp objectForKey:@"snore"] objectForKey:@"S"]];
        snoreModel.select = [selectDicTempS objectForKey:@"snoreSelect"];
        snoreModel.isValid = [selectDicTempS objectForKey:@"isValid"];
        NSArray *tempCustomArr = [selectDicTempS objectForKey:@"custom"];
        NSMutableArray *customArray = [NSMutableArray array];
        for (int i = 0; i<tempCustomArr.count; i++) {
            NSDictionary *tempDic = (NSDictionary *)[tempCustomArr objectAtIndex:i];
            CustomModel *custom =[CustomModel objectWithKeyValues:tempDic];
            [customArray addObject:custom];
        }
        snoreModel.custom = [CustomModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:customArray]];
        
        ConfigModel *clockMode = [[ConfigModel alloc]init];
        
        NSDictionary *clockDicTempS = [GWNSStringUtil dictionaryToJsonString:[[devcieDicTemp objectForKey:@"clock"] objectForKey:@"S"]];
        NSDictionary *clockModeDicTemp = [clockDicTempS objectForKey:@"clockMode"];
        clockMode.select = [clockModeDicTemp objectForKey:@"clockSelect"];
        clockMode.isValid = [clockModeDicTemp objectForKey:@"isValid"];
        NSArray *tempCustomArray = [clockModeDicTemp objectForKey:@"custom"];
        NSMutableArray *customTempArr = [NSMutableArray array];
        for (int i=0; i<tempCustomArray.count; i++) {
            NSDictionary *tempDic = (NSDictionary *)[tempCustomArray objectAtIndex:i];
            CustomModel *custom =[CustomModel objectWithKeyValues:tempDic];
            [customTempArr addObject:custom];
        }
        clockMode.custom = [CustomModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:customTempArr]];
        
        Clock *clock = [[Clock alloc]init];
        clock.clockMode = clockMode;
        clock.isValid = [clockDicTempS objectForKey:@"isValid"];
        NSArray *tempClockTimeArr = [clockDicTempS objectForKey:@"clockTime"];
        NSMutableArray *clockTimeTempArr = [NSMutableArray array];
        for (int i=0; i<tempClockTimeArr.count; i++) {
            ClockTimeModel *clockTimeModel = [[ClockTimeModel alloc]init];
            NSDictionary *tempClockTimeDic = [tempClockTimeArr objectAtIndex:i];
            clockTimeModel.week = [tempClockTimeDic objectForKey:@"week"];
            clockTimeModel.hour = [tempClockTimeDic objectForKey:@"hour"];
            clockTimeModel.min = [tempClockTimeDic objectForKey:@"min"];
            clockTimeModel.times = [tempClockTimeDic objectForKey:@"times"];
            clockTimeModel.run = [tempClockTimeDic objectForKey:@"run"];
            clockTimeModel.name = [tempClockTimeDic objectForKey:@"name"];
            clockTimeModel.ringTime = [tempClockTimeDic objectForKey:@"ringTime"];
            [clockTimeTempArr addObject:clockTimeModel];
        }
        clock.clockTime = [ClockTimeModel keyValuesArrayWithObjectArray:[NSArray arrayWithArray:clockTimeTempArr]];
        
        deviceModel = [[DeviceModel alloc]init];
        NSDictionary *didDicTemp = [devcieDicTemp objectForKey:@"did"];
        deviceModel.did = [didDicTemp objectForKey:@"S"];
        NSDictionary *timeStampDicTemp =  [devcieDicTemp objectForKey:@"timeStamp"];
        deviceModel.timeStamp = [timeStampDicTemp objectForKey:@"S"];
        NSDictionary *didInfoDic = [didInfoModel keyValues];
        deviceModel.didInfo = [GWNSStringUtil convertToJSONString:didInfoDic];
        NSDictionary *userInfoDic = [userInfoModel keyValues];
        deviceModel.userInfo = [GWNSStringUtil convertToJSONString:userInfoDic];
        NSDictionary *snoreDic = [snoreModel keyValues];
        deviceModel.snore = [GWNSStringUtil convertToJSONString:snoreDic];
        //                        NSLog(@"%@",clock.clockMode.select);
        NSDictionary *clockDic = [clock keyValues];
        deviceModel.clock = [GWNSStringUtil convertToJSONString:clockDic];
        deviceModel.isServer = @"1";
        [[[DeviceListTool alloc]init] insertDeviceList:deviceModel];
        
        //测试
        //                        NSDictionary *deviceDic = [deviceModel keyValues];
        //                        NSLog(@"后台下来的数据 : %@",[GWNSStringUtil convertToJSONString:deviceDic]);
        NSLog(@"didInfo = %@,userInfo = %@,snore = %@,clock = %@",[GWNSStringUtil convertToJSONString:didInfoDic],[GWNSStringUtil convertToJSONString:userInfoDic],[GWNSStringUtil convertToJSONString:snoreDic],[GWNSStringUtil convertToJSONString:clockDic]);
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColorWhite;
    
    [self setNacColorWhite];
    
    [self initView];
}

#pragma mark 初始化界面
-(void)initView{
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 64)];
    navView.backgroundColor = MainColorWhite;
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainScreenWidth, 40)];
    title.text = NSLocalizedString(@"login_fragment_welcome", nil);
    title.textColor = MainColorBlack;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:20];
    [navView addSubview:title];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(50*Width,height_y(navView), MainScreenWidth-100*Width, 20*Height)];
    titleLb.text = NSLocalizedString(@"login_fragment_welcome", nil);
    titleLb.font = [UIFont systemFontOfSize:20];
    titleLb.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLb];
    
    
    UILabel *titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(titleLb.x,height_y(navView)+20*Height, titleLb.width, 20*Height)];
    titleLb1.text = NSLocalizedString(@"login_fragment_content", nil);
    titleLb1.textColor = RGB(178, 178, 178);
    titleLb1.font = [UIFont systemFontOfSize:12];
    titleLb1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLb1];
    

    
    
    

    
    //用户名
    UITextField *phoneView = [[UITextField alloc]initWithFrame:CGRectMake(titleLb.x, height_y(titleLb1)+60*Height, titleLb.width, 50)];
    phoneView.clearsOnBeginEditing = YES;
    phoneView.clearButtonMode = UITextFieldViewModeAlways;
    phoneView.delegate = self;
    phoneView.textColor = [UIColor blackColor];
    phoneView.placeholder = NSLocalizedString(@"login_fragment_hint", nil);
    phoneView.tag = 1;
    phoneView.text = [de valueForKey:@"username"];
    phoneView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    phoneView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneView];
    
    UIView  *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(phoneView.x, height_y(phoneView)-10, phoneView.width, 1)];
    lineView1.backgroundColor = MainColorLightGrey;
    [self.view addSubview:lineView1];

    
    //密码
    UITextField *passwordView = [[UITextField alloc]initWithFrame:CGRectMake(phoneView.x, height_y(phoneView)+10*Height, phoneView.width, 50)];
    passwordView.clearsOnBeginEditing = YES;
    passwordView.clearButtonMode = UITextFieldViewModeAlways;
    passwordView.delegate = self;
    passwordView.textColor = RGB(178, 178, 178);
    passwordView.placeholder = NSLocalizedString(@"login_fragment_hint_2", nil);
    passwordView.tag = 2;
    passwordView.secureTextEntry = YES;
    passwordView.text = [de valueForKey:@"userpassword"];
    passwordView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //提示居中
    passwordView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:passwordView];
    
    UIView  *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(phoneView.x, height_y(passwordView)-10, phoneView.width, 1)];
    lineView2.backgroundColor = MainColorLightGrey;
    [self.view addSubview:lineView2];
    
    
    //登陆
    _loginBtn = [self buildBtn:NSLocalizedString(@"login_fragment_content_2", nil) action:@selector(loginBtnTapped) frame:CGRectMake(100*Width, height_y(lineView2)+40*Height,  MainScreenWidth-200*Width, 50)];
       [self.view addSubview:_loginBtn];
    
    
    // 注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(_loginBtn.x, height_y(_loginBtn)+20*Height,0, 0);
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [registerBtn setTitle:NSLocalizedString(@"login_fragment_content_3", nil) forState:UIControlStateNormal];
    [registerBtn setTitleColor:RGB(178, 178, 178) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerBtn addTarget:self action:@selector(registerBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    // 根据字体得到NSString的尺寸
    CGSize registerBtnSize = [registerBtn.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:registerBtn.titleLabel.font,NSFontAttributeName, nil]];
    registerBtn.size = registerBtnSize;
    registerBtn.centerX = _loginBtn.centerX;
    [self.view addSubview:registerBtn];
    
    UIView  *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(registerBtn.x, height_y(registerBtn), registerBtn.width, 1)];
    lineView3.backgroundColor = MainColorLightGrey;
    [self.view addSubview:lineView3];



    /*
    
    // 微信登录
    UIButton *wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatLoginBtn.layer.cornerRadius = 70 / 2.0;
    wechatLoginBtn.clipsToBounds = YES;
    [wechatLoginBtn setImage:[UIImage imageNamed:@"103"] forState:UIControlStateNormal];
    [self.view addSubview:wechatLoginBtn];
  
    [wechatLoginBtn addTarget:self action:@selector(wechatLoginBtnTapped) forControlEvents:UIControlEventTouchUpInside];
     */
}

#pragma mark 微信登陆
- (void)wechatLoginBtnTapped
{
    //先判断用户是否安装微信
    //    if ([WXApi isWXAppInstalled]) {
//    [WXApiRequestHandler sendAuthRequestScope: @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
//                                        State:@"b5ad56863e01601a7d690c4aad1c4274"
//                                       OpenID:@"wx0a9bf07480b844df"
//                             InViewController:self];
    //    }

}

#pragma mark 登录
-(void)loginBtnTapped{
    //定义字符串接收输入框内容
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1];
    NSString *customA = textField1.text;
    UITextField *textField2 =(UITextField *)[self.view viewWithTag:2];
    customB = textField2.text;

    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"第一页" forKey:@"api"];
    [reqDic setValue:customA forKey:@"username"];
    [reqDic setValue:customB forKey:@"password"];
    [req reqDataWithUrl:LOGIN reqDic:reqDic reqHeadDic:nil];

}

//协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if ([self.view viewWithTag:3]) {
        if (buttonIndex == 1) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_fragment_warn_6", nil)];
        }
    }
    
}

#pragma mark 注册
-(void)registerBtnTapped{
    
    RegisterController * registerVC = [[RegisterController alloc]init];
    [ registerVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController: registerVC animated:YES completion:nil];
//    [self.navigationController pushViewController:[[RegisterController alloc] init] animated:YES];
}

#pragma mark 忘记密码
-(void)forgatBtnTapped{
    ResetPasswordController * resetPasswordVC = [[ResetPasswordController alloc]init];
    [resetPasswordVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController: resetPasswordVC animated:YES completion:nil];

//    [self.navigationController pushViewController:[[ResetPasswordController alloc] init] animated:YES];
}

//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
