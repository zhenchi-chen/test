//
//  XWNotification.h
//  BaseProject
//
//  Created by xiaowen.chen on 16/7/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^GWHandleOption)(NSDictionary *handleDic);
typedef NSDictionary *(^GWSingleHandleOption)(NSDictionary *handleDic);

@interface GWNotification : NSObject

/*
 * 添加处理方法,在viewdeload或者viewwillAppear里面添加,添加重复的name无效
 */
+(void)addHandler:(GWHandleOption)block withName:(NSString *)handleName;

/*
 * 移除处理方法,在dealloc或者viewwillDisAppear里面移除
 */
+(void)removeHandler:(NSString *)name;

/*
 * 推送消息
 */
+(void)pushHandle:(NSDictionary *)handleDic withName:(NSString *)handleName;


/*
 * 获取所有的注册信息,调试的时候用
 */
+(NSMutableDictionary *)getHandleDic;

#pragma mark - 有返回值的做法,可以用在一个页面向另外一个页面取值,要求是1对1,不然会出异常

/*
 * 添加一个唯一的处理方法
 */
+(void)addSingleHandler:(GWSingleHandleOption)block withName:(NSString *)handleName;
/*
 * 触发唯一的处理方法,并且从唯一的处理方法中获取结果
 */
+(NSDictionary *)getResultFromSingleHandle:(NSDictionary *)handleDic withName:(NSString *)handleName;


#pragma mark - 批量移除的方法
/*
 * 移除所有
 */
+(void)removeAllHandle;
/*
 * 移除所有不是指定字符串开头的
 */
+(void)removeHandleNotInclude:(NSString *)str;
/*
 * 移除所有指定字符串开头的
 */
+(void)removeHandleInclude:(NSString *)str;

@end
