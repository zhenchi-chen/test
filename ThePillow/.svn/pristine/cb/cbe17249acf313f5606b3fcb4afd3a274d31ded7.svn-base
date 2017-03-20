//
//  MyFMDataManager.m


#import "MyFMDataManager.h"

@implementation MyFMDataManager


+ (MyFMDataManager *)sharedManager
{
    static MyFMDataManager *sharedMyFMDataManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMyFMDataManagerInstance = [[self alloc] init];
        sharedMyFMDataManagerInstance.db = [sharedMyFMDataManagerInstance createDataBase:@"schedule_database.sqlite"];
    });
    
    return sharedMyFMDataManagerInstance;
}



//NSLog(@"%@",NSHomeDirectory());
//建立数据库
//db = [MyFMDataManager createDataBase:@"mytest.sqlite"];
-(FMDatabase *)createDataBase:(NSString *)name
{
    //在document文件夹下创建一个数据库 名字为students.sqlite
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *douPath = [arr lastObject];
    
    //创建数据库路径
    NSString *dbPath = [douPath stringByAppendingPathComponent:name];
    return [FMDatabase databaseWithPath:dbPath];
}

//建表
//NSString *sqlCreateTable = @"create table if not exists student (id integer primary key autoincrement,name text, sex text,age integer,address text)";
//[MyFMDataManager executeUpdate:db sql:sqlCreateTable];
//插入数据
//NSString *sqlInsert = [NSString stringWithFormat:@"insert into student (name,sex,age,address) values ('%@','%@',%d,'%@')",@"小明",@"男",11,@"广州"];
//[MyFMDataManager executeUpdate:db sql:sqlInsert];
-(BOOL)executeUpdateSql:(NSString *)sql;
{
    BOOL result = NO;
    if ([_db open]) {
        //语句执行
        result = [_db executeUpdate:sql];
    }
    [_db close];
    return result;
}

-(BOOL)executeUpdateSqls:(NSArray *)sqls;
{
    BOOL result = NO;
    if ([_db open]) {
        //语句执行
        for (NSString *temp in sqls) {
            result = [_db executeUpdate:temp];
        }
    }
    [_db close];
    return result;
}

//查找单条语句
//NSString *sqlQuery = @"select * from student where name = '小明'";
//NSDictionary *temdic = [MyFMDataManager queryPrimary:db sql:sqlQuery block:^(FMResultSet *set, NSMutableDictionary *dic) {
//    [dic setValue:[set stringForColumn:@"name"] forKey:@"name"];
//    [dic setValue:[set stringForColumn:@"name1"] forKey:@"name1"];
//    [dic setValue:[set stringForColumn:@"sex"] forKey:@"sex"];
//    [dic setValue:[set stringForColumn:@"age"] forKey:@"age"];
//    [dic setValue:[set stringForColumn:@"address"] forKey:@"address"];
//}];
//查找单条语句
-(NSMutableDictionary *)queryPrimaryWithSql:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0)
{
    NSMutableDictionary *dic = nil;
    if ([_db open]) {
        //语句执行
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            dic = [NSMutableDictionary dictionary];
            handler(set, dic);//回调的使用
            break;
        }
    }
    [_db close];
    return dic;
}

-(NSMutableArray *)queryResultsWithSqls:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0)
{
    NSMutableArray *arr = [NSMutableArray array];
   
    if ([_db open]) {
        //语句执行
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            handler(set, dic);
            [arr addObject:dic];
        }
    }
    [_db close];
    return arr;
}

//加字段
-(BOOL)addTableColumnTableName:(NSString *)tableName columnName:(NSString *)columnName
{
    NSString *sqlAlterTable = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ text", tableName, columnName];//添加表字段
    
    BOOL result = NO;
    if ([_db open]) {
        //语句执行
        result = [_db executeUpdate:sqlAlterTable];
    }
    [_db close];
    return result;
}

/**
 *  建立数据库版本表
 *
 */
-(BOOL)createVersionTabel
{
    BOOL result = NO;
    if ([_db open]) {
        NSString *sqlCreateTable = @"create table if not exists sofe_version(id integer primary key autoincrement,version text)";
        
        BOOL result = [_db executeUpdate:sqlCreateTable];
        if (result) {
            NSLog(@"建立version表成功");
            result = YES;
        }else{
            NSLog(@"建立version表失败");
        }
        [_db close];
    }
    return result;
}

/**
 *  设置当前数据库版本 格式参照 版本号 如'1.0.0'
 *
 */
-(BOOL)setDataBaseVersion:(NSString *)version
{
    //获取当前时间支付串
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyyMMdd"];
    NSString *tempDate = [forMatter stringFromDate:[NSDate date]];
    
    BOOL result = NO;
    if ([_db open]) {
        NSString *sqlCreateTable = [NSString stringWithFormat:@"insert into sofe_version(version) values ('%@')",[NSString stringWithFormat:@"%@.%@",version,tempDate]];
        
        BOOL result = [_db executeUpdate:sqlCreateTable];
        if (result) {
            NSLog(@"添加version信息成功");
            result = YES;
        }else{
            NSLog(@"添加version信息失败");
        }
        [_db close];
    }
    return result;
}

/**
 *  获取当前数据库版本
 *
 *  @return 版本信息 版本号+时间 如'1.0.0.20150201'
 */
-(NSString *)getDataBaseVersion
{
    NSString *str = nil;
    if ([_db open]) {
        NSString *sqlSelect = @"select *from sofe_version order by id desc";
        FMResultSet *set = [_db executeQuery:sqlSelect];
        while ([set next]) {
            str = [set stringForColumn:@"version"];
            [_db close];
            return str;
        }
    }
    [_db close];
    return str;
}


/**
 *  判断数据库释放需要升级版本
 *  @return <#return value description#>
 */
-(BOOL)existsUpVersion:(NSString *)version
{
    NSString *temp = [self getDataBaseVersion];
    NSArray *ar1 = [version componentsSeparatedByString:@"."];
    NSArray *ar2 = [temp componentsSeparatedByString:@"."];
    if ([ar1 count] >= 3) {
        if ([ar1[0] integerValue] > [ar2[0] integerValue]) {
            return YES;
        }else if([ar1[0] integerValue] == [ar2[0] integerValue]){
            if ([ar1[1] integerValue] > [ar2[1] integerValue]) {
                return YES;
            }else if([ar1[1] integerValue] == [ar2[1] integerValue]){
                if ([ar1[2] integerValue] > [ar2[2] integerValue]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end
