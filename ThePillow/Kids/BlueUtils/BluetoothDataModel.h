//
//  BluetoothDataModel.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/4.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothDataModel : NSObject

@property (nonatomic,assign)long time; //时间戳
@property (nonatomic,strong)NSString * type; //类型
@property (nonatomic,strong)NSString * A; //参数 A
@property (nonatomic,strong)NSString * B; //参数 B
@property (nonatomic,strong)NSString * CRC; //有效性,验证
@property (nonatomic,strong)NSString *deviceid; //设备ID
@property (nonatomic,strong)NSString *address; //地址
@property (nonatomic,assign)int upload; //是否上传 0无,1有

@end
