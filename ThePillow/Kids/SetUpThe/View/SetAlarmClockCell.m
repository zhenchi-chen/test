//
//  SetAlarmClockCell.m
//  ThePillow
//
//  Created by 陈镇池 on 2017/1/22.
//  Copyright © 2017年 chen_zhenchi_lehu. All rights reserved.
//

#import "SetAlarmClockCell.h"

@implementation SetAlarmClockCell

#pragma -mark代码创建cell的时候执行的方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化的代码
        [self layoutCell];
    }
    
    return self;
}

#pragma -mark对cell进行排版的方法
-(void)layoutCell
{
    _mySwitch = [[ UISwitch alloc]init];
    //    mySwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
//    [_mySwitch setOn:YES animated:YES];
    _mySwitch.onTintColor = MainColor; // 在oneSwitch开启的状态显示的颜色 默认是blueColor
    _mySwitch.backgroundColor = MainColorLightGrey;
    _mySwitch.layer.cornerRadius = _mySwitch.frame.size.height/2;
    _mySwitch.clipsToBounds = YES;
    _mySwitch.x= MainScreenWidth-80*Width;
    _mySwitch.y = self.contentView.centerY;
    [self.contentView addSubview:_mySwitch];
    [_mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
   

    
    //时间
    self.timeLb = [[UILabel alloc]initWithFrame:CGRectMake(40*Width, 20, MainScreenWidth-80*Width-_mySwitch.width, 30)];
    //    self.nameLabel.backgroundColor = [UIColor brownColor];
    _timeLb.font = [UIFont systemFontOfSize:26];
//    _timeLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLb];
    
    
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20*Width, height_y(_timeLb), MainScreenWidth-80*Width-_mySwitch.width, 20)];
    _titleLb.font = [UIFont systemFontOfSize:13];
   [self.contentView addSubview:self.titleLb];
    
}


#pragma mark 监听开关
- (void) switchValueChanged:(UISwitch *)sender{
    
    if ([self.delegate respondsToSelector:@selector(showSwitchingSetAlarmClockCellSwitchStatus:andRow:)]) {
        [self.delegate showSwitchingSetAlarmClockCellSwitchStatus:sender.on andRow:_row];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
