//
//  BluetoothViewController.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/7/21.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "BaseViewController.h"

#define number_getData 100000000


@interface BluetoothViewController : BaseViewController
{
    
    NSInteger obtainData; //获取回来的数据条数
    
    
}

//当前的操作 正在读取0,空闲状态1
@property(assign,nonatomic)int oplationStatic;
//当前操作的结束地址
@property(assign,nonatomic)int endAddress;
//起始时间戳,上次设定的时间戳
@property(assign,nonatomic)long begainTimestemp;

//当前的操作 是否获取更多数据,否0,是1
@property(assign,nonatomic)int isForMoreData;

//当前的操作 蓝牙状态,正常0,异常1
@property(assign,nonatomic)int isBluetoothIsNormal;

//当前正在拿的开始位置
@property(assign,nonatomic)int currentIndex;

//当前正在拿的结束位置
@property(assign,nonatomic)int endIndex;

//获取最后一条数据的时间
@property (assign,nonatomic)long lastTimeUpDate;

//定时器是否有效,无效0,有效1
@property(assign,nonatomic)int isEffective;


@property (strong,nonatomic)NSString *firsDataStr; //多条数据返回的第一条数据条
@property (assign,nonatomic)int isfirsData; //1 第一条,2 第二条,3 第三条及以上
@property (assign,nonatomic)int bi; //第几批
@property (assign,nonatomic)int invalidData; //无效数据
@property (nonatomic,assign)int present; //进度



@end
