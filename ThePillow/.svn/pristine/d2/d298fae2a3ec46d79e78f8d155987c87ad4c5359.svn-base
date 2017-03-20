//
//  ConfigurationUtil.m
//  BluetoothSDK
//
//  Created by xiaowen.chen on 16/9/14.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "ConfigurationUtil.h"
#import "BlueEnums.h"

@interface ConfigurationUtil()

@property (assign,nonatomic)int timeInterval; //时间间隔
@property (assign,nonatomic)int blueStatic;   //蓝牙状态

@end

@implementation ConfigurationUtil

+ (ConfigurationUtil *)sharedManager
{
    static ConfigurationUtil *sharedConfigurationUtilInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedConfigurationUtilInstance = [[self alloc] init];
        sharedConfigurationUtilInstance.blueStatic = bluetooth_result_nil;
        sharedConfigurationUtilInstance.timeInterval = 0;
        
    });
    
    return sharedConfigurationUtilInstance;
}

//设置时间间隔
-(void)setTimeIntervalWithTab:(int)tab{
    switch (tab) {
        case TimeInterval_30:
            self.timeInterval = 30;
            break;
        case TimeInterval_60:
            self.timeInterval = 60;
            break;
        case TimeInterval_120:
            self.timeInterval = 120;
            break;
        case TimeInterval_180:
            self.timeInterval = 180;
            break;
        case TimeInterval_300:
            self.timeInterval = 300;
            break;
        case TimeInterval_600:
            self.timeInterval = 600;
            break;
        default:
            self.timeInterval = 0;
            break;
    }

}
//获取时间间隔
-(int)getTimeInterval{
    return _timeInterval;
}

//设置蓝牙状态
-(void)setBlueStatic:(int)state{
    _blueStatic = state;
}
//获取蓝牙状态
-(int)getBlueStatic{
   return _blueStatic;
}

@end
