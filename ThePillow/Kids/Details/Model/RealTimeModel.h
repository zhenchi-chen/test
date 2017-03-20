//
//  RealTimeModel.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/16.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealTimeModel : NSObject

@property (nonatomic,strong)NSString *cmov; //体动
@property (nonatomic,strong)NSString *br; //呼吸
@property (nonatomic,strong)NSString *date; //时间戳
@property (nonatomic,strong)NSString *hr; //心跳
@property (nonatomic,strong)NSString *p; //电量
@property (nonatomic,strong)NSString *status; //状态 unknown:未知 offline:下线 idle:无人 wake:在床 sleep:入睡 sensorOffline:传感器失联  sensorPowerError:电量错误 其他是未知状态
@property (nonatomic,strong)NSString *timestamp; //时间
@property (nonatomic,strong)NSString *utcOffset; //


@end
