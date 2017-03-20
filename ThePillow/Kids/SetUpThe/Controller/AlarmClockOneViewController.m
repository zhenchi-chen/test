//
//  AlarmClockOneViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "AlarmClockOneViewController.h"
#import "SetUserOneViewController.h"

@interface AlarmClockOneViewController ()

@end

@implementation AlarmClockOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏的背景色
    [self setNacColorWhite];
    [self navSet:@"欢迎使用智能闹钟"];
    
    //导航左边按钮
    UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.frame = CGRectMake(0, 30, NavSize, NavSize);
    [leftBt setImage:[UIImage imageNamed:@"无效"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(navigationLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBt];

    
    //创建主页面
    [self createView];
}

#pragma mark 返回上一个页面
- (void)navigationLeftButton:(UIButton *)button {
    
}
#pragma mark 创建主页面
- (void)createView {
    
    UILabel *promptLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width,30*Height, MainScreenWidth-40*Width, 0)];
    promptLb.font = [UIFont systemFontOfSize:16];
    promptLb.textAlignment = NSTextAlignmentCenter;
    promptLb.text = @"我们会根据您的资料智能计算叫醒时间，智能闹钟可以帮助您改善睡眠起居习惯，叫醒自己的同时又不会影响他人";
    promptLb.numberOfLines = 0;//多行显示，计算高度
    promptLb.textColor = MainColorLightGrey;
    CGFloat heightLb = [UILabel getLabelHeight:16 labelWidth:promptLb.width content:promptLb.text];
    promptLb.height = heightLb;
    [self.view addSubview:promptLb];
    
    UIButton *nextBt = [self buildBtn:@"开始" action:@selector(nextBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-190*Height, MainScreenWidth-160*Width,50*Height)];
    [self.view addSubview:nextBt];

}

#pragma mark 下一步
- (void)nextBtAction:(UIButton *)button {
    
   
    [self.navigationController pushViewController:[[SetUserOneViewController alloc]init] animated:YES];

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
