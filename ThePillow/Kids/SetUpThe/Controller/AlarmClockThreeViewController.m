//
//  AlarmClockThreeViewController.m
//  Kids
//
//  Created by 陈镇池 on 2016/12/15.
//  Copyright © 2016年 chen_zhenchi_lehu. All rights reserved.
//

#import "AlarmClockThreeViewController.h"
#import "AlarmClockFourViewController.h"

@interface AlarmClockThreeViewController ()
{
    UILabel *chooseTitleLb;
}
@property (nonatomic,strong)NSMutableArray *btArray; //按钮数组
@property (nonatomic,strong)NSMutableArray *selectedBtArray; //选择按钮数组

@end

@implementation AlarmClockThreeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navSet:@"闹钟应该在一周的哪几天提醒"];
    
    _btArray = [NSMutableArray array];
    _selectedBtArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    //创建主页面
    [self createView];
}

#pragma mark 创建主页面
- (void)createView {
    
    
    //震动时间
    chooseTitleLb = [[UILabel alloc]init];
    chooseTitleLb.y = 50*Height;
    chooseTitleLb.textColor = MainColorDarkGrey;
    chooseTitleLb.font = [UIFont systemFontOfSize:18];
    chooseTitleLb.text = @"每天";
    // 根据字体得到NSString的尺寸
    CGSize chooseTitleLbSize = [chooseTitleLb.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:chooseTitleLb.font,NSFontAttributeName, nil]];
    chooseTitleLb.size = chooseTitleLbSize;
    [chooseTitleLb sizeToFit];
    [self.view addSubview:chooseTitleLb];
    chooseTitleLb.centerX = self.view.centerX;
    
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
    CGFloat spacing = (MainScreenWidth - 350*Width)/2;
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *nvBt = [UIButton buttonWithType:UIButtonTypeCustom];
        nvBt.frame = CGRectMake(spacing + i*50*Width, height_y(chooseTitleLb)+10*Height, 45*Width, 45*Width);
        nvBt.backgroundColor = MainColor;
        nvBt.titleLabel.font = [UIFont systemFontOfSize:16];
        nvBt.layer.cornerRadius = nvBt.width/2;
        nvBt.clipsToBounds = YES;
        [nvBt setTitleColor:MainColorWhite forState:UIControlStateNormal];
        [nvBt setTitleColor:MainColorLightGrey forState:UIControlStateSelected];
        [nvBt setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        nvBt.tag = i;
        [nvBt addTarget:self action:@selector(nvBTAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nvBt];
        [_btArray addObject:nvBt];

    }
    
    UIButton *nextBt = [self buildBtn:@"下一步" action:@selector(nextBtAction:) frame:CGRectMake(80*Width, MainScreenHeight-180*Height, MainScreenWidth-160*Width,50*Height)];
    [self.view addSubview:nextBt];
}


#pragma mark 导航按钮执行方法
- (void)nvBTAction:(UIButton *)button {
    
    

    if (button.selected == NO) {
        
        button.backgroundColor = MainColorWhite;
        button.selected = YES;
    }else {
        button.backgroundColor = MainColor;
        button.selected = NO;
    }
   
    _selectedBtArray = [[NSMutableArray alloc]init];
    NSMutableString *allTextStr = [NSMutableString string];
    for (int i= 0; i<_btArray.count; i++) {
        UIButton *bt = [_btArray objectAtIndex:i];
        if (i == 0) {
            if (!bt.selected) {
                [allTextStr appendFormat:@"周一"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==1) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周二"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==2) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周三"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==3) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周四"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==4) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周五"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==5) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周六"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }else if (i==6) {
            if (!bt.selected) {
                if (allTextStr.length!=0) {
                    [allTextStr appendFormat:@" "];
                }
                [allTextStr appendFormat:@"周日"];
                [_selectedBtArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }
        
    }
    if (_selectedBtArray.count == 7) {
        chooseTitleLb.text = @"每天";
    }else if (_selectedBtArray.count == 0) {
        chooseTitleLb.text = @"只响一次";
    }else {
        chooseTitleLb.text = allTextStr;
    }
    [chooseTitleLb sizeToFit];
    chooseTitleLb.centerX = self.view.centerX;

    
}

#pragma mark 下一步
- (void)nextBtAction:(UIButton *)button {
//    for (NSString *a in _selectedBtArray) {
//        NSLog(@"%@",a);
//    }
    AlarmClockFourViewController *alarmClockFourVC = [[AlarmClockFourViewController alloc]init];
    alarmClockFourVC.dateArray = _selectedBtArray;
    [self.navigationController pushViewController:alarmClockFourVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
