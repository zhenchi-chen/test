//
//  CustomModel.h
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/27.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject

@property (nonatomic,strong)NSString *modeName; //模式
@property (nonatomic,strong)NSString *vibrationNumber; //震动次数
@property (nonatomic,strong)NSString *vibrationContinuousTime; //持续时间ms
@property (nonatomic,strong)NSString *vibrationTimeInterval; //时间间隔ms


@end
