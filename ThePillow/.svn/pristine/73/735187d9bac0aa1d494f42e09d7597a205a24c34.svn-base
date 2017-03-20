//
//  GWStatisticalUtil.h
//  GZG_base
//
//  Created by G-emall on 16/5/26.
//  Copyright © 2016年 wxp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWStatisticalUtil : NSObject

/**
 *  开启统计的方法
 */
+(void)openTheStatistics;

/**
 *  在线更新参数
 */
+(void)updateParameterOnline;


/**
 *  事件统计
 *  event:   事件名
 *  tag:     事件描述
 */
+(void)eventStatistics:(NSString *)event;


/**
 *  页面时长统计
 *  viewController：  当前的页面
 */
+(void)onPageViewBegin:(UIViewController *)viewController withName:(NSString *)name;
+(void)onPageViewEnd:(UIViewController *)viewController withName:(NSString *)name;


/** 
 *  设置app版本号。
 */
+(void)setAppVersionNumber:(NSString *)appVersion;

/** 
 *  开启CrashReport收集
 */
+(void)setCrashReportCollection:(BOOL)value;


#pragma mark 自定义统计部分

/**
 *  自定义统计方法
 *  customDictionary:     自定义统计所需的字典
 *  type            :     自定义类标记
 *
 */
+(void)customEventStatistics:(NSDictionary *)customDictionary withType:(NSString *)type;



@end
