//
//  UserInfoModel.h
//  ThePillow
//
//  Created by 陈镇池 on 2016/12/26.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic,strong)NSString *age; //年龄
@property (nonatomic,strong)NSString *gender; //性别1,男,2女
@property (nonatomic,strong)NSString *height; //身高
@property (nonatomic,strong)NSString *portrait; //头像
@property (nonatomic,strong)NSString *weight; //体重

@end
