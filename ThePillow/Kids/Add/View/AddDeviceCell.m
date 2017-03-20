//
//  AddDeviceCell.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/16.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "AddDeviceCell.h"

@implementation AddDeviceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellView];
    };
    return self;
}

#pragma mark 初始化cell
-(void)createCellView{
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth/3*2, 25)];
    _timeLb.font = [UIFont systemFontOfSize:12];
    _timeLb.textColor = RGB(138, 138, 138);
    [self addSubview:_timeLb];
    
    _typeLb = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenWidth/3*2, 0, MainScreenWidth/3, 25)];
    _typeLb.font = [UIFont systemFontOfSize:12];
    _typeLb.textColor = RGB(138, 138, 138);
    [self addSubview:_typeLb];
    
    _aLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, MainScreenWidth/2, 25)];
    _aLb.font = [UIFont systemFontOfSize:12];
    _aLb.textColor = RGB(138, 138, 138);
    [self addSubview:_aLb];
    
    _bLb = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenWidth/2, 25,MainScreenWidth/2, 25)];
    _bLb.font = [UIFont systemFontOfSize:12];
    _bLb.textColor = RGB(138, 138, 138);
    [self addSubview:_bLb];

}

@end
