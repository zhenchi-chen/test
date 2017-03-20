//
//  UploadFile1.m
//  PostTransfer
//
//  Created by 陈镇池 on 16/5/7.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "UploadFile1.h"

@implementation UploadFile1

// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        randomIDStr = @"itcast";
        randomIDStr = @"V2ymHFg03ehbqgZCaKO6jy";
        uploadID = @"ok";
    }
    return self;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", uploadID,uploadFile];
    [strM appendFormat:@"Content-Type: %@\r\n\r\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString:(NSString *)key value:(NSString *)value
{
    NSMutableString *strM = [NSMutableString string];
    
    
//    --X_PAW_BOUNDARY
//    Content-Disposition: form-data; name="accessid"
//    1923h8f
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
    [strM appendFormat:@"%@",value];
    
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url imageDic:(NSDictionary *)imgDic pramDic:(NSDictionary *)pramDic
{
    // 1> 数据体
    
    
    
    NSMutableData *dataM = [NSMutableData data];
    
    //    [dataM appendData:[boundaryStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSString *name  in [pramDic allKeys]) {
        NSString *bottomStr = [self bottomString:name value:[pramDic valueForKey:name]];
        [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    for (NSString *name  in [imgDic allKeys]) {
//        NSString *topStr = [self topStringWithMimeType:@"application/x-gzip" uploadFile:name];
        NSString *topStr = [self topStringWithMimeType:@"application/json" uploadFile:name];
//        NSString *topStr = [self topStringWithMimeType:@"application/" uploadFile:name];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:[imgDic valueForKey:name]];
    }
    
   
    [dataM appendData:[[NSString stringWithFormat:@"\r\n%@%@--\r\n", boundaryStr, randomIDStr] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
//    NSLog(@"Body体是 = %@",[[NSString alloc] initWithData:dataM  encoding:NSUTF8StringEncoding]);
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
//    NSString *strLength = @"400";
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
//    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    NSString *strConnection = [NSString stringWithFormat:@"close"];
    [request setValue:strConnection forHTTPHeaderField:@"Connection"];
    
   //    NSLog(@"body%@",[NSString stringWithFormat:@"%@%@%@",strContentType,strConnection,strUser_Agent]);
    
//Connection: close
//    User-Agent: Paw/2.2.5 (Macintosh; OS X/10.11.0) GCDHTTPRequest
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"请求出错,原因是 = %@",connectionError);
        }
        if (data != nil) {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"请求结果是 = %@", result);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic != nil) {
               [GWNotification pushHandle:dic withName:@"上传服务器"];
                
            }
        }else {
            [GWNotification pushHandle:nil withName:@"上传失败"];
            [SVProgressHUD showErrorWithStatus:@"请求错误,请检查网络!"];
        }
       
       
   

        

//        NSLog(@"数据流%@",data);
    }];
}

@end
