//
//  SetUserOneViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetUserOneViewController.h"
#import "AHRuler.h"
#import "SetUserTwoViewController.h"
#import "PersonalInformationModel.h"

@interface SetUserOneViewController ()<AHRrettyRulerDelegate>
{
    UILabel *ageLb; //年龄
    AHRuler *rulerAge; //选择年龄
    BOOL switchStatus; //是否默认NSLocalizedString(@"personal_fragment_man",nil)
    UILabel *sexLb; // 性别
    UIButton *nextBt;
    UserInfoModel *userInfoModel; //个人资料
    DeviceModel *deviceModelTemp;
}

@end

@implementation SetUserOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    
    [self navSet:@"你的年龄和性别是?"];
    
    deviceModelTemp = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:[de valueForKey:@"bind_deviceId"]];
    
    userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModelTemp.userInfo]];
    
    //加载主要元素的内容
    [self layoutView];
    
}

- (void)layoutView {
    
    UILabel *promptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width,30*Height, MainScreenWidth-40*Width, 0)];
    promptLb.font = [UIFont systemFontOfSize:12];
    promptLb.textAlignment = NSTextAlignmentCenter;
    promptLb.text = @"不同年龄或性别的最佳睡眠时长不同\n为了更准确评估您的睡眠质量与心肺功能状况\n请正确选择您的年龄和性别";
    promptLb.numberOfLines = 0;//多行显示，计算高度
    promptLb.textColor = MainColorLightGrey;
    CGFloat heightLb = [UILabel getLabelHeight:12 labelWidth:promptLb.width content:promptLb.text];
    promptLb.height = heightLb;
    [self.view addSubview:promptLb];
    
    CGFloat spacing = 40*Height;
    //年龄标题
    UILabel *ageTitleLb = [[UILabel alloc]init];
    ageTitleLb.y = height_y(promptLb)+spacing;
    ageTitleLb.text = @"年龄";
    ageTitleLb.textColor = MainColorLightGrey;
    ageTitleLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize ageTitleLbSize = [ageTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ageTitleLb.font,NSFontAttributeName, nil]];
    ageTitleLb.size = ageTitleLbSize;
    ageTitleLb.centerX = self.view.centerX;
    [self.view addSubview:ageTitleLb];
    
    
    //年龄
    ageLb = [[UILabel alloc]init];
    ageLb.y = height_y(ageTitleLb);
    ageLb.textColor = MainColorDarkGrey;
    ageLb.font = [UIFont systemFontOfSize:18];
    ageLb.text = @"25";
    // 根据字体得到NSString的尺寸
    CGSize ageLbSize = [ageLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ageLb.font,NSFontAttributeName, nil]];
    ageLb.size = ageLbSize;
    [ageLb sizeToFit];
    ageLb.centerX = ageTitleLb.centerX;
    [self.view addSubview:ageLb];
    
    CGFloat scaleHeight = 70;
    CGFloat scaleWidth = 220;
    
    // 2.创建 AHRuler 对象 并设置代理对象
    rulerAge = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(ageLb)+20*Height, scaleWidth, scaleHeight)];
    rulerAge.rulerMin = 10;
    rulerAge.isRangingHeight = YES;
    rulerAge.isDisplayTags = YES;
    rulerAge.isText = YES;
    rulerAge.rulerDeletate = self;
    [rulerAge showRulerScrollViewWithCount:130 average:[NSNumber numberWithFloat:1] currentValue:[ageLb.text floatValue]+10 smallMode:YES];
    [self.view addSubview:rulerAge];
    
    ageLb.text = @"25";
    [ageLb sizeToFit];
    ageLb.centerX = ageTitleLb.centerX;
    
    //性别标题
    UILabel *sexTitleLb = [[UILabel alloc]init];
    sexTitleLb.y = height_y(rulerAge)+spacing;
    sexTitleLb.text = @"性别";
    sexTitleLb.textColor = MainColorLightGrey;
    sexTitleLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize sexTitleLbSize = [sexTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:sexTitleLb.font,NSFontAttributeName, nil]];
    sexTitleLb.size = sexTitleLbSize;
    sexTitleLb.centerX = self.view.centerX;
    [self.view addSubview:sexTitleLb];

    //性别选择
    UISwitch* mySwitch = [[ UISwitch alloc]init];
    mySwitch.centerX = sexTitleLb.centerX;
    mySwitch.y = height_y(sexTitleLb)+5*Height;
//    mySwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [mySwitch setOn:YES animated:YES];
    mySwitch.onTintColor = MainColor; // 在oneSwitch开启的状态显示的颜色 默认是blueColor
    mySwitch.backgroundColor = RGB(255, 105, 180);
    mySwitch.layer.cornerRadius = mySwitch.frame.size.height/2;
    mySwitch.clipsToBounds = YES;
    [self.view addSubview:mySwitch];
    [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    switchStatus = mySwitch.on;


    //性别
    sexLb = [[UILabel alloc]init];
    sexLb.y = height_y(mySwitch)+10*Height;
    sexLb.text = NSLocalizedString(@"personal_fragment_man",nil);
    sexLb.textColor = MainColorDarkGrey;
    sexLb.font = [UIFont systemFontOfSize:18];
    // 根据字体得到NSString的尺寸
    CGSize sexLbSize = [sexLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:sexLb.font,NSFontAttributeName, nil]];
    sexLb.size = sexLbSize;
    sexLb.centerX = self.view.centerX;
    [self.view addSubview:sexLb];
    
    nextBt = [self buildBtn:@"下一步" action:@selector(nextBtAction:) frame:CGRectMake(80*Width, height_y(sexLb)+30*Height, MainScreenWidth-170*Width,50*Height)];
    [self.view addSubview:nextBt];
    
    

    
}

#pragma mark 下一步
- (void)nextBtAction:(UIButton *)button {
    if ([sexLb.text isEqualToString:NSLocalizedString(@"personal_fragment_man",nil)]) {
        userInfoModel.gender = @"1";
    }else if ([sexLb.text isEqualToString:NSLocalizedString(@"personal_fragment_woman",nil)]) {
        userInfoModel.gender = @"2";
    }
    userInfoModel.age = ageLb.text;
    
    [self ProfileChange];
    
    
    SetUserTwoViewController *setUserTwoVC = [[SetUserTwoViewController alloc]init];
    [self.navigationController pushViewController:setUserTwoVC animated:YES];
    
}

#pragma mark AHRule协议方法
- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler{
    //    showLabel.text = [NSString stringWithFormat:@"%.fkg",rulerScrollView.rulerValue];
    if (ahRuler == rulerAge) {
        if ((rulerScrollView.rulerValue-10)<0) {
            ageLb.text = @"10";
        }else if ( (rulerScrollView.rulerValue-10)>90) {
            ageLb.text = @"100";
        }else {
            ageLb.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue-10+10];
        }
        [ageLb sizeToFit];
        ageLb.centerX = self.view.centerX;
     
    }
}

#pragma mark 监听开关
- (void) switchValueChanged:(UISwitch *)sender{
    
    switchStatus = sender.on;
    if (switchStatus) {
        sexLb.text = NSLocalizedString(@"personal_fragment_man",nil);
        sender.tintColor = MainColor; // 设置边缘颜色255,105,180
    }else {
        sexLb.text = NSLocalizedString(@"personal_fragment_woman",nil);
        sender.tintColor = RGB(255, 105, 180); // 设置边缘颜色255,105,180
    }
}


#pragma mark 更改个人信息
- (void)ProfileChange {
    
    
//    NSLog(@"did = %@,userInfo = %@",deviceModelTemp.did,deviceModelTemp.userInfo);
    if (userInfoModel.gender != nil) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:UserInfo_Set andChangeName:@"gender" andChangeDetail:userInfoModel.gender];
    }
    if (userInfoModel.age !=nil) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:UserInfo_Set andChangeName:@"age" andChangeDetail:userInfoModel.age];
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
