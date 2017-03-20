//
//  LoginController.h
//  PingHuoTuan
//
//  Created by athudong04 on 15/12/25.
//  Copyright © 2015年 丁小城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : BaseViewController<HttpBaseRequestUtilDelegate>

@property (nonatomic,assign)NSInteger deviceNum;
@property (nonatomic,assign)NSInteger tagNum;

@end
