//
//  DeviceListTool.h
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/29.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DeviceListTool : NSObject

//创建设备列表数据表
-(void)createDeviceListShowTable;

//修改单条数据
-(void)updateDataDevice:(NSString *)device andChangeName:(NSString *)name andChange:(NSString *)change;

//单条插入
-(void)insertDeviceList:(DeviceModel *)model;

//查找单条数据
-(DeviceModel *)queryDeviceListShowModelDevice:(NSString *)device;

//删除单条数据
-(void)deleteData:(NSString *)device;

//批量插入数据
-(void)insertDeviceListShowModel:(NSMutableArray *)dataArr;

//查找所有数据
-(NSMutableArray *)queryAllDeviceListShowModels;

//删除所有数据
-(void)deleteAllData;

@end
