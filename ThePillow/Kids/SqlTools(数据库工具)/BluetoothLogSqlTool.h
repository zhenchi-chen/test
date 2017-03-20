//
//  BluetoothBluetoothLogSqlTool.h
//  Kids
//
//  Created by 陈镇池 on 2017/1/20.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothLogSqlTool : NSObject

//创建接收蓝牙数据表
-(void)createBluetoothLogShowTable;

//批量插入数据
-(void)insertBluetoothLogShowModel:(NSMutableArray *)dataArr;

//单条插入
-(void)insertBluetoothLogTitle:(NSString *)title andId:(NSString *)deviceID;

//删除所有数据
-(void)deleteAllData;

//查找所有数据
-(NSMutableArray *)queryAllBluetoothLogShowModels;

@end
