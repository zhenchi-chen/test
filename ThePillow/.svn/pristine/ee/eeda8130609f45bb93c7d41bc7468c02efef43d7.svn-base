//
//  SwitchingDeviceCell.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "SwitchingDeviceCell.h"

@implementation SwitchingDeviceCell


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
    //图片
    self.photoIV = [[UIImageView alloc]initWithFrame:CGRectMake(20*Width, 20, 60, 60)];
    _photoIV.userInteractionEnabled = YES;
    [self.contentView addSubview:self.photoIV];
    
    self.tagIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    _tagIV.backgroundColor = MainColorWhite;
    _tagIV.layer.cornerRadius = _tagIV.width/2;
//    _tagIV.layer.borderWidth = 1;
//    _tagIV.layer.borderColor = [UIColor clearColor].CGColor;
    _tagIV.clipsToBounds = YES;
    _tagIV.center = CGPointMake(width_x(_photoIV)-10, _photoIV.y+10);
    [self.contentView addSubview:self.tagIV];
    
    _isBluetoothSensorView = [[UIView alloc]init];
    _isBluetoothSensorView.x = width_x(_photoIV)+10*Width;
    _isBluetoothSensorView.centerY = _photoIV.centerY;
    _isBluetoothSensorView.size = CGSizeMake(6, 6);
    _isBluetoothSensorView.layer.cornerRadius = _isBluetoothSensorView.frame.size.height/2;
    _isBluetoothSensorView.clipsToBounds = YES;
    [self.contentView addSubview:_isBluetoothSensorView];
    
    //标题
    self.nameLb = [[UILabel alloc]initWithFrame:CGRectMake(width_x(_isBluetoothSensorView)+10*Width, 20, MainScreenWidth-80-60*Width, 30)];
    //    self.nameLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.nameLb];
    
    //详情
    self.didLb = [[UILabel alloc]initWithFrame:CGRectMake(_nameLb.x, height_y(_nameLb)+10, _nameLb.width, 20)];
    //    self.minuteLabel.backgroundColor = [UIColor cyanColor];
    self.didLb.font = [UIFont systemFontOfSize:14];
    self.didLb.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.didLb];
    
    
    //图片
    self.ewmIV = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth-20-10*Width, 40, 20, 20)];
    _ewmIV.image =[UIImage imageNamed:@"ToRight"];
    _ewmIV.userInteractionEnabled = YES;
//    [self.contentView addSubview:self.ewmIV];

    
    MyTap *tap1 = [[MyTap alloc]initWithTarget:self action:@selector(ewmIVAction:)];
    [_photoIV addGestureRecognizer:tap1];

}


-(void)ewmIVAction:(MyTap *)tap
{
//    NSLog(@"你点击的是第%ld个cell",(long)_cellTag);
    if ([self.delegate respondsToSelector:@selector(showSwitchingDeviceCellTap:)]) {
        [self.delegate showSwitchingDeviceCellTap:_cellTag];
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
