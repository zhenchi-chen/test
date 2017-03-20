//
//  LFCGzipUtility.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/5.
//  Copyright © 2016年 lehu. All rights reserved.
//

/*
 
 压缩和解压缩函数
 
 数据压缩参考：
 
 http://www.clintharris.net/2009/how-to-gzip-data-in-memory-using-objective-c/
 
 数据解压缩参考：
 
 ASIHttpRequest库的文件：ASIDataDecompressor.m
 
 添加 libbz2.1.0.dylib
 
 */



#import <Foundation/Foundation.h>
#import "zlib.h"

@interface LFCGzipUtility : NSObject

{
    
}

+(NSData*) gzipData:(NSData*)pUncompressedData;  //压缩
+(NSData*) ungzipData:(NSData *)compressedData;  //解压缩

@end
