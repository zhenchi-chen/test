//
//  SetUserTwoViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetUserTwoViewController.h"
#import "AHRuler.h"
#import "AlarmClockTwoViewController.h"

@interface SetUserTwoViewController ()<AHRrettyRulerDelegate>
{
    UILabel *heightLb; //身高
    UILabel *heightUnitLb; //身高单位
    AHRuler *rulerHeight; //身高选择
    UILabel *weightLb; //体重
    UILabel *weightUnitLb; //体重单位
    AHRuler *rulerWeight; //选择体重
    UILabel *bmiLb; //BMI指数
    UILabel *bmiPromptLb; //BMI提示
    
    UIButton *completeBt;
    DeviceModel *deviceModelTemp;
    UserInfoModel *userInfoModel; //个人资料
}

@end

@implementation SetUserTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:@"你的身高和体重是?"];
    
    deviceModelTemp = [[[DeviceListTool alloc]init] queryDeviceListShowModelDevice:[de valueForKey:@"bind_deviceId"]];
    
    userInfoModel = [UserInfoModel objectWithKeyValues:[GWNSStringUtil dictionaryToJsonString:deviceModelTemp.userInfo]];
    
    //加载主要元素的内容
    [self layoutView];
}

- (void)layoutView {
    
    UILabel *promptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width,30*Height, MainScreenWidth-40*Width, 0)];
    promptLb.font = [UIFont systemFontOfSize:12];
    promptLb.textAlignment = NSTextAlignmentCenter;
    promptLb.text = @"不同的身高和体重对心肺功能的评估至关重要\n请准确选择";
    promptLb.numberOfLines = 0;//多行显示，计算高度
    promptLb.textColor = MainColorLightGrey;
    CGFloat heightPromptLb = [UILabel getLabelHeight:12 labelWidth:promptLb.width content:promptLb.text];
    promptLb.height = heightPromptLb;
    [self.view addSubview:promptLb];
    
    CGFloat spacing = 20*Height;
    CGFloat scaleHeight = 70;
    CGFloat scaleWidth = 220;
    
    //身高标题
    UILabel *heightTitleLb = [[UILabel alloc]init];
    heightTitleLb.y = height_y(promptLb)+spacing+10*Height;
    heightTitleLb.text = @"身高";
    heightTitleLb.textColor = MainColorLightGrey;
    heightTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize heightTitleLbSize = [heightTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:heightTitleLb.font,NSFontAttributeName, nil]];
    heightTitleLb.size = heightTitleLbSize;
    heightTitleLb.centerX = self.view.centerX;
    [self.view addSubview:heightTitleLb];

    
    //身高
    heightLb = [[UILabel alloc]init];
    heightLb.centerX = promptLb.centerX;
    heightLb.y = height_y(heightTitleLb)+5*Height;
    heightLb.textColor = MainColorDarkGrey;
    heightLb.font = [UIFont systemFontOfSize:16];
    heightLb.text = @"170";
    // 根据字体得到NSString的尺寸
    CGSize heightLbSize = [heightLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:heightLb.font,NSFontAttributeName, nil]];
    heightLb.size = heightLbSize;
    [heightLb sizeToFit];
    [self.view addSubview:heightLb];
    
    
    //身高单位
    heightUnitLb = [[UILabel alloc]init];
    heightUnitLb.text = @"cm";
    heightUnitLb.textColor = MainColorDarkGrey;
    heightUnitLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize heightUnitLbSize = [heightUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:heightUnitLb.font,NSFontAttributeName, nil]];
    heightUnitLb.size = heightUnitLbSize;
    heightUnitLb.x = width_x(heightLb);
    heightUnitLb.centerY = heightLb.centerY;
    [self.view addSubview:heightUnitLb];
    
    //选择身高
    rulerHeight = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(heightLb)+5*Height, scaleWidth, scaleHeight)];
    rulerHeight.rulerDeletate = self;
    rulerHeight.rulerMin = 60;
    rulerHeight.isRangingHeight = YES;
    rulerHeight.isDisplayTags = YES;
    rulerHeight.isText = YES;

    [rulerHeight showRulerScrollViewWithCount:330 average:[NSNumber numberWithFloat:1] currentValue:180 smallMode:YES];
    [self.view addSubview:rulerHeight];


    //身高
    heightLb.text = @"170";
    [heightLb sizeToFit];
    heightLb.centerX = self.view.centerX;
    heightUnitLb.x = width_x(heightLb);
    
    
    //体重标题
    UILabel *weightTitleLb = [[UILabel alloc]init];
    weightTitleLb.y = height_y(rulerHeight)+spacing;
    weightTitleLb.text = @"体重";
    weightTitleLb.textColor = MainColorDarkGrey;
    weightTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize weightTitleLbSize = [weightTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:weightTitleLb.font,NSFontAttributeName, nil]];
    weightTitleLb.size = weightTitleLbSize;
    weightTitleLb.centerX = self.view.centerX;
    [self.view addSubview:weightTitleLb];
    
    
    //体重
    weightLb = [[UILabel alloc]init];
    weightLb.centerX = weightTitleLb.centerX;
    weightLb.y = height_y(weightTitleLb)+5*Height;
    weightLb.textColor = MainColorDarkGrey;
    weightLb.font = [UIFont systemFontOfSize:18];
    weightLb.text = @"60";
    // 根据字体得到NSString的尺寸
    CGSize weightLbSize = [weightLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:weightLb.font,NSFontAttributeName, nil]];
    weightLb.size = weightLbSize;
    [weightLb sizeToFit];
    [self.view addSubview:weightLb];
    
    //震动时间单位
    weightUnitLb = [[UILabel alloc]init];
    weightUnitLb.text = @"kg";
    weightUnitLb.textColor = MainColorDarkGrey;
    weightUnitLb.font = [UIFont systemFontOfSize:12];
    // 根据字体得到NSString的尺寸
    CGSize weightUnitLbSize = [weightUnitLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:weightUnitLb.font,NSFontAttributeName, nil]];
    weightUnitLb.size = weightUnitLbSize;
    weightUnitLb.x = width_x(weightLb);
    weightUnitLb.centerY = weightLb.centerY;
    [self.view addSubview:weightUnitLb];
    
    //选择体重
    rulerWeight = [[AHRuler alloc] initWithFrame:CGRectMake((MainScreenWidth-scaleWidth)/2, height_y(weightLb)+5*Height, scaleWidth, scaleHeight)];
    rulerWeight.rulerDeletate = self;
    rulerWeight.rulerMin = 20;
    rulerWeight.isRangingHeight = YES;
    rulerWeight.isDisplayTags = YES;
    rulerWeight.isText = YES;
    [rulerWeight showRulerScrollViewWithCount:240 average:[NSNumber numberWithFloat:1] currentValue:70 smallMode:YES];
    [self.view addSubview:rulerWeight];
    
    //震动时间初始值
    weightLb.text = @"60";
    [weightLb sizeToFit];
    weightLb.centerX = self.view.centerX;
    weightUnitLb.x = width_x(weightLb);
    
    //震动时间间隔标题
    UILabel *bmiTitleLb = [[UILabel alloc]init];
    bmiTitleLb.y = height_y(rulerWeight)+spacing;
    bmiTitleLb.text = @"BMI";
    bmiTitleLb.textColor = MainColorDarkGrey;
    bmiTitleLb.font = [UIFont systemFontOfSize:10];
    // 根据字体得到NSString的尺寸
    CGSize bmiTitleLbSize = [bmiTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:bmiTitleLb.font,NSFontAttributeName, nil]];
    bmiTitleLb.size = bmiTitleLbSize;
    bmiTitleLb.centerX = self.view.centerX;
    [self.view addSubview:bmiTitleLb];
    
    //BMI指数
    bmiLb = [[UILabel alloc]init];
    bmiLb.y = height_y(bmiTitleLb)+5*Height;
    bmiLb.textColor = MainColorDarkGrey;
    bmiLb.font = [UIFont systemFontOfSize:16];
    bmiLb.text = [self ToCalculateBMIHeight:heightLb.text andWeight:weightLb.text];
    // 根据字体得到NSString的尺寸
    CGSize bmiLbSize = [bmiLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:bmiLb.font,NSFontAttributeName, nil]];
    bmiLb.size = bmiLbSize;
    [bmiLb sizeToFit];
    bmiLb.centerX = self.view.centerX;
    [self.view addSubview:bmiLb];
    
    bmiPromptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width,height_y(bmiLb), MainScreenWidth-40*Width, 20)];
    bmiPromptLb.font = [UIFont systemFontOfSize:12];
    bmiPromptLb.textAlignment = NSTextAlignmentCenter;
    bmiPromptLb.text = @"你的身体比例非常好";
    bmiPromptLb.textColor = MainColorLightGrey;
    [self.view addSubview:bmiPromptLb];
    
    
    completeBt = [self buildBtn:@"下一步" action:@selector(completeBtAction:) frame:CGRectMake(80*Width, height_y(bmiPromptLb)+30*Height, MainScreenWidth-170*Width,50*Height)];
    [self.view addSubview:completeBt];

}

#pragma mark 确认
- (void)completeBtAction:(UIButton *)button {

    userInfoModel.height = [NSString stringWithFormat:@"%@cm",heightLb.text];
    userInfoModel.weight = [NSString stringWithFormat:@"%@kg",weightLb.text];
    [self ProfileChange];
    
    
    
    AlarmClockTwoViewController *alarmClockTwoVC = [[AlarmClockTwoViewController alloc]init];
    [self.navigationController pushViewController:alarmClockTwoVC animated:YES];
}
#pragma mark AHRule协议方法
- (void)ahRuler:(AHRulerScrollView *)rulerScrollView  andRulerView:(UIView *)ahRuler{
    //    showLabel.text = [NSString stringWithFormat:@"%.fkg",rulerScrollView.rulerValue];
    NSLog(@"选择的是 %f",rulerScrollView.rulerValue-10);
    if (ahRuler == rulerHeight) {
        if ((rulerScrollView.rulerValue-10)<0) {
            heightLb.text = @"60";
        }else if ( (rulerScrollView.rulerValue-10)>190) {
            heightLb.text = @"250";
        }else {
            heightLb.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue-10+60];
        }
        [heightLb sizeToFit];
        heightLb.centerX = self.view.centerX;
        heightUnitLb.x = width_x(heightLb);
        
    }else if (ahRuler == rulerWeight) {
        if ((rulerScrollView.rulerValue-10)<0) {
            weightLb.text = @"20";
        }else if ((rulerScrollView.rulerValue-10)>180) {
            weightLb.text = @"200";
        }else {
            weightLb.text = [NSString stringWithFormat:@"%.f",rulerScrollView.rulerValue-10+20];
        }
        [weightLb sizeToFit];
        weightLb.centerX = self.view.centerX;
        weightUnitLb.x = width_x(weightLb);
        
    }
    bmiLb.text = [self ToCalculateBMIHeight:heightLb.text andWeight:weightLb.text];
    [bmiLb sizeToFit];
    bmiLb.centerX = self.view.centerX;
    
    if ([bmiLb.text floatValue]<18.5) {
        bmiPromptLb.text = @"你的体重过轻";
    }else if ([bmiLb.text floatValue]>=24 && [bmiLb.text floatValue]<27) {
        bmiPromptLb.text = @"你的体重过重";
    }else if ([bmiLb.text floatValue]>=27 && [bmiLb.text floatValue]<30) {
        bmiPromptLb.text = @"你的体型轻度肥胖";
    }else if ([bmiLb.text floatValue]>=30 && [bmiLb.text floatValue]<35) {
        bmiPromptLb.text = @"你的体型中度肥胖";
    }else if ([bmiLb.text floatValue]>=35 ) {
        bmiPromptLb.text = @"你的体型重度肥胖";
    }else {
        bmiPromptLb.text = @"你的身体比例非常好";
    }
}

#pragma mark 计算BMI指数
- (NSString *)ToCalculateBMIHeight:(NSString *)height andWeight:(NSString *)weight {
    
    CGFloat tempHeight = [height floatValue]/100;
    
    CGFloat BMI = [weight floatValue]/(tempHeight*tempHeight);
    
    return [NSString stringWithFormat:@"%.1f",BMI+0.05];
}

#pragma mark 更改个人信息
- (void)ProfileChange {
    
    
    if (userInfoModel.height != nil) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:UserInfo_Set andChangeName:@"height" andChangeDetail:userInfoModel.height];
    }
    if (userInfoModel.weight != nil) {
        [[UpdateDeviceData sharedManager]setUpdateDataDeviceModel:deviceModelTemp andtype:UserInfo_Set andChangeName:@"weight" andChangeDetail:userInfoModel.weight];
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
