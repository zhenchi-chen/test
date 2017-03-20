//
//  DeviceDataCacheModel.h
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/10.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceDataCacheModel : NSObject
@property (nonatomic,strong)NSString *time;  //时间
@property (nonatomic,strong)NSString *deviceId; //设备id
@property (nonatomic,strong)NSString *data; //数据
@property (nonatomic,assign)NSInteger isVariable; //是否可改
@end
