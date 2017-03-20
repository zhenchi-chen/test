//
//  NSString+MyNSString.m

//
//  Created by lanou on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NSString+MyNSString.h"

@implementation NSString (MyNSString)

-(id)initWithDate:(NSDate *)date format:(NSString *)format
{
    self = [self init];
    if (self) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:format];
        self = [formatter stringFromDate:date];
        
        
        
    }
    return self;
}



-(id)initWithformat:(NSString *)format Date:(NSDate *)date
{
    self = [self init];
    if (self) {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
    
}


//时间戳转时间
-(id)initWithTimesp:(NSTimeInterval)timesp format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timesp];
    if (date == nil) {
        date = [NSDate date];
    }
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    self = [self init];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:format];
        self = [formatter stringFromDate:date];
    }
    return self;
}


//时间戳转时间,JAVA后台调用方法
-(id)initWithTimespStr:(NSString *)timespStr format:(NSString *)format{
    
    double date1 = [timespStr doubleValue];//坑
    return [self initWithTimesp:date1/1000.0 format:format];
    
}

@end
