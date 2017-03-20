 //
//  XWNotification.m
//  BaseProject
//
//  Created by xiaowen.chen on 16/7/19.
//  Copyright © 2016年 xw.com. All rights reserved.
//

#import "GWNotification.h"

@implementation GWNotification


static NSMutableDictionary *gw_handlerDic = nil;
static NSObject *gw_lock_obj = nil;

+(void)addHandler:(GWHandleOption)block withName:(NSString *)handleName{
    
    [self checkClass];
    
    @synchronized (gw_lock_obj) {
        Boolean ishave = NO;
        for (NSString *tempStr in [gw_handlerDic allKeys]) {
            if ([tempStr isEqualToString:handleName]) {
                ishave = YES;
                break;
            }
        }
        if (ishave) {
            [gw_handlerDic removeObjectForKey:handleName];
        }
        
        [gw_handlerDic setObject:block forKey:handleName];
    }
}

+(void)removeHandler:(NSString *)name{
    
    [self checkClass];
    
    @synchronized (gw_lock_obj) {
        for (NSString *key in [gw_handlerDic allKeys]) {
            if ([key isEqualToString:name]) {
                [gw_handlerDic removeObjectForKey:key];
            }
        }
    }
}

+(void)pushHandle:(NSDictionary *)handleDic withName:(NSString *)handleName{
    
    [self checkClass];
 
    @synchronized (gw_lock_obj) {
        for (NSString *temp in [gw_handlerDic allKeys]) {
//            NSLog(@"temp = %@,handleName = %@",temp,handleName);
            if ([temp hasPrefix:handleName]) {
                GWHandleOption option = (GWHandleOption)[gw_handlerDic objectForKey:temp];
                if (option) {
                    option(handleDic);
                }
            }
        }
    }
}

+(NSMutableDictionary *)getHandleDic{
    return gw_handlerDic;
}

#pragma mark - 有返回值的做法,可以用在一个页面向另外一个页面取值,要求是1对1,不然会出异常

/*
 * 添加一个唯一的处理方法
 */
+(void)addSingleHandler:(GWSingleHandleOption)block withName:(NSString *)handleName{
    
    [self checkClass];
    
    @synchronized (gw_lock_obj) {
        Boolean ishave = NO;
        for (NSString *tempStr in [gw_handlerDic allKeys]) {
            if ([tempStr isEqualToString:handleName]) {
                ishave = YES;
                break;
            }
        }
        if (ishave) {
            [gw_handlerDic removeObjectForKey:handleName];
        }
        
        [gw_handlerDic setObject:block forKey:handleName];
    }
}
/*
 * 触发唯一的处理方法,并且从唯一的处理方法中获取结果
 */
+(NSDictionary *)getResultFromSingleHandle:(NSDictionary *)handleDic withName:(NSString *)handleName{
    
    [self checkClass];
    
    @synchronized (gw_lock_obj) {
        for (NSString *temp in [gw_handlerDic allKeys]) {
            if ([temp isEqualToString:handleName]) {
                GWSingleHandleOption option = (GWSingleHandleOption)[gw_handlerDic objectForKey:temp];
                if (option) {
                    return option(handleDic);
                }
            }
        }
    }
    return nil;
}

#pragma mark - 批量移除的方法
/*
 * 移除所有
 */
+(void)removeAllHandle{
    [self checkClass];
     @synchronized (gw_lock_obj) {
         
         [gw_handlerDic removeAllObjects];
     }
}
/*
 * 移除所有不是指定字符串开头的
 */
+(void)removeHandleNotInclude:(NSString *)str{
    [self checkClass];
    @synchronized (gw_lock_obj) {
        NSMutableArray *resultArr = [NSMutableArray array];
        for (NSString *temp in [gw_handlerDic allKeys]) {
            if ([temp hasPrefix:str]) {
                [resultArr addObject:temp];
            }
        }
        for(NSString *temp in resultArr){
            [gw_handlerDic removeObjectForKey:temp];
        }
    }
}
/*
 * 移除所有指定字符串开头的
 */
+(void)removeHandleInclude:(NSString *)str{
    [self checkClass];
    @synchronized (gw_lock_obj) {
        
        NSMutableArray *resultArr = [NSMutableArray array];
        for (NSString *temp in [gw_handlerDic allKeys]) {
            if (![temp hasPrefix:str]) {
                [resultArr addObject:temp];
            }
        }
        for(NSString *temp in resultArr){
            [gw_handlerDic removeObjectForKey:temp];
        }
    }
}

+(void)checkClass{
    if (gw_lock_obj == nil) {
        gw_lock_obj = [[NSObject alloc] init];
    }
    if (gw_handlerDic == nil) {
        gw_handlerDic = [NSMutableDictionary dictionary];
    }
}


@end
