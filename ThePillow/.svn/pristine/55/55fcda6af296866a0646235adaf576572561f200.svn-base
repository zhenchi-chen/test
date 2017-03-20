//
//  SqlVersionTool.m
//  FindHim
//
//  Created by 王旭 on 15/12/14.
//  Copyright © 2015年 com.xingfeng. All rights reserved.
//

#import "SqlVersionTool.h"

@implementation SqlVersionTool

//数据库版本部分的控制
+(void)updateVersion{
 
    [self updateVersion1_0_0];
 
    
}




/**v1.0.0版本数据库部分*/
+(void)updateVersion1_0_0{
    
//    NSLog(@"%@",NSHomeDirectory());
    //判断是否为首次启动
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    if (![@"1" isEqualToString:[de valueForKey:@"isFirst"]]) {//非首次启动
        [de setValue:@"1" forKey:@"isFirst"];
        
        //建版本表
        [[MyFMDataManager sharedManager] createVersionTabel];
        
        //写版本信息
        [[MyFMDataManager sharedManager] setDataBaseVersion:@"1.0.0"];
        
        //创建蓝牙数据列表
        [[[BluetoothDataSqlTool alloc] init] createBluetoothDataShowTable];
        
        //创建设备配置信息数据列表
        [[[DeviceListTool alloc] init] createDeviceListShowTable];

        //创建设备主页数据缓存列表
        [[[DeviceDataCacheTool alloc] init] createDeviceDataCacheShowTable];
        
        //创建设备同步日记列表
        [[[BluetoothLogSqlTool alloc]init] createBluetoothLogShowTable];
    }
    
    

}
@end
