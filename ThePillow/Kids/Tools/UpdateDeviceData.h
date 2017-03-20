//
//  UpdateDeviceData.h
//  ThePillow
//
//  Created by 陈镇池 on 2017/2/7.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateDeviceData : NSObject




/**
 *  单例返回对象
 *
 *  @return <#return value description#>
 */
+ (UpdateDeviceData *)sharedManager;

//修改单条数据
-(void)setUpdateDataDeviceModel:(DeviceModel *)deviceModel andtype:(NSInteger)number andChangeName:(NSString *)name andChangeDetail:(NSString *)detail;


//读取数据
- (DeviceModel *)getReadData;

//是否需要同步蓝牙
- (BOOL)isSetBluetoothSensorDevice:(DeviceModel *)deviceModel;

//设为首页
-(void)setUpdateDataDevice:(DeviceModel *)deviceModel;

#pragma mark 解析后台设备列表
- (void)setDeviceData:(NSArray *)array;

#pragma mark 添加后台设备列表中本地没有的设备
- (void)addDeviceData:(NSArray *)array andDeviceId:(NSString *)device;

@end
