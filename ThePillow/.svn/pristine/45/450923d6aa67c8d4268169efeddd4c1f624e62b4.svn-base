//
//  DataUtil.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/4/23.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 设置RTC时间
#define RTC_SET_byte0 0x10 //数据头byte0
#define RTC_SET_byte1 0x0A //数据头byte1

#pragma mark 获取RTC时间
#define RTC_GAIN_byte0 0x10 //数据头byte0
#define RTC_GAIN_byte1 0x1A //数据头byte1

#pragma mark 获取flash信息
#define FLASH_GAIN_byte0 0x20 //数据头byte0
#define FLASH_GAIN_byte1 0x0B //数据头byte1

#pragma mark 获取储存器信息
#define RAM_GAIN_byte0 0x30 //数据头byte0
#define RAM_GAIN_byte1 0x0C //数据头byte1

#pragma mark 获取更多储存器信息
#define RAM_GAIN_MORE_byte0 0x30 //数据头byte0
#define RAM_GAIN_MORE_byte1 0xFC //数据头byte1

#pragma mark 擦除储存器信息
#define RAM_DELETE_byte0 0x40 //数据头byte0
#define RAM_DELETE_byte1 0x0D //数据头byte1

#pragma mark 获取设备软硬件版本号
#define RAM_Num_byte0 0x50 //数据头byte0
#define RAM_Num_byte1 0x96 //数据头byte1

#pragma mark 设置打鼾模式
#define RAM_Snore_byte0 0x50 //数据头byte0
#define RAM_Snore_byte1 0x0D //数据头byte1

#pragma mark 设置闹钟模式
#define RAM_Clock_byte0 0x60 //数据头byte0
#define RAM_Clock_byte1 0x0D //数据头byte1

#pragma mark 设置闹钟时间
#define RAM_ClockTime_byte0 0x60 //数据头byte0
#define RAM_ClockTime_byte1 0x0C //数据头byte1

@interface DataUtil : NSObject

//获取蓝牙请求帧flash 单帧
#pragma mark 获取单条数据
+(NSData *)getFlashRequestData:(int)address;

#pragma mark 获取更多数据
+(NSData *)receiveMoreRamGainMore:(long)begain end:(long)end;

#pragma mark 设置时间
+(NSData *)setTime;

#pragma mark 设置时间格式
+(NSData *)setTimeFormatting;

#pragma mark 获取时间
+(NSData *)gainTime;

#pragma mark 查看地址加时间间隔
+(NSData *)gainFlashTime:(int)time;

#pragma mark 获取电量
+(long)getPower:(NSString *)resultStr;

#pragma mark 获取版本号
+(NSData *)getVersion;

#pragma mark 设置打鼾模式
+(NSData *)getSnoreNum:(int)num andActivityTime:(int)activity andInterval:(int)interval;

#pragma mark 设置闹钟模式
+(NSData *)getClockNum:(int)num andActivityTime:(int)activity andInterval:(int)interval;

#pragma mark 设置闹钟时间
+(NSData *)getClockTimeCurrent:(int)currentPoint andClockTime:(int)clockPoint andClockNum:(int)clockNum;

#pragma mark 获取硬件版本号
+(NSMutableString *)getHardwareVersion:(NSString *)resultStr;

#pragma mark 获取软件版本号
+(NSMutableString *)getSoftwareVersion:(NSString *)resultStr;

#pragma mark 一次请求多条数据,校检位
+(int)getEndCheck:(NSString *)resultStr;

#pragma mark 一次请求多条数据,参数parameterB
+(int)getEndparameterB:(NSString *)resultStr;

#pragma mark 一次请求多条数据,参数parameterA
+(int)getEndparameterA:(NSString *)resultStr;

#pragma mark 一次请求多条数据,type类型
+(int)getEndType:(NSString *)resultStr;

#pragma mark 一次请求多条数据,获取地址
+(int)getEndAdd:(NSString *)resultStr;

#pragma mark 一次请求多条数据,获取时间计数
+(int)getEndTimeCount:(NSString *)resultStr;

#pragma mark 获取时间第七个比特
+(long)getRTCTimeSeven:(NSString *)resultStr;

#pragma mark 获取时间戳/格式
+(long)getRTCTimeFormatting:(NSString *)resultStr;

#pragma mark 获取结尾地址
+(long)getEndAddress:(NSString *)resultStr;

#pragma mark 获取时间戳
+(long)getRTCTime:(NSString *)resultStr;

#pragma mark 获取数据位数
+(int)getDataCount:(int)address;

#pragma mark 将十进制转化为十六进制
+ (NSString *)ToHex:(long)tmpid;




@end
