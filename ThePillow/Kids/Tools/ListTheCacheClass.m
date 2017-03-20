//
//  ListTheCacheClass.m
//  Kids
//
//  Created by 陈镇池 on 2016/11/16.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "ListTheCacheClass.h"

@interface ListTheCacheClass ()



@end

@implementation ListTheCacheClass


+ (ListTheCacheClass *)sharedManager
{
    static ListTheCacheClass *sharedListTheCacheManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedListTheCacheManagerInstance = [[self alloc] init];
    });
    
    return sharedListTheCacheManagerInstance;
}


//保存数据
- (void)saveData:(NSMutableDictionary *)dic {
    
    NSString *username = [dic objectForKey:@"username"];
    NSString *token = [dic objectForKey:@"token"];
    NSString *isDevice = [dic objectForKey:@"isDevice"];
    NSString *userpassword = [dic objectForKey:@"userpassword"];
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    //2保存数据(如果设置数据之后没有同步, 会在将来某一时间点自动将数据保存到Preferences文件夹下面)
    if (username != nil) {
        [defaults setObject:username forKey:@"username"];
    }
    if (token != nil) {
        [defaults setObject:token forKey:@"token"];
    }
    if (isDevice != nil) {
        if ([isDevice intValue]<0) {
            isDevice = @"0";
        }
        [defaults setObject:isDevice forKey:@"isDevice"];
    }
    
    if (userpassword != nil) {
        [defaults setObject:userpassword forKey:@"userpassword"];
    }
    
    //3.强制让数据立刻保存
    [defaults synchronize];
    
}

//读取数据
- (NSDictionary *)readData{
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //读取保存的数据
    NSString *username=[defaults objectForKey:@"username"];
    NSString *token=[defaults objectForKey:@"token"];
    NSString *isDevice=[defaults objectForKey:@"isDevice"];
    
    //打印数据
//    NSLog(@"username=%@,token=%@,isDevice=%@",username,token,isDevice);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"name",token,@"token",isDevice,@"isDevice", nil];
    return dic;
}





@end
