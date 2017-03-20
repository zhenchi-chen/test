//
//  HttpBaseRequestUtil.m
//  BaseWebRequest
//
//  Created by 陈镇池 on 16/2/18.
//  Copyright © 2016年 com.xiaowen. All rights reserved.
//

#import "HttpBaseRequestUtil.h"



@interface HttpBaseRequestUtil()<NSURLConnectionDataDelegate>

@property(nonatomic,strong)NSString *api;
@property(nonatomic,strong)NSMutableData *myData;
@property(nonatomic,strong)NSMutableDictionary *reqDic;
@property(nonatomic,strong)NSMutableDictionary *reqHeadDic;

@property(nonatomic,strong)NSMutableDictionary *rspHeadDic;
@property(nonatomic,assign)int rspHttpState;

@end


@implementation HttpBaseRequestUtil



-(void)reqDataWithUrl:(NSString *)url reqDic:(NSMutableDictionary *)reqDic reqHeadDic:(NSMutableDictionary *)reqHeadDic{
    
    _reqDic = reqDic;
    _reqHeadDic = reqHeadDic;
    if (reqDic!=nil) {
        _api = reqDic[@"api"];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",REQUEST_HEAD,url];
    NSLog(@"[api:%@请求地址%@]",_api,str);
    NSURL *tempurl = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tempurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    //异步请求
    
    //设置请求头
    if (_reqHeadDic!=nil) {
        for (NSString *strHead in [_reqHeadDic allKeys]) {
            [request setValue:[_reqHeadDic valueForKey:strHead] forHTTPHeaderField:strHead];//用户的id号
            
            NSLog(@"设置请求的头部:=======>%@:%@",strHead,[_reqHeadDic valueForKey:strHead]);
        }
    }

    [request setHTTPMethod:@"POST"];

    NSString *bodyStr = [self getReqBodyFromDic:_reqDic];
    
//    bodyStr = [NSString stringWithFormat:@"%@%@",bodyStr,@"fhdifdif"];
//    
//    bodyStr = [self jiami:bodyStr];
    
//    NSLog(@"请求发出的body = %@",bodyStr);
    
//    bodyStr = [NSString stringWithFormat:@"data=%@",bodyStr];
    //将字符串转化成nsdata
    NSData *data = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //设置body体
    request.HTTPBody = data;

    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma -mark <NSURLConnectionDataDelegate>的代理方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        _rspHeadDic = [[httpResponse allHeaderFields] copy];
        _rspHttpState = (int)[httpResponse statusCode];
        
        if (isDebug_Service_head) {
            NSLog(@"[api:%@,请求的结果头文件:]%@",_api,_rspHeadDic);
        }
        //头文件带一些关键信息,根据头文件的信息作一些别的操作处理 TODO
        
    }
    //收到服务器的响应(初始化可变的data)
    self.myData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //收到服务器返回的数据
    NSLog(@"[接收到数据]");
    [self.myData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //下载结束
    NSLog(@"[数据接收完成]");
    [self dealData];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //下载错误,失败
    self.myData = nil;
    NSLog(@"[请求错误/请求失败]");
    [self dealData];
  
}


-(void)dealData{
    NSLog(@"[api:%@,请求的结果:-->%d<--]",_api,_rspHttpState);
    if (_rspHttpState == 200) {
        //需要加入缓存的数据
    }else if (_rspHttpState == 400) {

    }else if (_rspHttpState == 401) {
    
    }else if (_rspHttpState == 403) {

    }else if (_rspHttpState == 429) {
        
    }else{
        
    }
    
    
    
    

    if (_myDelegate!=nil) {
        [_myDelegate httpBaseRequestUtilDelegate:_myData api:_api reqDic:_reqDic reqHeadDic:_reqHeadDic rspHeadDic:_rspHeadDic];
        if (_myData != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_myData options:NSJSONReadingMutableContainers error:nil];
            BaseDataModel *baseModel = [BaseDataModel objectWithKeyValues:dic];
        
            if (baseModel.code != 200) {
                NSDictionary *tempDic = @{@"code":[NSString stringWithFormat:@"%ld",(long)baseModel.code],@"msg":baseModel.msg};
                [GWNotification pushHandle:tempDic withName:@"后台返回状态"];
            }
        }
    }
    
    
    if ([_api isEqualToString:@"测试标志1"]) {
        //FA TONGZHI
        
    }
    
    //还可以做其他的操作
    
    
    
}


-(NSString *)getReqBodyFromDic:(NSDictionary *)dic{
        NSMutableString *resultStr = [NSMutableString string];
        for (int i=0; i<[[dic allKeys] count]; i++) {
    
            if ([[dic allKeys][i] isEqualToString:@"api"]) {
                continue;
            }
    
            if (i!=0) {
                if (i==1&&[[dic allKeys][0] isEqualToString:@"api"]) {
                }else{
                    [resultStr appendString:@"&"];
                }
            }

                [resultStr appendString:[dic allKeys][i]];
                [resultStr appendString:@"="];
                [resultStr appendString:[dic valueForKey:[dic allKeys][i]]];

        }
        
        NSLog(@"参数组装结果:%@",resultStr);
        return resultStr;
}

//获取body体
//-(NSString *)getBodyFromDic:(NSDictionary *)dic{
//    NSMutableString *resultStr = [NSMutableString string];
//    [resultStr appendString:@"{"];
//    for (int i=0; i<[[dic allKeys] count]; i++) {
//        
//        if ([[dic allKeys][i] isEqualToString:@"api"]) {
//            continue;
//        }
//        
//        if (i!=0) {
//            if (i==1&&[[dic allKeys][0] isEqualToString:@"api"]) {
//            }else{
//                [resultStr appendString:@","];
//            }
//        }
//        if ([[dic valueForKey:[dic allKeys][i]] isKindOfClass:[NSMutableDictionary class]]) {
//            //
//            NSLog(@"数组组装");
//            [resultStr appendString:@"\""];
//            [resultStr appendString:[dic allKeys][i]];
//            [resultStr appendString:@"\":["];
//            
//            NSMutableDictionary *tempDic = (NSMutableDictionary *)[dic valueForKey:[dic allKeys][i]];
//            for (int j=0;j<[[tempDic allKeys] count];j++) {
//                if (j!=0) {
//                    [resultStr appendString:@","];
//                }
//                [resultStr appendString:@"{\""];
//                [resultStr appendString:[tempDic allKeys][j]];
//                [resultStr appendString:@"\":\""];
//                [resultStr appendString:[tempDic valueForKey:[tempDic allKeys][j]]];
//                [resultStr appendString:@"\"}"];
//            }
//            [resultStr appendString:@"]"];
//        }else{
//            [resultStr appendString:@"\""];
//            [resultStr appendString:[dic allKeys][i]];
//            [resultStr appendString:@"\":\""];
//            [resultStr appendString:[dic valueForKey:[dic allKeys][i]]];
//            [resultStr appendString:@"\""];
//        }
//    }
//    [resultStr appendString:@"}"];
//    
//    NSLog(@"参数组装结果:%@",resultStr);
//    return resultStr;
//}



@end
