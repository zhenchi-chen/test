//
//  SelectBluetoothView.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/4/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "SelectBluetoothView.h"

@implementation SelectBluetoothView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createMyView];
    }
    
    return self;
}

- (void)createMyView
{
  
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = [UIFont systemFontOfSize:20];
    _titleLb.backgroundColor = MainColor;
    _titleLb.textColor = [UIColor whiteColor];
    _titleLb.text = NSLocalizedString(@"find_bluetooth_device_fragment_title", nil);
    [self addSubview:self.titleLb];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.width, self.height-80) style:UITableViewStylePlain];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.bounces = NO;
    [self addSubview:self.tableView];
    
    _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBt.backgroundColor = MainColor;
    _startBt.frame = CGRectMake(0,self.height-40, self.width, 40);
    _startBt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _startBt.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _startBt.selected = NO;
    [_startBt setTitle:NSLocalizedString(@"find_bluetooth_device_fragment_stop_refresh", nil) forState:UIControlStateNormal];
    [_startBt setTitle:NSLocalizedString(@"find_bluetooth_device_fragment_refresh", nil) forState:UIControlStateSelected];
    [_startBt setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    [_startBt setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
    [_startBt addTarget:self action:@selector(startBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startBt];

}

#pragma mark 停止/开始扫描
- (void)startBtAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didSelectSelectBluetoothViewWithbutton:)]) {
        [self.delegate didSelectSelectBluetoothViewWithbutton:button];
    }
}

@end
