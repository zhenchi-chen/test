//
//  DeviceDataCacheTool.h
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/10.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceDataCacheModel.h"

@interface DeviceDataCacheTool : NSObject

//创建设备列表数据表
-(void)createDeviceDataCacheShowTable;

//修改单条数据属性
-(void)updateDataDeviceId:(NSString *)device andChangeTime:(NSString *)time andName:(NSString *)name andData:(NSString *)data;

//单条插入
-(void)insertDeviceDataCache:(DeviceDataCacheModel *)model;

//查找单条数据
-(DeviceDataCacheModel *)queryDeviceDataCacheShowModelDevice:(NSString *)device andTime:(NSString *)time;

//查找单条数据是否可改
-(NSInteger)queryDeviceDataCacheShowIsVariableDevice:(NSString *)device andTime:(NSString *)time;

//删除单个设备每个时间段之前数据
-(void)deleteData:(NSString *)device andTime:(NSString *)time;

//删除单个设备
-(void)deleteData:(NSString *)device;

//批量插入数据
-(void)insertDeviceDataCacheShowModel:(NSMutableArray *)dataArr;

//查找单个设备
-(NSMutableArray *)queryAllDeviceDataCacheShowModelDevice:(NSString *)device;

//删除所有数据
-(void)deleteAllData;

@end
