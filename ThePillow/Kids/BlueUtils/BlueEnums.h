//
//  BlueEnums.h
//  BluetoothSDK
//
//  Created by xiaowen.chen on 16/9/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueEnums : NSObject


typedef NS_ENUM(NSInteger, TimeInterval)
{
    TimeInterval_0 = 0,
    TimeInterval_30 = 1,
    TimeInterval_60 = 2,
    TimeInterval_120 = 3,
    TimeInterval_180 = 4,
    TimeInterval_300 = 5,
    TimeInterval_600 = 6
};

//返回蓝牙数据的结果
typedef NS_ENUM(NSInteger, bluetooth_result)
{
    bluetooth_result_nil = 0,            //蓝牙未连接
    bluetooth_result_fail = 1,           //返回数据有误
    bluetooth_result_success = 2,        //返回数据成功
    bluetooth_result_busy = 3,           //蓝牙正忙/被锁定状态
    bluetooth_result_log = 4,            //log信息输出
    bluetooth_result_staticupdate = 5,   //蓝牙状态改变信息
    bluetooth_result_version = 6,        //蓝牙版本信息回传
    bluetooth_result_electricCharge = 7, //蓝牙电量回传
    bluetooth_result_ready = 8,          //蓝牙已经准备好
    bluetooth_result_snore = 9,          //设置打鼾模式成功信息回传
    bluetooth_result_bluetoothError = 10,//蓝牙错误回传 弃用
    bluetooth_result_bluetoothTimeout = 11,//蓝牙超时
    bluetooth_result_anknow = 100        //未知异常
    
};

//蓝牙状态
typedef NS_ENUM(NSInteger, bluetooth_static)
{
    bluetooth_static_nil = 0,         //没连接状态/或者链接异常
    bluetooth_static_connecting = 1,  //正在连接
    bluetooth_static_free = 5         //蓝牙处于连接状态
};


@end
