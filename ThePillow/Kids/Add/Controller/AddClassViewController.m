//
//  AddClassViewController.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/3/17.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "AddClassViewController.h"
#import "PlusDeviceViewController.h"
#import "AddBluetoothViewController.h"

@interface AddClassViewController ()

@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainColorWhite;
    [self navSet:NSLocalizedString(@"add_device_fragment_content",nil)];
                                   
    [self layoutView];
}

- (void)layoutView {

    UILabel *titleLb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40*Height, MainScreenWidth, 20*Height)];
    titleLb2.text = NSLocalizedString(@"add_device_fragment_content_2",nil);
    titleLb2.textAlignment = NSTextAlignmentCenter;
    titleLb2.textColor = MainColor;
    [self.view addSubview:titleLb2];
    
    CGFloat btSize = self.view.width/5;
    
    UIButton *gprsBt = [UIButton buttonWithType:UIButtonTypeCustom];
    gprsBt.frame = CGRectMake(btSize, height_y(titleLb2)+40*Height, btSize, btSize);
    [gprsBt setImage:[UIImage imageNamed:@"移动"] forState:UIControlStateNormal];
    [gprsBt addTarget:self action:@selector(gprsBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gprsBt];
    
    UIButton *lyBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lyBt.frame = CGRectMake(btSize*3, gprsBt.y, btSize, btSize);
    [lyBt setImage:[UIImage imageNamed:@"蓝牙"] forState:UIControlStateNormal];
    [lyBt addTarget:self action:@selector(lyBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lyBt];
    
}

- (void)lyBtAction {
    AddBluetoothViewController *addBVC =[[AddBluetoothViewController alloc]init];
    [self.navigationController pushViewController:addBVC animated:YES];
}


- (void)gprsBtAction {
    
    PlusDeviceViewController *plusDVC = [[PlusDeviceViewController alloc]init];
    [self.navigationController pushViewController:plusDVC animated:YES];
    
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
