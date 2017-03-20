//
//  DeviceDataCacheTool.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/10.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "DeviceDataCacheTool.h"
#import "MyFMDataManager.h"

@implementation DeviceDataCacheTool


//创建设备列表数据表
-(void)createDeviceDataCacheShowTable {
    NSString *sql = @"create table if not exists deviceDataCache (deviceId text,time text,data text,isVariable integer);";
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//批量插入数据
-(void)insertDeviceDataCacheShowModel:(NSMutableArray *)dataArr {
    NSMutableArray *sqlArr = [NSMutableArray array];
    for (DeviceDataCacheModel *model in dataArr) {
        NSString *sql = [NSString stringWithFormat:@"insert into deviceDataCache (deviceId, time, data,isVariable) values ('%@','%@','%@',%ld);",model.deviceId,model.time,model.data,model.isVariable];
        [sqlArr addObject:sql];
    }
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSqls:sqlArr];
}

//单条插入
-(void)insertDeviceDataCache:(DeviceDataCacheModel *)model {
    NSString *sql = [NSString stringWithFormat:@"insert into deviceDataCache (deviceId, time, data,isVariable) values ('%@','%@','%@',%ld);",model.deviceId,model.time,model.data,model.isVariable];
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}


//修改单条数据属性
-(void)updateDataDeviceId:(NSString *)device andChangeTime:(NSString *)time andName:(NSString *)name andData:(NSString *)data{

    NSString *sql = [NSString stringWithFormat:@"update deviceDataCache set isVariable = 0,'%@' = '%@' where deviceId = '%@' and time = '%@'",name,data,device,time];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
    
}

//删除所有数据
-(void)deleteAllData {
    NSString *sql = [NSString stringWithFormat:@"delete from deviceDataCache"];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//删除单个设备每个时间段之前数据
-(void)deleteData:(NSString *)device andTime:(NSString *)time {
    NSString*sql =[NSString stringWithFormat:@"delete from deviceDataCache where deviceId='%@' and time<'%@'",device,time];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}
//删除单个设备
-(void)deleteData:(NSString *)device {
    
    NSString*sql =[NSString stringWithFormat:@"delete from deviceDataCache where deviceId='%@'",device];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//查找单条数据
-(DeviceDataCacheModel *)queryDeviceDataCacheShowModelDevice:(NSString *)device andTime:(NSString *)time {
    //查找单条语句
    NSString *sql = [NSString stringWithFormat:@"select * from deviceDataCache where deviceId = '%@' and time='%@'",device,time];
    NSDictionary *tempDic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (deviceId, time, data,isVariable)
        [dic setValue:[set stringForColumn:@"deviceId"] forKey:@"deviceId"];
        [dic setValue:[set stringForColumn:@"time"] forKey:@"time"];
        [dic setValue:[set stringForColumn:@"data"] forKey:@"data"];
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"isVariable"]] forKey:@"isVariable"];
    }];
    
    DeviceDataCacheModel *tempModel = [[DeviceDataCacheModel alloc] init];
    [tempModel setValuesForKeysWithDictionary:tempDic];
    
    return tempModel;
}

//查找单条数据是否可改
-(NSInteger)queryDeviceDataCacheShowIsVariableDevice:(NSString *)device andTime:(NSString *)time {
    //查找单条语句
    NSString *sql = [NSString stringWithFormat:@"select * from deviceDataCache where deviceId = '%@' and time='%@'",device,time];
    NSDictionary *tempDic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"isVariable"]] forKey:@"isVariable"];
    }];
    
    return [[tempDic valueForKey:@"isVariable"] integerValue];
}

//查找所有
-(NSMutableArray *)queryAllDeviceDataCacheShowModelDevice:(NSString *)device {
    
    NSString *sql = [NSString stringWithFormat:@"select * from deviceDataCache where deviceId = '%@'",device];
    NSMutableArray *temp = [[MyFMDataManager sharedManager] queryResultsWithSqls:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (deviceId, time, data,isVariable)
        [dic setValue:[set stringForColumn:@"deviceId"] forKey:@"deviceId"];
        [dic setValue:[set stringForColumn:@"time"] forKey:@"time"];
        [dic setValue:[set stringForColumn:@"data"] forKey:@"data"];
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"isVariable"]] forKey:@"isVariable"];
    }];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in temp) {
        DeviceDataCacheModel *tempModel = [[DeviceDataCacheModel alloc] init];
        [tempModel setValuesForKeysWithDictionary:dic];
        [resultArr addObject:tempModel];
        //        NSLog(@"_____%@",tempModel.did);
    }
    return resultArr;
}

@end
