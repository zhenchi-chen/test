//
//  IntAxisValueFormatter.m
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

#import "IntAxisValueFormatter.h"

@implementation IntAxisValueFormatter

-(id)initWithArr:(NSMutableArray *)arr{
    self = [super init];
    if (self)
    {
        _myArr = arr;
        
    }
    return self;
}


//- (NSMutableArray *)myArr {
//    if (!_myArr) {
//        _myArr = [NSMutableArray array];
//    }
//    return _myArr;
//}


- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    if (_myArr.count == 3) {
        
        
    }
//    NSLog(@"++%.f,%@",value,_myArr[(int)value]);
    if (_myArr == nil) {
        return [NSString stringWithFormat:@"%.f",value];
    }else {
        return _myArr[(NSInteger)value];
    }
    
}



@end
