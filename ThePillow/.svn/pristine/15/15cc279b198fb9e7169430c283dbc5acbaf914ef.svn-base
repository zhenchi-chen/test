//
//  XWDateUtil.h
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWXWDateUtil : NSObject

//获取多少天,多少小时,多少分钟,多少秒之后的时间
+(NSString *)getTimeAfterDay:(int)day hours:(int)hours min:(int)min ss:(int)ss fromDate:(NSDate *)date withForMet:(NSString *)forMet;


//时间转字符串
+(NSString *)strWithDate:(NSDate *)date withForMet:(NSString *)forMet;


//字符串转时间
+(NSDate *)DateInitWithString:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr;


//判断是否超过某个时间段 timeInterval:单位秒
+(Boolean)isTimeOver:(int)timeInterval withTag:(NSString *)tag;

//计算事件差,需要同格式的字符串
+(NSTimeInterval)TimeDifferenceWithTime1:(NSString *)time1 AndTime2:(NSString *)time2 formet:(NSString *)formet;

@end
