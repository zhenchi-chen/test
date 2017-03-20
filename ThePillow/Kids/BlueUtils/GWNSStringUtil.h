//
//  NSStringUtil.h
//  GWTestSDK
//
//  Created by xiaowen.chen on 16/8/30.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWNSStringUtil : NSObject

//格式换字典,数组,转字符串(格式化)
+(NSString *)getStringFromObj:(id)object;

//去掉所有的空格和回车,\t
+(NSString *)clearStr:(NSString *)str;

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString;

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString;

#pragma  mark -- 判断字符串是否是纯数字
+ (BOOL)isPureInt:(NSString *)string;

#pragma mark 字典转Json字符串
+ (NSString*)convertToJSONData:(id)infoDict;

#pragma mark JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark 字典转Json字符串
+ (NSString*)convertToJSONString:(NSDictionary *)dic;

#pragma mark JSON字符串转化为字典
+ (NSDictionary *)dictionaryToJsonString:(NSString *)jsonString;

@end
