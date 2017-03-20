//
//  SetAlarmClockCell.h
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchingSetAlarmClockCellDelegate <NSObject>
@optional

-(void)showSwitchingSetAlarmClockCellSwitchStatus:(BOOL)switchStatus andRow:(NSInteger)row;

@end

@interface SetAlarmClockCell : UITableViewCell

@property (nonatomic,strong)UILabel *timeLb;
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UISwitch* mySwitch;
@property (nonatomic,assign)NSInteger row; //你点击的是第几行

@property (nonatomic,weak)id<SwitchingSetAlarmClockCellDelegate>delegate;

@end
