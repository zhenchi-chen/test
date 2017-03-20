//
//  BluetoothOrder.h
//  BluetoothSDK
//
//  Created by 陈镇池 on 16/9/12.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlueBlock)(int result,NSDictionary *dic,NSError *error);


@interface BluetoothOrder : UIViewController

//连接蓝牙,传入设备ID
- (void)ConnectionBluetoothDeviceMacAddress:(NSString *)macAddress block:(BlueBlock)block;
// 初始化蓝牙设备
- (void)initializeDevice:(BlueBlock)block;
// 设置压缩间隔时间,获取所有蓝牙信息
- (void)getBlueMessageWithTimeInterval:(int)tab block:(BlueBlock)block;
// 开启实时
- (void)getRealTimeMessage:(BlueBlock)block;
// 获取版本号
- (void)getVersion:(BlueBlock)block;
// 设置打鼾模式
- (void)getSnoreNum:(int)num andActivityTime:(int)activity andInterval:(int)interval block:(BlueBlock)block;
//设置闹钟震动
- (void)getClockNum:(int)num andActivityTime:(int)activity andInterval:(int)interval block:(BlueBlock)block;
//设置闹钟时间
- (void)getClockTimeNum:(int)num andClockTime:(int)clockPoint andClockNum:(int)clockNum block:(BlueBlock)block;

//断开蓝牙
- (void)DisconnectBluetooth:(BlueBlock)block;

#pragma mark - 蓝牙操作相关
//获取数据
-(void)getBluMessageWithData:(NSData *)data block:(BlueBlock)block;

@end
