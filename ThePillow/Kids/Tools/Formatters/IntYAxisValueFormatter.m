//
//  IntYAxisValueFormatter.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/3/2.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "IntYAxisValueFormatter.h"

@implementation IntYAxisValueFormatter

-(id)initWithYArr:(NSMutableArray *)arr{
    self = [super init];
    if (self)
    {
        _yArr = arr;
        
    }
    return self;
}


- (NSMutableArray *)myArr {
    if (!_yArr) {
        _yArr = [NSMutableArray array];
    }
    return _yArr;
}


- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    return _yArr[(NSInteger)value];
    
}


@end
