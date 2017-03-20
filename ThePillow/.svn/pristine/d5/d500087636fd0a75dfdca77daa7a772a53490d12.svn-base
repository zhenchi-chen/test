//
//  DeviceListTool.m
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/29.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "DeviceListTool.h"
#import "MyFMDataManager.h"

@implementation DeviceListTool


//创建设备列表数据表
-(void)createDeviceListShowTable {
    NSString *sql = @"create table if not exists deviceList (did text primary key,didInfo text,userInfo text,snore text,clock text,rule text,isServer text);";
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//批量插入数据
-(void)insertDeviceListShowModel:(NSMutableArray *)dataArr {
    NSMutableArray *sqlArr = [NSMutableArray array];
    for (DeviceModel *model in dataArr) {
        NSString *sql = [NSString stringWithFormat:@"insert into deviceList (did, didInfo, userInfo, snore, clock, rule, isServer) values ('%@','%@','%@','%@','%@','%@','%@');",model.did,model.didInfo,model.userInfo,model.snore,model.clock,model.rule,model.isServer];
        [sqlArr addObject:sql];
    }
    //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSqls:sqlArr];
}

//单条插入
-(void)insertDeviceList:(DeviceModel *)model {
    NSString *sql = [NSString stringWithFormat:@"insert into deviceList (did, didInfo, userInfo, snore, clock, rule, isServer) values ('%@','%@','%@','%@','%@','%@','%@');",model.did,model.didInfo,model.userInfo,model.snore,model.clock,model.rule,model.isServer];
      //执行sql
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}


//修改单条数据
-(void)updateDataDevice:(NSString *)device andChangeName:(NSString *)name andChange:(NSString *)change {
    //did, rule, didInfo, userInfo, snore, clock, isServer
    NSString *sql = [NSString stringWithFormat:@"update deviceList set isServer = 0,'%@' = '%@' where did = '%@'",name,change,device];
    if ([name isEqualToString:@"isServer"]) {
        sql = [NSString stringWithFormat:@"update deviceList set isServer = '%@' where did = '%@'",change,device];
    }
    
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];

}

//删除所有数据
-(void)deleteAllData {
    NSString *sql = [NSString stringWithFormat:@"delete from deviceList"];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//删除单条数据
-(void)deleteData:(NSString *)device {
    NSString*sql =[NSString stringWithFormat:@"delete from deviceList where did='%@'",device];
    [[MyFMDataManager sharedManager] executeUpdateSql:sql];
}

//查找单条数据
-(DeviceModel *)queryDeviceListShowModelDevice:(NSString *)device {
    //查找单条语句
    NSString *sql = [NSString stringWithFormat:@"select * from deviceList where did = '%@'",device];
    NSDictionary *tempDic = [[MyFMDataManager sharedManager] queryPrimaryWithSql:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (did, rule, didInfo, userInfo, snore, clock, isServer)
        [dic setValue:[set stringForColumn:@"did"] forKey:@"did"];
        [dic setValue:[set stringForColumn:@"didInfo"] forKey:@"didInfo"];
        [dic setValue:[set stringForColumn:@"userInfo"] forKey:@"userInfo"];
        [dic setValue:[set stringForColumn:@"snore"] forKey:@"snore"];
        [dic setValue:[set stringForColumn:@"clock"] forKey:@"clock"];
        [dic setValue:[set stringForColumn:@"rule"] forKey:@"rule"];
        [dic setValue:[set stringForColumn:@"isServer"] forKey:@"isServer"];
    }];
    
    DeviceModel *tempModel = [[DeviceModel alloc] init];
    [tempModel setValuesForKeysWithDictionary:tempDic];
    
    return tempModel;
}

//查找所有数据
-(NSMutableArray *)queryAllDeviceListShowModels {
    
    NSString *sql = [NSString stringWithFormat:@"select * from deviceList"];
    NSMutableArray *temp = [[MyFMDataManager sharedManager] queryResultsWithSqls:sql block:^(FMResultSet *set, NSMutableDictionary *dic) {
        //组装数据 (did, rule, didInfo, userInfo, snore, clock, isServer)
        [dic setValue:[set stringForColumn:@"did"] forKey:@"did"];
        [dic setValue:[set stringForColumn:@"didInfo"] forKey:@"didInfo"];
        [dic setValue:[set stringForColumn:@"userInfo"] forKey:@"userInfo"];
        [dic setValue:[set stringForColumn:@"snore"] forKey:@"snore"];
        [dic setValue:[set stringForColumn:@"clock"] forKey:@"clock"];
        [dic setValue:[set stringForColumn:@"rule"] forKey:@"rule"];
        [dic setValue:[set stringForColumn:@"isServer"] forKey:@"isServer"];
    }];
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in temp) {
        DeviceModel *tempModel = [[DeviceModel alloc] init];
        [tempModel setValuesForKeysWithDictionary:dic];
        [resultArr addObject:tempModel];
//        NSLog(@"_____%@",tempModel.did);
    }
    return resultArr;
}

@end
