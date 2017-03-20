//
//  LoginAuthentication.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/18.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginAuthentication : NSObject

#pragma mark 验证邮箱
+ (BOOL)validateEmail:(NSString *)email;

#pragma mark 验证手机号 简单验证
+ (BOOL)validatePhone:(NSString *)phone;

#pragma mark 验证手机号 详细验证 ,正则判断手机号码格式
+ (BOOL)validateDetailedPhone:(NSString *)phone;

#pragma mark 验证是否只是英文加数字
+ (BOOL)validateFormat:(NSString *)format;

#pragma mark 自定义验证手机号 详细验证 ,正则判断手机号码格式
+ (BOOL)customValidateDetailedPhone:(NSString *)phone;

@end
