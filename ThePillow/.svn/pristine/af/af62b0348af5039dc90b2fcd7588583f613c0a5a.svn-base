//
//  SwitchingDeviceCell.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchingDeviceCellDelegate <NSObject>
@optional

-(void)showSwitchingDeviceCellTap:(NSInteger)tap;

@end

@interface SwitchingDeviceCell : UITableViewCell

@property (nonatomic,strong)UILabel *nameLb; //名字

@property (nonatomic,strong)UILabel *didLb; //ID

@property (nonatomic,strong)UIImageView *photoIV; //头像

@property (nonatomic,strong)UIImageView *tagIV; //主页标记

@property (nonatomic,strong)UIImageView *ewmIV; //二维码

@property (nonatomic,assign)NSInteger cellTag; //现在是哪一个cell

@property (nonatomic,strong)UIView *isBluetoothSensorView; //是否同步蓝牙传感器

@property (nonatomic,weak)id<SwitchingDeviceCellDelegate>delegate;

@end
