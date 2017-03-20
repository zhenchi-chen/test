//
//  ClockViewController.h
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "BaseViewController.h"

@interface ClockViewController : BaseViewController

@property (nonatomic, assign)BOOL isAddClock; //是否是新增闹钟

@property (nonatomic, assign)NSInteger numberTag; //是修改第几个闹钟

@property(nonatomic,strong)NSString *deviceDid; //设备id


@end
