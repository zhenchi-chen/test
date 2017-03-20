//
//  BluetoothDataSqlTool.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/4.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothDataModel.h"

@interface BluetoothDataSqlTool : NSObject

//创建接收蓝牙数据表
-(void)createBluetoothDataShowTable;

//批量插入数据
-(void)insertBluetoothDataShowModel:(NSMutableArray *)dataArr;

//单条插入
-(void)insertBluetoothDataModel:(BluetoothDataModel *)model;


//删除所有数据
-(void)deleteAllData;


//删除单个设备数据
-(void)deleteData:(NSInteger)time andDeviceid:(NSString *)deviceid;

//查找单条数据
-(NSDictionary *)queryBluetoothDataShowModelTime:(NSInteger)time;

//查找所有数据
-(NSMutableArray *)queryAllBluetoothDataShowModels;

//查找同一时间内所有数据
-(NSMutableArray *)queryOnlyTimeAllBluetoothDataShowModelsTime:(NSInteger)time andId:(NSString *)devcieID;

//查找最后同步上传成功的时间戳
-(long)queryAllBluetoothDataDevcieID:(NSString *)devcieID andBigId:(NSInteger)bidId;

//查找最大的id
-(NSInteger)queryAllBluetoothDataBigId;

//删除的一个月之前的数据并且返回删除条数 time时间戳
-(NSInteger)deleteMonthData:(NSInteger)time andBigId:(NSInteger)bidId;

@end
