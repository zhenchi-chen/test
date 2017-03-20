//
//  BluetoothDataSqlTool.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/4.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "BluetoothDataSqlTool.h"
#import "MyFMDataManager.h"
#import "NSString+MyNSString.h"

@implementation BluetoothDataSqlTool

//创建接收蓝牙数据表
-(void)createBluetoothDataShowTable
{
    NSString *sql = @"create table if not exists bluetoothData (id integer primary key autoincrement,address text,time integer,type text ,parameterA text,parameterB text,validity text,deviceid text,upload integer);";
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
    
}

//批量插入数据
-(void)insertBluetoothDataShowModel:(NSMutableArray *)dataArr
{
    NSMutableArray *sqlArr = [NSMutableArray array];
    for (BluetoothDataModel *model in dataArr) {
        NSString *sql = [NSString stringWithFormat:@"insert into bluetoothData (address, time, type, parameterA, parameterB, validity, deviceid, upload) values ('%@',%ld,'%@','%@','%@','%@','%@',%d);",model.address,(long)model.time,model.type,model.A,model.B,model.CRC,model.deviceid,model.upload];
//        NSLog(@"model.time = %ld,model.type = %@,model.A = %@,model.B = %@,model.deviceid = %@",model.time,model.type,model.A,model.B,model.deviceid);
        [sqlArr addObject:sql];
    }
    
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSqls:sqlArr];
}

//单条插入
-(void)insertBluetoothDataModel:(BluetoothDataModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"insert into bluetoothData (address, time, type, parameterA, parameterB, validity, deviceid, upload) values ('%@',%ld,'%@','%@','%@','%@','%@',%d);",model.address,(long)model.time,model.type,model.A,model.B,model.CRC,model.deviceid,model.upload];
//    NSLog(@"+++++%@,%@,%@,%@,%@,%@,%@",nowTime,model.address,model.time,model.type,model.parameterA,model.parameterB,model.validity);
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}


//删除所有数据
-(void)deleteAllData
{
    NSString *sql = [NSString stringWithFormat:@"delete from bluetoothData"];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//删除单个设备数据
-(void)deleteData:(NSInteger)time andDeviceid:(NSString *)deviceid
{
    NSString*sql =[NSString stringWithFormat:@"delete from bluetoothData where deviceid='%@'",deviceid];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];

}



//查询重复数据
- (void)SearchForDuplicateData:(NSString *)deviceid {
    
    
    NSString*sql =[NSString stringWithFormat:@"select count(*) from bluetoothData where _id > (select min(_id) from bluetoothData d where bluetoothData.time = d.time and  bluetoothData.type = d.type ) and did = '%@'",deviceid];
    
   
}

//查找单条数据
-(NSDictionary *)queryBluetoothDataShowModelTime:(NSInteger)time
{
    
    //查找单条语句
    NSString *sql = [NSString stringWithFormat:@"select * from bluetoothData where time = %ld",(long)time];
    NSDictionary *temdic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (address, time, type, parameterA, parameterB,validity,deviceid)
        [dic setValue:[set stringForColumn:@"address"] forKey:@"address"];
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"time"]] forKey:@"time"];
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"upload"]] forKey:@"upload"];
        [dic setValue:[set stringForColumn:@"type"] forKey:@"type"];
        [dic setValue:[set stringForColumn:@"parameterA"] forKey:@"parameterA"];
        [dic setValue:[set stringForColumn:@"parameterB"] forKey:@"parameterB"];
        [dic setValue:[set stringForColumn:@"validity"] forKey:@"validity"];
        [dic setValue:[set stringForColumn:@"deviceid"] forKey:@"deviceid"];
    }];
    return temdic;
}

//查找同一时间内所有数据
-(NSMutableArray *)queryOnlyTimeAllBluetoothDataShowModelsTime:(NSInteger)time andId:(NSString *)devcieID
{
    NSString *sql = [NSString stringWithFormat:@"select * from bluetoothData where time = %ld and deviceid = '%@'",(long)time,devcieID];
    
    NSMutableArray *temp = [[MyFMDataManager sharedManager] queryResultsWithSqls:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (address, time, type, parameterA, parameterB,validity,deviceid)
        [dic setValue:[set stringForColumn:@"address"] forKey:@"address"];
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"time"]] forKey:@"time"];
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"upload"]] forKey:@"upload"];
        [dic setValue:[set stringForColumn:@"type"] forKey:@"type"];
        [dic setValue:[set stringForColumn:@"parameterA"] forKey:@"parameterA"];
        [dic setValue:[set stringForColumn:@"parameterB"] forKey:@"parameterB"];
        [dic setValue:[set stringForColumn:@"validity"] forKey:@"validity"];
        [dic setValue:[set stringForColumn:@"deviceid"] forKey:@"deviceid"];
    }];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in temp) {
        BluetoothDataModel *tempModel = [[BluetoothDataModel alloc] init];
        [tempModel setValuesForKeysWithDictionary:dic];
        [resultArr addObject:tempModel];
        
        //        NSLog(@"_____%@",tempModel.time);
        
    }
    
    return resultArr;
    

}

//查找所有数据
-(NSMutableArray *)queryAllBluetoothDataShowModels{
    NSString *sql = [NSString stringWithFormat:@"select * from bluetoothData"];

    NSMutableArray *temp = [[MyFMDataManager sharedManager] queryResultsWithSqls:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (address, time, type, parameterA, parameterB,validity,deviceid)
        [dic setValue:[set stringForColumn:@"address"] forKey:@"address"];
//        [dic setValue:[set stringForColumn:@"time"] forKey:@"time"];
        //int 类型存储拿
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"time"]] forKey:@"time"];
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"upload"]] forKey:@"upload"];
//        NSLog(@"model.A = %@,model.B = %@,model.deviceid = %@",[set stringForColumn:@"parameterA"],[set stringForColumn:@"parameterB"],[set stringForColumn:@"deviceid"]);
        [dic setValue:[set stringForColumn:@"type"] forKey:@"type"];
        [dic setValue:[set stringForColumn:@"parameterA"] forKey:@"parameterA"];
        [dic setValue:[set stringForColumn:@"parameterB"] forKey:@"parameterB"];
        [dic setValue:[set stringForColumn:@"validity"] forKey:@"validity"];
        [dic setValue:[set stringForColumn:@"deviceid"] forKey:@"deviceid"];
    }];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in temp) {
         BluetoothDataModel *tempModel = [[BluetoothDataModel alloc] init];
        NSString *timeStr = [dic valueForKey:@"time"];
        tempModel.time = [timeStr longLongValue];
        tempModel.address =[dic valueForKey:@"address"];
        tempModel.type =[dic valueForKey:@"type"];
        tempModel.A =[dic valueForKey:@"parameterA"];
        tempModel.B =[dic valueForKey:@"parameterB"];
        tempModel.CRC =[dic valueForKey:@"validity"];
        tempModel.deviceid =[dic valueForKey:@"deviceid"];
        tempModel.upload =[[dic valueForKey:@"upload"] intValue];
//        [tempModel setValuesForKeysWithDictionary:dic];
        [resultArr addObject:tempModel];
        
//        NSLog(@"_____%@",tempModel.time);
//        NSLog(@"model.time = %ld,model.type = %@,model.A = %@,model.B = %@,model.deviceid = %@,CRC = %@",tempModel.time,tempModel.type,tempModel.A,tempModel.B,tempModel.deviceid,tempModel.CRC);
    }
    
    return resultArr;

}

//查找最后同步上传成功的时间戳
-(long)queryAllBluetoothDataDevcieID:(NSString *)devcieID andBigId:(NSInteger)bidId
{
    NSString *sql = [NSString stringWithFormat:@"select max(time) from bluetoothData where deviceid = '%@' and id <= %ld",devcieID,(long)bidId];
    NSDictionary *temdic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"time"]] forKey:@"time"];
//        NSLog(@"timeNew = %d",[set intForColumn:@"lastest"]);
    }];
//    NSLog(@"lastest = %ld",[[temdic valueForKey:@"lastest"] integerValue]);
    return [[temdic valueForKey:@"time"] longValue];
}

//删除的一个月之前的数据并且返回删除条数 time时间戳
-(NSInteger)deleteMonthData:(NSInteger)time andBigId:(NSInteger)bidId;
{
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as rscount from bluetoothData where time<%ld and id <= %ld",time,(long)bidId];
    NSDictionary *temdic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"rscount"]] forKey:@"rscount"];
    }];
    
    NSInteger number = [[temdic valueForKey:@"rscount"] integerValue];
    
    NSString*sql1 =[NSString stringWithFormat:@"delete from bluetoothData where time<%ld",time];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql1];
    
    return number;
}

//查找最大的id
-(NSInteger)queryAllBluetoothDataBigId
{
    NSString *sql = [NSString stringWithFormat:@"select max(id) as 'lastest' from bluetoothData"];
    
    NSDictionary *temdic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        [dic setValue:[NSString stringWithFormat:@"%d",[set intForColumn:@"lastest"]] forKey:@"lastest"];
        //        NSLog(@"timeNew = %d",[set intForColumn:@"lastest"]);
    }];
    //    NSLog(@"lastest = %ld",[[temdic valueForKey:@"lastest"] integerValue]);
    return [[temdic valueForKey:@"lastest"] integerValue];
}


@end
