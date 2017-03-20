//
//  SelectBluetoothView.h
//  GOSPEL
//
//  Created by 陈镇池 on 16/4/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectBluetoothViewDelegate <NSObject>

- (void)didSelectSelectBluetoothViewWithbutton:(UIButton *)button;

@end

@interface SelectBluetoothView : UIView

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *titleLb; //标题
@property (nonatomic,strong)UIButton *startBt; //开始/停止扫描
@property (nonatomic ,weak) id<SelectBluetoothViewDelegate> delegate;


@end
