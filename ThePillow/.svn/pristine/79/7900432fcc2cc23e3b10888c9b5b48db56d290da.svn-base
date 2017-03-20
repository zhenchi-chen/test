//
//  HttpBaseRequestUtil.h
//  BaseWebRequest
//
//  Created by 陈镇池on 16/2/18.
//  Copyright © 2016年 com.xiaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpBaseRequestUtilDelegate <NSObject>

/*
 *data 返回的数据
 *api  请求的唯一标示
 *reqDic     请求的请求体参数
 *reqHeadDic 请求的请求头参数
 *headDic    请求返回的请求头参数
 */
-(void)httpBaseRequestUtilDelegate:(NSData *)data api:(NSString *)api reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic rspHeadDic:(NSMutableDictionary *)rspHeadDic;

@end

@interface HttpBaseRequestUtil : NSObject

@property(nonatomic,weak)id<HttpBaseRequestUtilDelegate> myDelegate;

-(void)reqDataWithUrl:(NSString *)url reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic;


@end
