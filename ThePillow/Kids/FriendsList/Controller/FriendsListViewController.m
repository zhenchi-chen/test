//
//  FriendsListViewController.m
//  GOSPEL
//
//  Created by 陈镇池 on 16/5/30.
//  Copyright © 2016年 lehu. All rights reserved.
//

#import "FriendsListViewController.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"亲友列表";
    //设置导航栏的背景色,如果设置颜色,模糊效果会消失
    self.navigationController.navigationBar.barTintColor = RGB(77, 207, 199);
    
    
    self.view.backgroundColor = RGB(243, 244, 246);
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
