//
//  PlusDeviceViewController.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/20.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlusDeviceViewController : BaseViewController<HttpBaseRequestUtilDelegate>

//标记,从哪个页面进来
@property(nonatomic,assign)NSInteger myTag;

@end
