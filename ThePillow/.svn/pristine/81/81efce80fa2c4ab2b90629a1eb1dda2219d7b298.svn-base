//
//  XWDateUtil.m
//  FrameObject
//
//  Created by shenba on 16/4/12.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "GWXWDateUtil.h"

@implementation GWXWDateUtil

//获取多少天,多少小时,多少分钟,多少秒之后的时间
+(NSString *)getTimeAfterDay:(int)day hours:(int)hours min:(int)min ss:(int)ss fromDate:(NSDate *)date withForMet:(NSString *)forMet{
    
    if (date==nil) {
        date = [NSDate date];
    }
    
    NSDate *resultDate = [[NSDate alloc]initWithTimeInterval:(24 * 60 * 60)*day+(60*60)*hours+min*60+ss sinceDate:date];
    
    return [self strWithDate:resultDate withForMet:forMet];
    
}


//时间转字符串
+(NSString *)strWithDate:(NSDate *)date withForMet:(NSString *)forMet{
    
    if (date == nil) {
        date = [NSDate date];
    }
    if (forMet==nil) {
        forMet = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:forMet];
    
    return  [df stringFromDate:date];
}

//字符串转时间
+(NSDate *)DateInitWithString:(NSString *)dateStr dateFormatterStr:(NSString *)dateFormatterStr
{
    if (!dateStr) {
        return [NSDate date];
    }
    if (dateFormatterStr == nil) {
        dateFormatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDate *reslutDate = nil;
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:dateFormatterStr];
        //得到时间
        reslutDate = [formatter dateFromString:dateStr];
    }
    return reslutDate;
}


//判断是否超过某个时间段 timeInterval:单位秒
+(Boolean)isTimeOver:(int)timeInterval withTag:(NSString *)tag{
    
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *tempStrTag = [NSString stringWithFormat:@"gw_timesover_%@",tag];
    NSString *str = [defaults valueForKey:tempStrTag];
    NSDate *nowDate = [NSDate date];
//    NSLog(@"比较之前存放的时间:%@",tempStrTag);
    if (timeInterval == 0) {
        [defaults setValue:[self strWithDate:nowDate withForMet:nil] forKey:tempStrTag];
        return YES;//时间设置为0,表示刷新标志时间,返回成功
    }
    if (!str) {
        [defaults setValue:[self strWithDate:nowDate withForMet:nil] forKey:tempStrTag];
        return YES;//第一次调用
    }
    
    
    NSTimeInterval time = [nowDate timeIntervalSinceDate:[self DateInitWithString:str dateFormatterStr:nil]];
//    NSLog(@"比较相差的时间:%f",time);
    if (time > timeInterval) {
        [defaults setValue:[self strWithDate:nowDate withForMet:nil] forKey:tempStrTag];
        return YES;
    }
    return NO;
}








//计算事件差,需要同格式的字符串
+(NSTimeInterval)TimeDifferenceWithTime1:(NSString *)time1 AndTime2:(NSString *)time2 formet:(NSString *)formet{
    
    return [[self DateInitWithString:time1 dateFormatterStr:formet] timeIntervalSinceDate:[self DateInitWithString:time2 dateFormatterStr:formet]];
}


@end
