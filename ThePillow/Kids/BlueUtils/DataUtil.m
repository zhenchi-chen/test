//
//  DataUtil.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/4/23.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil


#pragma mark 获取单条数据
+(NSData *)getFlashRequestData:(int)address{
    
    
    Byte byte[12] = {};
    
    byte[1] = RAM_GAIN_byte0;
    byte[0] = RAM_GAIN_byte1;

    
    byte[2] = (Byte)(address & 0xff);
    byte[3] = (Byte)((address>>8) & 0xff);
    byte[4] = (Byte)((address>>16) & 0xff);
    byte[5] = (Byte)((address>>24) & 0xff);

    //检查位
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    /*
     理解:蓝牙设备 ->获取数据采用的是大端(低地址存放高位)读取,
     ios采用的是小端存储
     蓝牙设备应该是拿前2位作为一个状态位,这时候如果我们传的是0x1626的话蓝牙设备解析到的是0x2616,所以我们要存0x2616对面才会解析正确
     */
    printf("发出请求帧:");
    for(int i=0;i<12;i++)
        printf("%02X ",byte[i]);
    
    printf("\n");
    return [[NSData alloc] initWithBytes:&byte length:12];
    
}



#pragma mark 获取更多数据
+(NSData *)receiveMoreRamGainMore:(long)begain end:(long)end
{

    Byte byte[12] = {};
    byte[1] =  RAM_GAIN_MORE_byte0;
    byte[0] =  RAM_GAIN_MORE_byte1;
    
    byte[2] = (Byte)(begain & 0xff);
    byte[3] = (Byte)((begain>>8) & 0xff);
    byte[4] = (Byte)((begain>>16) & 0xff);
    byte[5] = (Byte)((begain>>24) & 0xff);
    
    byte[6] = (Byte)(end & 0xff);
    byte[7] = (Byte)((end>>8) & 0xff);
    byte[8] = (Byte)((end>>16) & 0xff);
    byte[9] = (Byte)((end>>24) & 0xff);

    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    printf("获取更多的数据:");
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
     printf("\n");
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 设置时间
+(NSData *)setTime
{
//    NSString *time = [self timeConversion];
    
    Byte byte[12] = {};
    byte[1] =  RTC_SET_byte0;
    byte[0] =  RTC_SET_byte1;
    NSDate *date=[NSDate date];
    NSTimeInterval timeStamp= [date timeIntervalSince1970];
    long time = (long)timeStamp;
    byte[2] = (Byte)(time & 0xff);
    byte[3] = (Byte)((time>>8) & 0xff);
    byte[4] = (Byte)((time>>16) & 0xff);
    byte[5] = (Byte)((time>>24) & 0xff);
    byte[6] = (Byte)((time>>32) & 0xff);
    byte[7] = (Byte)((time>>40) & 0xff);

    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}


#pragma mark 设置时间格式
+(NSData *)setTimeFormatting
{
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置为UTC/GMT时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    int year =[[DateTime substringWithRange:NSMakeRange(2, 2)] intValue];
    int month = [[DateTime substringWithRange:NSMakeRange(5, 2)] intValue];
    int day = [[DateTime substringWithRange:NSMakeRange(8, 2)] intValue];
    int hour = [[DateTime substringWithRange:NSMakeRange(11, 2)] intValue];
    int minute = [[DateTime substringWithRange:NSMakeRange(14, 2)] intValue];
    int second = [[DateTime substringWithRange:NSMakeRange(17, 2)] intValue];
//    NSLog(@"++%d-%d-%d %d:%d:%d",year,month,day,hour,minute,second);
    Byte byte[12] = {};
    byte[1] =  RTC_SET_byte0;
    byte[0] =  RTC_SET_byte1;
  
    byte[2] = (Byte)(year & 0xff);
    byte[3] = (Byte)(month & 0xff);
    byte[4] = (Byte)(day & 0xff);
    byte[5] = (Byte)(hour & 0xff);
    byte[6] = (Byte)(minute & 0xff);
    byte[7] = (Byte)(second & 0xff);
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 获取时间
+(NSData *)gainTime
{
    
    Byte byte[12] = {};
    byte[1] =  RTC_GAIN_byte0;
    byte[0] =  RTC_GAIN_byte1;
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 查看地址加时间间隔
+(NSData *)gainFlashTime:(int)time
{
   
    Byte byte[12] = {};
    byte[1] =  FLASH_GAIN_byte0;
    byte[0] =  FLASH_GAIN_byte1;
    
   
    //时间间隔
    byte[2] = (Byte)(time & 0xff);
    byte[3] = (Byte)((time>>8) & 0xff);
  
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 获取版本号
+(NSData *)getVersion
{
    
    Byte byte[12] = {};
    byte[1] =  RAM_Num_byte0;
    byte[0] =  RAM_Num_byte1;
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}
#pragma mark 设置打鼾模式
+(NSData *)getSnoreNum:(int)num andActivityTime:(int)activity andInterval:(int)interval
{
    
    Byte byte[12] = {};
    byte[1] =  RAM_Snore_byte0;
    byte[0] =  RAM_Snore_byte1;
    
    //震动次数
    byte[2] = (Byte)(num & 0xff);
    byte[3] = (Byte)((num>>8) & 0xff);
    
    //震动持续时间
    byte[4] = (Byte)(activity & 0xff);
    byte[5] = (Byte)((activity>>8) & 0xff);
    
    //震动时间间隔
    byte[6] = (Byte)(interval & 0xff);
    byte[7] = (Byte)((interval>>8) & 0xff);
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 设置闹钟模式
+(NSData *)getClockNum:(int)num andActivityTime:(int)activity andInterval:(int)interval
{
    
    Byte byte[12] = {};
    byte[1] =  RAM_Clock_byte0;
    byte[0] =  RAM_Clock_byte1;
    
    //震动次数
    byte[2] = (Byte)(num & 0xff);
    byte[3] = (Byte)((num>>8) & 0xff);
    
    //震动持续时间
    byte[4] = (Byte)(activity & 0xff);
    byte[5] = (Byte)((activity>>8) & 0xff);
    
    //震动时间间隔
    byte[6] = (Byte)(interval & 0xff);
    byte[7] = (Byte)((interval>>8) & 0xff);
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}


#pragma mark 设置闹钟时间
+(NSData *)getClockTimeCurrent:(int)currentPoint andClockTime:(int)clockPoint andClockNum:(int)clockNum
{
    
    Byte byte[12] = {};
    byte[1] =  RAM_ClockTime_byte0;
    byte[0] =  RAM_ClockTime_byte1;
    
    //震动次数
    byte[2] = (Byte)(currentPoint & 0xff);
    byte[3] = (Byte)((currentPoint>>8) & 0xff);
    
    //震动持续时间
    byte[4] = (Byte)(clockPoint & 0xff);
    byte[5] = (Byte)((clockPoint>>8) & 0xff);
    
    //震动时间间隔
    byte[6] = (Byte)(clockNum & 0xff);
    byte[7] = (Byte)((clockNum>>8) & 0xff);
    
    
    int lenth = byte[0]+byte[1]+byte[2]+byte[3]+byte[4]+byte[5]+byte[6]+byte[7]+byte[8]+byte[9];
    
    byte[11] = (Byte)((lenth>>8) & 0xff);
    byte[10] = (Byte)(lenth & 0xff);
    
    for(int i=0;i<12;i++){
        printf("%02X ",byte[i]);
    }
    
    return [[NSData alloc] initWithBytes:&byte length:12];
}

#pragma mark 校检,验证
- (int)inspectionByte:(Byte[])byte andLength:(int)cd {
    
    int lenth = 0;
    for (int i = 0; i<cd; i++) {
        if (byte[i] < 0) {
            lenth+=256+byte[i];
        }else{
            lenth+=byte[i];
        }
    }
    return lenth;
}


#pragma mark 一次请求多条数据,校检位
+(int)getEndCheck:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
        NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
       
    return   [arr[16] intValue] + [arr[17] intValue] * pow(2, 8);
}

#pragma mark 一次请求多条数据,参数parameterB
+(int)getEndparameterB:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
       NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
    
    
    return   [arr[14] intValue] + [arr[15] intValue] * pow(2, 8);
}

#pragma mark 一次请求多条数据,参数parameterA
+(int)getEndparameterA:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
        NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
    
    
    return   [arr[12] intValue] + [arr[13] intValue] * pow(2, 8);
}

#pragma mark 一次请求多条数据,type类型
+(int)getEndType:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
        NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
    
    
    return   [arr[10] intValue] + [arr[11] intValue] * pow(2, 8);
}

#pragma mark 一次请求多条数据,获取时间计数
+(int)getEndTimeCount:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
        NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
    
    
    return   [arr[6] intValue] + [arr[7] intValue] * pow(2, 8) + [arr[8] intValue] * pow(2, 16) + [arr[9] intValue] * pow(2, 24);
}

#pragma mark 一次请求多条数据,获取地址
+(int)getEndAdd:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 18) {
        NSLog(@"数据长度不正确,%lu",(unsigned long)arr.count);
    }
    
    
    return   [arr[2] intValue] + [arr[3] intValue] * pow(2, 8) + [arr[4] intValue] * pow(2, 16) + [arr[5] intValue] * pow(2, 24);
}

#pragma mark 获取结尾地址
+(long)getEndAddress:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确,正确的是%lu",(unsigned long)arr.count);
    }

//    for (int i = 0; i<arr.count; i++) {
//        NSLog(@"%d ",[arr[i] intValue]);
//        
//    }
    
    
    return   [arr[8] intValue] + [arr[9] intValue] * pow(2, 8) + [arr[10] intValue] * pow(2, 16) + [arr[11] intValue] * pow(2, 24);
}

#pragma mark 获取硬件版本号
+(NSMutableString *)getHardwareVersion:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确,正确的是%lu",(unsigned long)arr.count);
    }
    
    NSMutableString *tempStr = [NSMutableString string];
  
    [tempStr appendFormat:@"%02X",[arr[4] intValue]];
    [tempStr appendFormat:@"%02X",[arr[5] intValue]];
    [tempStr appendFormat:@"%02X",[arr[6] intValue]];
    [tempStr appendFormat:@"%02X",[arr[7] intValue]];
    
    return  tempStr;
}

#pragma mark 获取软件版本号
+(NSMutableString *)getSoftwareVersion:(NSString *)resultStr{
    
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确,正确的是%lu",(unsigned long)arr.count);
    }
    
    NSMutableString *tempStr = [NSMutableString string];
    
    [tempStr appendFormat:@"%02X",[arr[8] intValue]];
    [tempStr appendFormat:@"%02X",[arr[9] intValue]];
    [tempStr appendFormat:@"%02X",[arr[10] intValue]];
    [tempStr appendFormat:@"%02X",[arr[11] intValue]];

    return tempStr;
}

#pragma mark 获取时间第七个比特
+(long)getRTCTimeSeven:(NSString *)resultStr {
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确");
        //        NSLog(@"%lu",(unsigned long)arr.count);
    }
    return   [arr[7] intValue];
}

#pragma mark 获取时间戳
+(long)getRTCTime:(NSString *)resultStr
{
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确");
//        NSLog(@"%lu",(unsigned long)arr.count);
    }
    return   [arr[4] intValue] + [arr[5] intValue] * pow(2, 8) + [arr[6] intValue] * pow(2, 16) + [arr[7] intValue] * pow(2, 24) + [arr[8] intValue] * pow(2, 32) + [arr[9] intValue] * pow(2, 40);

}

#pragma mark 获取时间戳/格式
+(long)getRTCTimeFormatting:(NSString *)resultStr
{
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确");
        //        NSLog(@"%lu",(unsigned long)arr.count);
    }
    
    // 要转换的日期字符串
    NSString *dateString = [NSString stringWithFormat:@"20%d-%d-%d %d:%d:%d",[arr[4] intValue],[arr[5] intValue],[arr[6] intValue],[arr[7] intValue],[arr[8] intValue],[arr[9] intValue]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-M-d H:m:s"];
    [formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *someDay = [formatter dateFromString:dateString];
    NSTimeInterval timeTemp = [someDay timeIntervalSince1970];
    long dTime = [[NSNumber numberWithDouble:timeTemp] longLongValue];

//    NSLog(@"dateString = %@,someDay = %ld",dateString,dTime);
    
    return dTime;
    
}

#pragma mark 获取电量
+(long)getPower:(NSString *)resultStr
{
    NSArray *arr = [resultStr componentsSeparatedByString:@","];
    
    if (arr.count != 16) {
        NSLog(@"数据长度不正确");
        //        NSLog(@"%lu",(unsigned long)arr.count);
    }
    return   [arr[10] intValue];
    
}


#pragma mark 获取数据位数
+(int)getDataCount:(int)address{
    return address/12;
}

//将十进制转化为十六进制
+ (NSString *)ToHex:(long)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%ld",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}



@end
