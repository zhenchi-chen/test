//
//  MyFMDataManager.h

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface MyFMDataManager : NSObject
//属性1
@property(nonatomic,strong)FMDatabase *db;

/**
 *  单例返回对象
 *
 *  @return <#return value description#>
 */
+ (MyFMDataManager *)sharedManager;

/**
 *  新建数据库并且返回(在Documents文件夹下创建)
 *
 *  @param name 数据库名
 *
 *  @return <#return value description#>
 */
-(FMDatabase *)createDataBase:(NSString *)name;

/**
 *  数据库插入,更新,删除操作(单条语句)
 *
 *  @param sql 数据库语句
 *
 *  @return <#return value description#>
 */
-(BOOL)executeUpdateSql:(NSString *)sql;

/**
 *  数据库插入,更新,删除操作(多条语句)
 *
 *  @param sql 数据库语句
 *
 *  @return <#return value description#>
 */
-(BOOL)executeUpdateSqls:(NSArray *)sqls;


 /**
 *  数据库查询,返回单条(唯一)结果
 *
 *  @param sql 数据库语句
 *
 *  @param handler 回调处理,用于填充数据
 *
 *  @return <#return value description#>
 */
-(NSMutableDictionary *)queryPrimaryWithSql:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0);

/**
 *  数据库查询,返回结果数组(里面存放字典)
 *
 *  @param sql 数据库语句
 *
 *  @param handler 回调处理,用于填充数据
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)queryResultsWithSqls:(NSString *)sql block:(void (^)(FMResultSet* set, NSMutableDictionary *dic)) handler NS_AVAILABLE(10_7, 5_0);


/**
 *  表添加字段(text类型的)
 *
 *  @param tableName  表名
 *  @param columnName 要添加的字段名
 *
 *  @return <#return value description#>
 */
-(BOOL)addTableColumnTableName:(NSString *)tableName columnName:(NSString *)columnName;

//数据库版本控制

/**
 *  建立数据库版本表
 *  @return <#return value description#>
 */
-(BOOL)createVersionTabel;

/**
 *  设置当前数据库版本 格式参照 版本号+时间 如'1.0.0'
 *
 *  @param version <#version description#>
 *  @return <#return value description#>
 */
-(BOOL)setDataBaseVersion:(NSString *)version;

/**
 *  获取当前数据库版本
 *
 *  @return 版本信息 版本号+时间 如'1.0.0.20150201'
 */
-(NSString *)getDataBaseVersion;

/**
 *  判断数据库释放需要升级版本
 *
 *  @param version <#version description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)existsUpVersion:(NSString *)version;

@end
