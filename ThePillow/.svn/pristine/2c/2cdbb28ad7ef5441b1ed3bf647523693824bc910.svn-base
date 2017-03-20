//
//  BaseViewController.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/24.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    NSUserDefaults *de;
    DeviceModel *deviceModel;
}


//导航栏设置
- (void) navSet:(NSString *)title;

#pragma mark 导航栏左边返回上一个页面
- (void)navigationLeftButton:(UIButton *)button;


#pragma mark 返回一个按钮
-(UIButton *)buildBtn:(NSString *)name action:(SEL)action frame:(CGRect)frame;

#pragma mark 导航栏颜色黑色
- (void)setNacColorBlack;

#pragma mark 导航栏颜色白色
- (void)setNacColorWhite;

#pragma mark 导航栏颜色主颜色
- (void)setNacColorMainColor;

#pragma mark 头像显示
- (UIImage *)choosePictureNum:(NSInteger)num;


//访问
//- (void)accessCode:(NSInteger)code andMsg:(NSString *)msg;
////登录
//- (void)loginCode:(NSInteger)code;
////注销
//- (void)logoutCode:(NSInteger)code;
////注册
//- (void)registerCode:(NSInteger)code;
////更改密码
//- (void)changePasswordCode:(NSInteger)code;
////获取个人信息
//- (void)personalInfoGetCode:(NSInteger)code;
////绑定设备
//- (void)bindCode:(NSInteger)code;
////解绑设备
//- (void)unbindCode:(NSInteger)code;
////更改头像
//- (void)changePortraitCode:(NSInteger)code;
////获取设备列表
//- (void)getDevicesListCode:(NSInteger)code;
////更新设备名字
//- (void)updateDevcieName:(NSInteger)code;
////分享
//- (void)shareCode:(NSInteger)code;



@end
