//
//  NSStringUtil.m
//  GWTestSDK
//
//  Created by xiaowen.chen on 16/8/30.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "GWNSStringUtil.h"


@implementation GWNSStringUtil


+(NSString *)getStringFromObj:(id)object{
    return [self getStringFromObj:object withTimes:0];
}



+(NSString *)getStringFromObj:(id)object withTimes:(int)times{
    
    if (!object) {
        return @"";
    }
    
    times++;
    NSMutableString *intervalStr = [NSMutableString string];
    for (int i = 1; i < times; i++) {
        [intervalStr appendString:@"\t"];
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSMutableString *string = [NSMutableString string];
        [string appendString:@"{\n"];
        
        // 遍历所有的键值对
        [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            [string appendFormat:@"\t%@%@",intervalStr,key];
            [string appendString:@" : "];
            [string appendFormat:@"%@,\n", [self getStringFromObj:obj withTimes:times]];
        }];
        
        // 结尾有个}
        [string appendFormat:@"%@}",intervalStr];
        
        // 查找最后一个逗号
        NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
        if (range.location != NSNotFound){
            [string deleteCharactersInRange:range];
        }
        return string;
        
    }else if([object isKindOfClass:[NSArray class]]){
        
        NSMutableString *string = [NSMutableString string];
        
        // 开头有个[
        [string appendString:@"[\n"];
        
        // 遍历所有的元素
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //            [string appendFormat:@"\t%@,\n", [self getStringFromObj:obj withTimes:times]];
            [string appendFormat:@"\t%@%@,\n",intervalStr, [self getStringFromObj:obj withTimes:times]];
        }];
        
        // 结尾有个]
        //        [string appendString:@"]"];
        [string appendFormat:@"%@]",intervalStr];
        
        // 查找最后一个逗号
        NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
        if (range.location != NSNotFound){
            [string deleteCharactersInRange:range];
        }
        return string;
        
        
    }else if([object isKindOfClass:[NSString class]]){
        return (NSString *)object;
    }
    return [object description];
}


//去掉所有的空格和回车,\t
+(NSString *)clearStr:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString: @" " withString: @""];
    str = [str stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    str = [str stringByReplacingOccurrencesOfString: @"\t" withString: @""];
    return str;
}

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString{
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString

{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

#pragma  mark -- 判断字符串是否是纯数字
+ (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

#pragma mark 字典转Json字符串
+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

#pragma mark JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark 字典转Json字符串
+ (NSString*)convertToJSONString:(NSDictionary *)dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *dicStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dicStr;
}

#pragma mark JSON字符串转化为字典
+ (NSDictionary *)dictionaryToJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
         return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];//转化为data
    NSError *err;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];//转化为字典
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
//    [NSJSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return data;
}


@end
