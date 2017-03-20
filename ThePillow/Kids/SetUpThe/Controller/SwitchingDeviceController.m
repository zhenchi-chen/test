//
//  SwitchingDeviceController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/24.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "SwitchingDeviceController.h"
#import "SwitchingDeviceCell.h"
#import "AddViewController.h"
#import "SetDeiceViewController.h"
#import "SetDeiceRightViewController.h"



@interface SwitchingDeviceController ()<UITableViewDataSource,UITableViewDelegate,SwitchingDeviceCellDelegate>
{
    NSInteger deleteDevcie; //你选择删除的是哪一个
    UILabel *titleLb;
    UIView *headerView;
   
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *listArray; //设备列表

@property (nonatomic,strong)NSString *devcieIDD; //当前选择的设备
@property (nonatomic,strong)NSString *deleteDevcieIDD; //当前删除的设备




@end

@implementation SwitchingDeviceController


#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"解绑设备"]) {
        
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            if (baseModel.code == 200) {
                //删除缓存
                [[[DeviceListTool alloc]init]deleteData:_deleteDevcieIDD];
                [_listArray removeObjectAtIndex:deleteDevcie];

                [_tableView reloadData];
                
                NSDictionary *dic = [[ListTheCacheClass sharedManager]readData];
                NSInteger isDevice = [[dic valueForKey:@"isDevice"] integerValue];
                
                //判断删除的是否是正在显示的
                if (deleteDevcie == isDevice) {
                    //将第一个设为主页
                    [self showSwitchingDeviceCellTap:0];
                    
                }else {
                    
                    NSMutableDictionary *savedic = [NSMutableDictionary dictionary];
                    [savedic setValue:[NSString stringWithFormat:@"%ld",deleteDevcie-1] forKey:@"isDevice"];
                    [[ListTheCacheClass sharedManager]saveData:savedic];
                }
                
                if (_listArray.count == 0) {
                    titleLb.text = @"你的设备列表空空如也!";
                }else {
                    titleLb.text = @"";
                }
                
            }
        [SVProgressHUD dismiss];
    }else if ([api isEqualToString:@"设备列表"]) {
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"dic = %@",dic);
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
            NSDictionary *dataDic = (NSDictionary *)baseModel.data;
            if (baseModel.code == 200) {
                if (baseModel.data != nil) {
                    NSArray *tempArr = [dataDic objectForKey:@"Items"];
                    
                    //添加新设备
                    [[UpdateDeviceData sharedManager]addDeviceData:tempArr andDeviceId:nil];
                    
                    if (_listArray != nil) {
                        [_listArray removeAllObjects];
                    }
                    _listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
                    [_tableView reloadData];
                    
                    if (_listArray.count == 0) {
                        titleLb.text = @"你的设备列表空空如也!";
                    }else {
                        titleLb.text = @"";
                    }
                    [_tableView headerEndRefreshing]; //让下拉刷新控件消失
                } else {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"detail_fragment_chart_no_data", nil)];
                    
                }
            } else {
                [_tableView headerEndRefreshing]; //让下拉刷新控件消失
            }
        } else {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"net_wrong_prompt", nil)];
            [_tableView headerEndRefreshing]; //让下拉刷新控件消失
        }
    }
}

#pragma mark 导航栏左边返回上一个页面
- (void)navigationLeftButton:(UIButton *)button{
    
//    [SVProgressHUD showWithStatus:@"正在同步中请稍等.."];

    if (_listArray.count == 0) {
        kAppDelegate.window.rootViewController = kAppDelegate.nc2;
        [de setValue:@"1" forKey:@"bind_myTag"];
        //返回到第一个页面
        [kAppDelegate.nc1 popToRootViewControllerAnimated:YES];
    }else {
        //返回到上一个页面
        [self.navigationController popViewControllerAnimated:YES];
         [GWNotification pushHandle:nil withName:@"返回首页"];
    }
}



#pragma maek 头部View显示
- (void)createHeaderView {
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 0)];
    
    UILabel *promptLb = [[UILabel alloc]init];
    promptLb.textColor = MainColorDarkGrey;
    promptLb.y = 0;
    promptLb.text = @"点击头像设为首页";
    promptLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize promptLbSize = [promptLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:promptLb.font,NSFontAttributeName, nil]];
    promptLb.size = promptLbSize;
    [promptLb sizeToFit];
    promptLb.centerX = headerView.centerX;
    [headerView addSubview:promptLb];
    
    headerView.height = height_y(promptLb)+10*Height;
}

#pragma mark 页面已经出现
- (void)viewDidAppear:(BOOL)animated {
    
    
}

#pragma mark 页面即将出现
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:NSLocalizedString(@"device_list_fragment_title",nil)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNacColorWhite];
    
    _listArray = [NSMutableArray array];
    _listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
    
    //导航右边按钮
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    [rightBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(navigationAddButtons:) forControlEvents:UIControlEventTouchUpInside];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    [self createHeaderView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //分割线不显示
    [self.view addSubview:_tableView];
    
    //下拉刷新
    [_tableView addHeaderWithTarget:self action:@selector(headReloadDataUITableView)];
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        if (_listArray != nil) {
            [_listArray removeAllObjects];
        }
        _listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
        [_tableView reloadData];
        
        if (_listArray.count == 0) {
            titleLb.text = @"你的设备列表空空如也!";
        }else {
            titleLb.text = @"";
        }
    } withName:@"更新设备信息_设备列表页"];
    
    [GWNotification addHandler:^(NSDictionary *handleDic) {
        
        if ([[handleDic objectForKey:@"isSelf"] intValue] == 0) {
            return ;
        }
        if (_listArray != nil) {
            [_listArray removeAllObjects];
        }
        _listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
//        [_tableView reloadData];
        if (_tableView.visibleCells.count>0) {
            for (int i=0; i<_tableView.visibleCells.count; i++) {
                SwitchingDeviceCell *cell = [_tableView.visibleCells objectAtIndex:i];
                deviceModel = [_listArray objectAtIndex:i];
                DidInfoModel *didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.didInfo]];
                if ([didInfoModel.isHome intValue] == 1) {
                    cell.tagIV.image = [UIImage imageNamed:@"homePageA"];
                    cell.tagIV.backgroundColor = MainColorWhite;
                    
                }else {
                    cell.tagIV.image = [UIImage imageNamed:@"无效"];
                    cell.tagIV.backgroundColor = [UIColor clearColor];
                    
                }
            }
            
        }
        
    } withName:@"更换首页_设备列表页"];


    titleLb = [[UILabel alloc]init];
    titleLb.size = CGSizeMake(MainScreenWidth, 30);
    titleLb.center = self.view.center;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = MainColorDarkGrey;
    titleLb.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLb];
    
    
}


#pragma mark 请求数据
- (void)initData
{
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"设备列表" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [req reqDataWithUrl:DEVICE_LIST reqDic:reqDic reqHeadDic:nil];
    
}


#pragma mark 下拉刷新
- (void)headReloadDataUITableView
{
    
    [self initData];
}

#pragma mark 添加设备
- (void)navigationAddButtons:(UIButton *)button {
    AddViewController *addVC = [[AddViewController alloc]init];
    [de setValue:@"3" forKey:@"bind_myTag"];
    [self.navigationController pushViewController:addVC animated:YES];
}




#pragma maek 设为主页 *******************************************************
- (void)showSwitchingDeviceCellTap:(NSInteger)tap{

    
    for (int i=0; i<_tableView.visibleCells.count; i++) {
        SwitchingDeviceCell *cell = [_tableView.visibleCells objectAtIndex:i];
        deviceModel = [_listArray objectAtIndex:i];
        if (i==tap) {
            cell.tagIV.image = [UIImage imageNamed:@"homePageA"];
            cell.tagIV.backgroundColor = MainColorWhite;
            [[UpdateDeviceData sharedManager]setUpdateDataDevice:deviceModel];
            
        } else {
            cell.tagIV.image = [UIImage imageNamed:@"无效"];
            cell.tagIV.backgroundColor = [UIColor clearColor];
        }
    }
    if (_listArray != nil) {
        [_listArray removeAllObjects];
    }
    _listArray = [[[DeviceListTool alloc]init]queryAllDeviceListShowModels];
    [GWNotification pushHandle:nil withName:@"更换首页"];
    
}



#pragma mark *****************************************************************************

#pragma -mark每个分区里面有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma -mark创建每个cell的方法

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusepool = @"cell";
    SwitchingDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:reusepool];
    if (cell == nil) {
        cell = [[SwitchingDeviceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusepool];
    }
    cell.delegate = self;
    cell.cellTag = indexPath.section;
    deviceModel = [_listArray objectAtIndex:indexPath.section];
    DidInfoModel *didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.didInfo]];
    UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModel.userInfo]];
    
    cell.photoIV.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
    
    if ([deviceModel.rule isEqualToString:@"read"]) {
        cell.isBluetoothSensorView.backgroundColor = [UIColor clearColor];
    } else {
        if (deviceModel.did.length==12) {
            if ([[UpdateDeviceData sharedManager]isSetBluetoothSensorDevice:deviceModel]) {
                cell.isBluetoothSensorView.backgroundColor = RGB(224, 72, 61);
            } else {
                cell.isBluetoothSensorView.backgroundColor = [UIColor clearColor];
            }
        }else {
            if ([deviceModel.isServer isEqualToString:@"1"]) {
                cell.isBluetoothSensorView.backgroundColor = [UIColor clearColor];
            }else {
                cell.isBluetoothSensorView.backgroundColor = RGB(224, 72, 61);
                
            }
        }
        
    }
    
    
    if ([didInfoModel.isHome isEqualToString:@"1"]) {
        cell.tagIV.image = [UIImage imageNamed:@"homePageA"];
        cell.tagIV.backgroundColor = MainColorWhite;
        NSLog(@"did = %@",deviceModel.did);
    }else {
        cell.tagIV.image = [UIImage imageNamed:@"无效"];
        cell.tagIV.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.didLb.text = [NSString stringWithFormat:@"ID:%@",deviceModel.did];
    
    cell.nameLb.text = didInfoModel.deviceName;
    //点击cell的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


#pragma -mark设置cell的高度的方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
   
}


#pragma mark -- 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    deviceModel = [_listArray objectAtIndex:indexPath.section];
    if ([deviceModel.rule isEqualToString:@"read"]) {
        SetDeiceRightViewController *setDeiceRightVC = [[SetDeiceRightViewController alloc]init];
        setDeiceRightVC.device = deviceModel;
        [self.navigationController pushViewController:setDeiceRightVC animated:YES];
    } else {
        SetDeiceViewController *setDeiceVC = [[SetDeiceViewController alloc]init];
        setDeiceVC.device = deviceModel;
        [self.navigationController pushViewController:setDeiceVC animated:YES];
    }
    
    
    

}

//设置分区个数,默认为1个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;
}

//分区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
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
    deleteDevcie = indexPath.section;
    deviceModel = [_listArray objectAtIndex:indexPath.section];
    _deleteDevcieIDD  = deviceModel.did;
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"解绑设备" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic setValue:deviceModel.did forKey:@"deviceID"];
    [req reqDataWithUrl:UNBIND reqDic:reqDic reqHeadDic:nil];
    _devcieIDD = deviceModel.did;
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"net_loading", nil)];
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
