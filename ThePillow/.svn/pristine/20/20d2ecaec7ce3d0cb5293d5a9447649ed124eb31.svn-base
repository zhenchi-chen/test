//
//  BluetoothLogSqlTool.m
//  Kids
//
//  Created by 陈镇池 on 2017/1/20.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "BluetoothLogSqlTool.h"

@implementation BluetoothLogSqlTool


//创建接收蓝牙数据表
-(void)createBluetoothLogShowTable{
    
    NSString *sql = @"create table if not exists bluetoothLog (time text,deviceID text,title text);";
    
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//批量插入数据
-(void)insertBluetoothLogShowModel:(NSMutableArray *)dataArr {
    
    NSString *nowTime = [[NSString alloc] initWithDate:[NSDate date] format:@"yyyy-MM-dd hh:mm:ss"];
    NSMutableArray *sqlArr = [NSMutableArray array];
    for (LogModel *model in dataArr) {
        
        NSString *sql = [NSString stringWithFormat:@"insert into bluetoothLog (time, deviceID, title) values ('%@','%@','%@');",nowTime,model.deviceID,model.title];
        
        [sqlArr addObject:sql];
    }
    
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSqls:sqlArr];
}

//单条插入
-(void)insertBluetoothLogTitle:(NSString *)title andId:(NSString *)deviceID {
    
    //添加
    NSString *nowTime = [[NSString alloc] initWithDate:[NSDate date] format:@"yyyy-MM-dd hh:mm:ss"];
    NSString *sql = [NSString stringWithFormat:@"insert into bluetoothLog (time, title, deviceID) values ('%@','%@','%@');",nowTime,title,deviceID];
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//删除所有数据
-(void)deleteAllData {
    
    NSString *sql = [NSString stringWithFormat:@"delete from bluetoothLog"];
    
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//查找所有数据
-(NSMutableArray *)queryAllBluetoothLogShowModels {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bluetoothLog"];
    NSMutableArray *temp = [[MyFMDataManager sharedManager] queryResultsWithSqls:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (time, title, deviceID)
        [dic setValue:[set stringForColumn:@"time"] forKey:@"time"];
        [dic setValue:[set stringForColumn:@"deviceID"] forKey:@"deviceID"];
        [dic setValue:[set stringForColumn:@"title"] forKey:@"title"];
    }];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in temp) {
        LogModel *tempModel = [[LogModel alloc] init];
        [tempModel setValuesForKeysWithDictionary:dic];
        [resultArr addObject:tempModel];

    }
    
    return resultArr;
    
}

@end
