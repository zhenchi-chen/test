//
//  SetDeiceViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/12.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetDeiceViewController.h"
#import "ChooseAvatarView.h"
#import "PersonalInformationModel.h"
#import "UIImage+LXDCreateBarcode.h" //二维码生成
#import "SnoreSetViewViewController.h"
#import "PersonalInformationViewController.h"
#import "SnoreAuxiliaryViewController.h"
#import "SetDeiceRightViewController.h"
#import "SetAlarmClockViewController.h"
#import "BindingBluetoothViewController.h"

@interface SetDeiceViewController ()<HttpBaseRequestUtilDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *headView;
    UIView *footerView;
    UILabel *isBluetoothLb; //是否同步蓝牙
    UIImageView *faceIv; //头像
    UILabel *nameLb; //名字
    UILabel *getNameLb; //名字
    UIView *backgroundView; //弹窗底色
    int chooseAvatarNum; //你点击的图片
   

    UIView *ewmView;  //生成二维码
    UIView *beijiView;
    UIImageView *ermImage;
    DidInfoModel *didInfoModel;
    UserInfoModel *userInfoModel;
    UIButton *rightBt;
   
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *setArray;



@end

@implementation SetDeiceViewController

#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"解绑设备"]) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //            NSLog(@"dic = %@",dic);
        BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
        if (baseModel.code == 200) {
            //删除缓存
            [[[DeviceListTool alloc]init]deleteData:_device.did];
            
            NSMutableArray *listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
            if (listArray.count ==  0) {
                kAppDelegate.window.rootViewController = kAppDelegate.nc2;
                [de setValue:@"1" forKey:@"bind_myTag"];
                //返回到第一个页面
                [kAppDelegate.nc1 popToRootViewControllerAnimated:YES];
            }
            
            //判断删除的是否是正在显示的
            if ([didInfoModel.isHome isEqualToString:@"1"]) {
                //将第一个设为主页
                NSMutableDictionary *savedic = [NSMutableDictionary dictionary];
                [savedic setValue:[NSString stringWithFormat:@"%d",0] forKey:@"isDevice"];
                [[ListTheCacheClass sharedManager]saveData:savedic];
                [[UpdateDeviceData sharedManager]setUpdateDataDevice:nil];
                [GWNotification pushHandle:nil withName:@"更换首页"];
                [GWNotification pushHandle:nil withName:@"更新设备信息"];
            }
            //返回到上一个页面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

    
}



#pragma mark 头部显示
- (void)headerView {
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 180*Height)];
    headView.backgroundColor =MainColorWhite;
    
    isBluetoothLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10*Height, MainScreenWidth-20, 20)];
    isBluetoothLb.textColor = [UIColor redColor];
    isBluetoothLb.alpha = 0.6;
    if (_device.did.length==12) {
        if ([[UpdateDeviceData sharedManager]isSetBluetoothSensorDevice:_device]) {
            isBluetoothLb.text = @"新的配置将在蓝牙连接设备后生效";
        } else {
            isBluetoothLb.text = @" ";
        }
    }else {
        if ([_device.isServer isEqualToString:@"1"]) {
            isBluetoothLb.text = @" ";
        }else {
            isBluetoothLb.text = @"新的配置将在网络连接设备后生效";
        }
    }
    
    isBluetoothLb.textAlignment = NSTextAlignmentCenter;
    isBluetoothLb.font = [UIFont systemFontOfSize:12];
    [headView addSubview:isBluetoothLb];
    
    
    faceIv = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-45*Height, 30*Height, 90*Height, 90*Height)];
    faceIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
//    faceIv.userInteractionEnabled  = YES;
    [headView addSubview:faceIv];


    
    
    nameLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, height_y(faceIv)+5*Height, (MainScreenWidth-40*Width)/2, 20*Height)];
    nameLb.text = didInfoModel.deviceName;
    nameLb.textColor = MainColorDarkGrey;
    nameLb.font = [UIFont systemFontOfSize:12];
    nameLb.textAlignment = NSTextAlignmentCenter;
    nameLb.centerX = faceIv.centerX;
    [headView addSubview:nameLb];
    
    getNameLb = [[UILabel alloc]init];
    getNameLb.textColor = MainColorDarkGrey;
    getNameLb.font = [UIFont systemFontOfSize:12];
    getNameLb.text = @"修改";
    // 根据字体得到NSString的尺寸
    CGSize getNameLbSize = [getNameLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:getNameLb.font,NSFontAttributeName, nil]];
    getNameLb.size = getNameLbSize;
    [getNameLb sizeToFit];
    getNameLb.centerY = nameLb.centerY;
    getNameLb.x = MainScreenWidth-getNameLb.width-20*Width;
    [headView addSubview:getNameLb];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(getNameLb.x, height_y(getNameLb), getNameLb.width, 1)];
    line.backgroundColor = MainColorLightGrey;
    [headView addSubview:line];
    
    UIView *btView = [[UIView alloc]initWithFrame:CGRectMake(line.x-10*Width, getNameLb.y-10*Height, getNameLb.width+20*Width, getNameLb.height+20*Height+1)];
    btView.userInteractionEnabled  = YES;
//    btView.backgroundColor = [UIColor orangeColor];
    [headView addSubview:btView];
    
    
    //轻拍手势 UITapGestureRecognizer
    MyTap *tap = [[MyTap alloc]initWithTarget:self action:@selector(btViewAction)];
    [btView addGestureRecognizer:tap];
  
}

#pragma mark 修改名字
- (void)btViewAction {
    
    BindingBluetoothViewController *bindingBluetoothVC = [[BindingBluetoothViewController alloc]init];
    bindingBluetoothVC.myTag = 4;
    bindingBluetoothVC.device = _device;
    [self.navigationController pushViewController:bindingBluetoothVC animated:YES];
    
}

#pragma mark 加载FooterView
- (void)initFooterView
{
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 90)];
 
    UIButton *unbundlingBt = [self buildBtn:@"解绑设备"action:@selector(unbundlingBtAction:) frame:CGRectMake(MainScreenWidth/4, 20, MainScreenWidth/2, 50)];
    [footerView addSubview:unbundlingBt];
    
}

#pragma mark 解绑设备
- (void)unbundlingBtAction:(UIButton *)button {
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"解绑设备" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic setValue:_device.did forKey:@"deviceID"];
    [req reqDataWithUrl:UNBIND reqDic:reqDic reqHeadDic:nil];
}


#pragma mark 页面已经出现
- (void)viewDidAppear:(BOOL)animated {
    
    
    
}

#pragma mark 页面即将出现
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [GWStatisticalUtil onPageViewBegin:self withName:@"设备设置页"];
    
    
};

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self navSet:@"设备设置"];
    
    
   
    
//    NSLog(@"didInfo = %@",_device.didInfo);
    didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.didInfo]];
    userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.userInfo]];
    
    //导航右边按钮
    rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    if ([didInfoModel.isHome intValue] == 1) {
        [rightBt setImage:[UIImage imageNamed:@"homePageA"] forState:UIControlStateNormal];
    }else {
        [rightBt setImage:[UIImage imageNamed:@"homePageB"] forState:UIControlStateNormal];
    }
    [rightBt addTarget:self action:@selector(navigationButtonsrightBt:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
  
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        _device = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:_device.did];
        
//        NSLog(@"didInfo = %@",_device.didInfo);
        didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.didInfo]];
        userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.userInfo]];
        
        nameLb.text = didInfoModel.deviceName;
        faceIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
        
        if (_device.did.length==12) {
            if ([[UpdateDeviceData sharedManager]isSetBluetoothSensorDevice:_device]) {
                isBluetoothLb.text = @"新的配置将在蓝牙连接设备后生效";
            } else {
                isBluetoothLb.text = @" ";
            }
        }else {
            if ([_device.isServer isEqualToString:@"1"]) {
                isBluetoothLb.text = @" ";
            }else {
                isBluetoothLb.text = @"新的配置将在网络连接设备后生效";
            }
        }        
        
    } withName:@"更新设备信息_设备设置页"];
    
    //加载个人信息
    [self headerView];
    
    //解绑设备
    [self initFooterView];
    
    //标题数组
    self.setArray = [[NSMutableArray alloc]initWithObjects:@"止鼾辅助",@"闹钟设置",@"个人信息",@"分享二维码", nil];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    _tableView.backgroundColor = [UIColor whiteColor];
    //分割线颜色
    _tableView.separatorColor = RGB(212, 212, 212);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = footerView;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableHeaderView = headView;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
}

#pragma -mark 设为主页
- (void)navigationButtonsrightBt:(UIButton *)button {

    if ([didInfoModel.isHome intValue] == 0) {
        didInfoModel.isHome = @"1";
        [button setImage:[UIImage imageNamed:@"homePageA"] forState:UIControlStateNormal];
        
        [[UpdateDeviceData sharedManager]setUpdateDataDevice:_device];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setValue:[NSString stringWithFormat:@"%d",1] forKey:@"isSelf"];
        [GWNotification pushHandle:[tempDic copy] withName:@"更换首页"];
        
    }

}


#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    
    cell.textLabel.text = [_setArray objectAtIndex:indexPath.section];
    cell.textLabel.textColor = MainColorDarkGrey;
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == _setArray.count-1) {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SnoreAuxiliaryViewController *snoreAuxiliaryVC = [[SnoreAuxiliaryViewController alloc]init];
        snoreAuxiliaryVC.device = _device;
        [self.navigationController pushViewController:snoreAuxiliaryVC animated:YES];
    }else if (indexPath.section == 1) {
        SetAlarmClockViewController *setAlarmClockVC = [[SetAlarmClockViewController alloc]init];
        setAlarmClockVC.device = _device;
        [self.navigationController pushViewController:setAlarmClockVC animated:YES];
    }else if (indexPath.section == 2) {
        PersonalInformationViewController *personalInformationVC = [[PersonalInformationViewController alloc]init];
        personalInformationVC.device = _device;
        [self.navigationController pushViewController:personalInformationVC animated:YES];
    }else if (indexPath.section == 3) {
        [self showSwitchingDeviceCell];
    }


}


//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _setArray.count;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma maek 点击生成我的二维码 *******************************************************
- (void)showSwitchingDeviceCell{
    if (ewmView == nil) {
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        ewmView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        ewmView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [window addSubview:ewmView];
        MyTap *tapView = [[MyTap alloc]initWithTarget:self action:@selector(ewmViewAction:)];
        [ewmView addGestureRecognizer:tapView];
        
        
    }
    
    if (ermImage == nil) {
        
        UIImage * image = [UIImage imageOfQRFromURL:[NSString stringWithFormat:@"VBLE:%@",_device.did] codeSize: 300 red: 0 green: 0 blue: 0 insertImage: [UIImage imageNamed: @"app_store"] roundRadius: 15.0f];
        CGSize size = image.size;
        
        beijiView = [[UIView alloc]init];
        beijiView.x = (MainScreenWidth -300)/2;
        beijiView.y = (MainScreenHeight -300)/2;
        beijiView.size = image.size;
        beijiView.center = ewmView.center;
        beijiView.backgroundColor = [UIColor whiteColor];
        [ewmView addSubview:beijiView];
        
        ermImage = [[UIImageView alloc] initWithFrame:  ((CGRect){(CGPointZero), (size)})];
        ermImage.image = image;
        [beijiView addSubview: ermImage];
        
        
        
    }
    
    
}

#pragma maek 二维码消失
- (void)ewmViewAction:(MyTap *)tap {
    if (ewmView != nil) {
        [ewmView removeFromSuperview];
        ewmView = nil;
    }
    
    if (ermImage != nil) {
        [ermImage removeFromSuperview];
        ermImage = nil;
    }
    
    if (beijiView != nil) {
        [beijiView removeFromSuperview];
        beijiView = nil;
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
