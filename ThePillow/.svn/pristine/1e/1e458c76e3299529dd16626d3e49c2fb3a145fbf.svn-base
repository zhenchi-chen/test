//
//  HowToUseViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/6/22.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "HowToUseViewController.h"
#import "MyScrollerView.h"

@interface HowToUseViewController ()

@end

@implementation HowToUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self navSet:NSLocalizedString(@"how_to_use_fragment_title",nil)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    float higt = self.view.frame.size.height - 64;//1, 设置高度
    float width = self.view.frame.size.width - 0;//2, 图片宽度
    float x = 0, y = 0;//3, 起点坐标
    
    
    MyScrollerView *myView = [[MyScrollerView alloc] initWithFrame:CGRectMake(x, y, width, higt)];
    //7 设置导航条颜色
    [myView setPageControlColor:MainColor color2:MainColorLightGrey];
    [self.view addSubview:myView];
    
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        
        [arr addObject:[NSString stringWithFormat:@"gprs_%d",i+1]];
    }
//            [myView addArray:arr];//不带缩放
    [myView addarrayScrollerView:arr];//带缩放
    
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
