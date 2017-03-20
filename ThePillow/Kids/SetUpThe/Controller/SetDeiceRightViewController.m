//
//  SetDeiceRightViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/21.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetDeiceRightViewController.h"


@interface SetDeiceRightViewController ()<HttpBaseRequestUtilDelegate>
{
    UIButton *explainBt;
    DidInfoModel *didInfoModel;
    UserInfoModel *userInfoModel;

}



@end

@implementation SetDeiceRightViewController
#pragma 网络数据返回
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic{
    if ([api isEqualToString:@"解绑设备"]) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //            NSLog(@"dic = %@",dic);
        BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
        if (baseModel.code == 200) {
            //删除缓存
            [[[DeviceListTool alloc]init]deleteData:_device.did];

            //判断删除的是否是正在显示的
            if ([didInfoModel.isHome isEqualToString:@"1"]) {
                //将第一个设为主页
                NSMutableDictionary *savedic = [NSMutableDictionary dictionary];
                [savedic setValue:[NSString stringWithFormat:@"%d",0] forKey:@"isDevice"];
                [[ListTheCacheClass sharedManager]saveData:savedic];
                [[UpdateDeviceData sharedManager]setUpdateDataDevice:nil];
                [GWNotification pushHandle:nil withName:@"更换首页"];
            }else {
                [GWNotification pushHandle:nil withName:@"更新设备信息"];
            }
            //返回到上一个页面
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"设备设置"];
   
    didInfoModel = [DidInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.didInfo]];
    userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:_device.userInfo]];
//    NSLog(@"didInfo isHome= %@",didInfoModel.isHome);
     NSLog(@"现在是:%@,ishome:%@",_device.did,didInfoModel.isHome);
    
    //导航右边按钮
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    if ([didInfoModel.isHome intValue] == 1) {
        [rightBt setImage:[UIImage imageNamed:@"homePageA"] forState:UIControlStateNormal];
    }else {
        [rightBt setImage:[UIImage imageNamed:@"homePageB"] forState:UIControlStateNormal];
    }
    [rightBt addTarget:self action:@selector(navigationButtonsrightBt:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    
    
    //加载主要元素的内容
    [self layoutView];
    
    


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
- (void)explainBtAction:(UIButton *)button {
    
    
    HttpBaseRequestUtil *req = [[HttpBaseRequestUtil alloc] init];
    req.myDelegate = self;
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionary];
    [reqDic setValue:@"解绑设备" forKey:@"api"];
    [reqDic setValue:[de valueForKey:@"username"] forKey:@"username"];
    [reqDic setValue:[de valueForKey:@"token"] forKey:@"token"];
    [reqDic setValue:_device.did forKey:@"deviceID"];
    [req reqDataWithUrl:UNBIND reqDic:reqDic reqHeadDic:nil];
    
}

- (void)layoutView {
    
    UIImageView *faceIv = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-45*Height, 30*Height, 90*Height, 90*Height)];
    faceIv.image = [self choosePictureNum:[userInfoModel.portrait intValue]];
    [self.view addSubview:faceIv];
    
    
    UILabel *lbl_text = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, height_y(faceIv)+20*Height, MainScreenWidth-40*Width, 0)];
    lbl_text.font = [UIFont systemFontOfSize:12];
    lbl_text.textAlignment = NSTextAlignmentCenter;
    lbl_text.text = didInfoModel.deviceName;
    lbl_text.numberOfLines = 0;//多行显示，计算高度
    lbl_text.textColor = MainColorDarkGrey;
    CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:lbl_text.width content:lbl_text.text];
    lbl_text.height = heightLb;
    [self.view addSubview:lbl_text];
    
    explainBt = [self buildBtn:@"解除关注" action:@selector(explainBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-180*Height, MainScreenWidth-160*Width,40*Height)];
    [self.view addSubview:explainBt];
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
