//
//  ConfigModel.h
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/29.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigModel : NSObject

@property (nonatomic,strong)NSString *select; //选择模式
@property (nonatomic,strong)NSArray *custom; //模式列表
@property (nonatomic,strong)NSString *isValid; //有没有同步到传感器 0没有 1有

@end
