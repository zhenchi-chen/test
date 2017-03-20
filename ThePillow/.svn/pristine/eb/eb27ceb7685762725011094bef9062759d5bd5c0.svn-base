//
//  BaseViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/24.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    de = [NSUserDefaults standardUserDefaults];
    

    
    //导航左边按钮
    UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    [leftBt setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(navigationLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBt];
    
}

#pragma mark deviceModel初始化赋值
//- (DeviceModel *)deviceModel {
//    
//    if (!_deviceModel) {
//        _deviceModel = [[DeviceModel alloc]init];
//    }
//    
////    _deviceModel = [[UpdateDeviceData sharedManager] getReadData];
//    return _deviceModel;
//}


#pragma mark 导航栏设置
- (void) navSet:(NSString *)title{
    
    self.navigationItem.title = title;
    //设置导航栏的背景色,如果设置颜色,模糊效果会消失
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
 
    
}

#pragma mark 导航栏颜色黑色
- (void)setNacColorBlack {
    //设置statusBar,电量,信号 颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:MainColorBlack.image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
}

#pragma mark 导航栏颜色白色
- (void)setNacColorWhite {
    //设置statusBar,电量,信号 颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:MainColorWhite.image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColorDarkGrey, NSForegroundColorAttributeName, nil]];
    
}

#pragma mark 导航栏颜色主颜色
- (void)setNacColorMainColor {
    //设置statusBar,电量,信号 颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:MainColor.image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColorWhite, NSForegroundColorAttributeName, nil]];
    
}

#pragma mark 返回上一个页面
- (void)navigationLeftButton:(UIButton *)button {
    
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}


-(UIButton *)buildBtn:(NSString *)name action:(SEL)action frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.layer.cornerRadius = frame.size.height/2;
    btn.clipsToBounds = YES;
    btn.backgroundColor = MainColor;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    //    btn.layer.borderWidth = 1;
    //    btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    return btn;
}


#pragma mark 头像显示
- (UIImage *)choosePictureNum:(NSInteger)num{
    UIImageView *view = [[UIImageView alloc]init];
    switch (num) {
        case 0:
            view.image = [UIImage imageNamed:@"moren"];
            break;
        case 1:
            view.image = [UIImage imageNamed:@"headPortrait1"];
            break;
        case 2:
            view.image = [UIImage imageNamed:@"headPortrait2"];
            break;
        case 3:
            view.image = [UIImage imageNamed:@"headPortrait3"];
            break;
        case 4:
            view.image = [UIImage imageNamed:@"headPortrait4"];
            break;
        case 5:
            view.image = [UIImage imageNamed:@"headPortrait5"];
            break;
        case 6:
            view.image = [UIImage imageNamed:@"headPortrait6"];
            break;
        default:
            break;
    }
    return view.image;
}

//跳到登陆页
- (void)joinDo{
    
    LoginController *loginVC = [[LoginController alloc]init];
    kAppDelegate.window.rootViewController = loginVC;
    [self.navigationController popViewControllerAnimated:YES];
}



//键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
